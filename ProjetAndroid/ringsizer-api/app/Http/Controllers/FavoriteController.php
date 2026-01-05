<?php

namespace App\Http\Controllers;

use App\Models\Favorite;
use Illuminate\Http\Request;

class FavoriteController extends Controller
{
    public function index(Request $request)
    {
        $user = $request->user();

        return Favorite::with('product.images', 'product.seller', 'product.seller.sellerProfile')
            ->where('user_id', $user->id)
            ->orderByDesc('id')
            ->get();
    }

    public function store(Request $request)
    {
        $user = $request->user();

        $data = $request->validate([
            'product_id' => ['required', 'integer', 'exists:products,id'],
        ]);

        $favorite = Favorite::firstOrCreate([
            'user_id' => $user->id,
            'product_id' => $data['product_id'],
        ]);

        return response()->json($favorite, 201);
    }

    public function destroy(Request $request, int $productId)
    {
        $user = $request->user();

        Favorite::where('user_id', $user->id)
            ->where('product_id', $productId)
            ->delete();

        return response()->json(['message' => 'Removed']);
    }
}
