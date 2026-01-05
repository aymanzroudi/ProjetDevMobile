<?php

namespace App\Http\Controllers;

use App\Models\CartItem;
use Illuminate\Http\Request;

class CartController extends Controller
{
    public function index(Request $request)
    {
        $user = $request->user();

        return CartItem::with('product.images', 'product.seller', 'product.seller.sellerProfile')
            ->where('user_id', $user->id)
            ->orderByDesc('id')
            ->get();
    }

    public function add(Request $request)
    {
        $user = $request->user();

        $data = $request->validate([
            'product_id' => ['required', 'integer', 'exists:products,id'],
            'quantity' => ['nullable', 'integer', 'min:1', 'max:99'],
        ]);

        $qty = (int) ($data['quantity'] ?? 1);

        $item = CartItem::where('user_id', $user->id)
            ->where('product_id', $data['product_id'])
            ->first();

        if ($item) {
            $item->quantity = min(99, $item->quantity + $qty);
            $item->save();
            return response()->json($item);
        }

        $item = CartItem::create([
            'user_id' => $user->id,
            'product_id' => $data['product_id'],
            'quantity' => $qty,
        ]);

        return response()->json($item, 201);
    }

    public function update(Request $request, int $productId)
    {
        $user = $request->user();

        $data = $request->validate([
            'quantity' => ['required', 'integer', 'min:1', 'max:99'],
        ]);

        $item = CartItem::where('user_id', $user->id)
            ->where('product_id', $productId)
            ->firstOrFail();

        $item->quantity = (int) $data['quantity'];
        $item->save();

        return response()->json($item);
    }

    public function remove(Request $request, int $productId)
    {
        $user = $request->user();

        CartItem::where('user_id', $user->id)
            ->where('product_id', $productId)
            ->delete();

        return response()->json(['message' => 'Removed']);
    }

    public function clear(Request $request)
    {
        $user = $request->user();

        CartItem::where('user_id', $user->id)->delete();

        return response()->json(['message' => 'Cleared']);
    }
}
