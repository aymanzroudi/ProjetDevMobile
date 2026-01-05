<?php

namespace App\Services;

use App\Models\GoldPrice;
use Illuminate\Support\Facades\Http;

class GoldPriceService
{
    private const OUNCE_TO_GRAM = 31.1034768;

    public function fetchAndStore(): ?GoldPrice
    {
        $apiKey = env('GOLDAPI_KEY');
        if (!$apiKey) {
            return null;
        }

        $baseUrl = rtrim(env('GOLDAPI_BASE', 'https://www.goldapi.io/api'), '/');
        $baseCurrency = env('GOLDAPI_BASE_CURRENCY', 'USD');

        $response = Http::timeout(20)
            ->withHeaders([
                'x-access-token' => $apiKey,
                'Content-Type' => 'application/json',
            ])
            ->get("{$baseUrl}/XAU/{$baseCurrency}");

        if (!$response->successful()) {
            return null;
        }

        $data = $response->json();
        $pricePerOunce = $data['price'] ?? null; // price per ounce in base currency
        if (!$pricePerOunce) {
            return null;
        }

        $pricePerGram = $pricePerOunce / self::OUNCE_TO_GRAM;
        $usdToMad = $this->fetchUsdToMadRate();
        $pricePerGramMad = $pricePerGram * $usdToMad;

        return GoldPrice::create([
            'source' => 'goldapi',
            'base_currency' => $baseCurrency,
            'price_per_ounce' => $pricePerOunce,
            'price_per_gram' => $pricePerGram,
            'price_per_gram_mad' => $pricePerGramMad,
            'karat' => 24,
            'collected_at' => now(),
        ]);
    }

    private function fetchUsdToMadRate(): float
    {
        $fallback = 10.0; // approx fallback
        $response = Http::timeout(15)->get('https://api.exchangerate.host/latest', [
            'base' => 'USD',
            'symbols' => 'MAD',
        ]);

        if ($response->successful()) {
            $data = $response->json();
            $rate = $data['rates']['MAD'] ?? null;
            if ($rate && $rate > 0) {
                return (float) $rate;
            }
        }

        return $fallback;
    }
}
