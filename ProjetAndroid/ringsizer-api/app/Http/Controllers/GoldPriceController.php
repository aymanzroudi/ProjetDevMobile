<?php

namespace App\Http\Controllers;

use App\Models\GoldPrice;
use Carbon\Carbon;
use Illuminate\Http\Request;

class GoldPriceController extends Controller
{
    public function latest()
    {
        $price = GoldPrice::orderByDesc('collected_at')
            ->orderByDesc('id')
            ->first();

        if (!$price) {
            return response()->json(['message' => 'No gold price data yet'], 404);
        }

        return $price;
    }

    public function history(Request $request)
    {
        $days = (int) $request->get('days', 30);
        $days = max(1, min($days, 180)); // clamp 1..180
        $karat = (int) $request->get('karat', 24);

        $since = Carbon::now()->subDays($days);

        $prices = GoldPrice::where('karat', $karat)
            ->where('collected_at', '>=', $since)
            ->orderBy('collected_at', 'asc')
            ->get();

        return $prices;
    }
}
