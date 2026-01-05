<?php

namespace Database\Seeders;

use App\Models\User;
use App\Models\SellerProfile;
use App\Models\Product;
use App\Models\GoldPrice;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Hash;
use Carbon\Carbon;

class DatabaseSeeder extends Seeder
{
    use WithoutModelEvents;

    /**
     * Seed the application's database.
     */
    public function run(): void
    {
        // Admin
        User::updateOrCreate(
            ['email' => 'admin@example.com'],
            [
                'name' => 'Admin',
                'password' => Hash::make('password'),
                'role' => 'admin',
            ]
        );

        // Seller + profile + product
        $seller = User::updateOrCreate(
            ['email' => 'seller@example.com'],
            [
                'name' => 'Seller Demo',
                'password' => Hash::make('password'),
                'role' => 'seller',
            ]
        );

        SellerProfile::updateOrCreate(
            ['user_id' => $seller->id],
            [
                'shop_name' => 'Demo Gold Shop',
                'phone' => '+212600000000',
                'city' => 'Casablanca',
            ]
        );

        Product::updateOrCreate(
            ['seller_id' => $seller->id, 'title' => 'Bague or 18k'],
            [
                'description' => 'Bague élégante en or 18 carats, 4g',
                'category' => 'ring',
                'karat' => 18,
                'weight_g' => 4.0,
                'price' => 3200,
                'stock' => 5,
                'status' => 'published',
            ]
        );

        GoldPrice::create([
            'source' => 'seed',
            'base_currency' => 'USD',
            'price_per_ounce' => 2300.00,
            'price_per_gram' => 2300.00 / 31.1034768,
            'price_per_gram_mad' => (2300.00 / 31.1034768) * 10.0, // approx
            'karat' => 24,
            'collected_at' => Carbon::now(),
        ]);
    }
}
