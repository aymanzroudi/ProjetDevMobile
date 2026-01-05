<?php

namespace App\Http\Controllers;

use App\Models\Product;
use App\Models\ProductImage;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Storage;

class ProductController extends Controller
{
    public function index(Request $request)
    {
        $query = Product::with('images', 'seller', 'seller.sellerProfile')
            ->where('status', 'published');

        if ($request->filled('karat')) {
            $query->where('karat', $request->integer('karat'));
        }
        if ($request->filled('category')) {
            $query->where('category', $request->get('category'));
        }
        if ($request->filled('min_price')) {
            $query->where('price', '>=', $request->get('min_price'));
        }
        if ($request->filled('max_price')) {
            $query->where('price', '<=', $request->get('max_price'));
        }

        return $query->orderByDesc('id')->paginate(20);
    }

    public function show(Product $product)
    {
        $product->load('images', 'seller', 'seller.sellerProfile');
        return $product;
    }

    public function store(Request $request)
    {
        $user = Auth::user();
        if (!in_array($user->role, ['seller', 'admin'])) {
            return response()->json(['message' => 'Unauthorized'], 403);
        }

        $data = $request->validate([
            'title' => 'required|string|max:255',
            'description' => 'nullable|string',
            'category' => 'nullable|string|max:100',
            'size_min_mm' => 'nullable|numeric|min:0',
            'size_max_mm' => 'nullable|numeric|min:0',
            'karat' => 'required|integer|min:1|max:24',
            'weight_g' => 'nullable|numeric|min:0',
            'price' => 'required|numeric|min:0',
            'stock' => 'required|integer|min:0',
            'status' => 'nullable|string|in:draft,published,archived',
        ]);

        $data['seller_id'] = $user->id;
        $product = Product::create($data);

        return response()->json($product, 201);
    }

    public function update(Request $request, Product $product)
    {
        $user = Auth::user();
        if (!in_array($user->role, ['seller', 'admin'])) {
            return response()->json(['message' => 'Unauthorized'], 403);
        }
        if ($user->role === 'seller' && $product->seller_id !== $user->id) {
            return response()->json(['message' => 'Forbidden'], 403);
        }

        $data = $request->validate([
            'title' => 'sometimes|string|max:255',
            'description' => 'nullable|string',
            'category' => 'nullable|string|max:100',
            'size_min_mm' => 'nullable|numeric|min:0',
            'size_max_mm' => 'nullable|numeric|min:0',
            'karat' => 'sometimes|integer|min:1|max:24',
            'weight_g' => 'nullable|numeric|min:0',
            'price' => 'sometimes|numeric|min:0',
            'stock' => 'sometimes|integer|min:0',
            'status' => 'sometimes|string|in:draft,published,archived',
            'cover_image_path' => 'nullable|string|max:255',
        ]);

        $product->update($data);

        return response()->json($product);
    }

    public function destroy(Product $product)
    {
        $user = Auth::user();
        if (!in_array($user->role, ['seller', 'admin'])) {
            return response()->json(['message' => 'Unauthorized'], 403);
        }
        if ($user->role === 'seller' && $product->seller_id !== $user->id) {
            return response()->json(['message' => 'Forbidden'], 403);
        }

        $product->delete();
        return response()->json(['message' => 'Deleted']);
    }

    public function addImage(Request $request, Product $product)
    {
        $user = Auth::user();
        if (!in_array($user->role, ['seller', 'admin'])) {
            return response()->json(['message' => 'Unauthorized'], 403);
        }
        if ($user->role === 'seller' && $product->seller_id !== $user->id) {
            return response()->json(['message' => 'Forbidden'], 403);
        }

        $data = $request->validate([
            'path' => 'required|string|max:255',
            'position' => 'nullable|integer|min:0',
        ]);

        $data['product_id'] = $product->id;
        $image = ProductImage::create($data);

        return response()->json($image, 201);
    }

    public function uploadCoverImage(Request $request, Product $product)
    {
        $user = Auth::user();
        if (!in_array($user->role, ['seller', 'admin'])) {
            return response()->json(['message' => 'Unauthorized'], 403);
        }
        if ($user->role === 'seller' && $product->seller_id !== $user->id) {
            return response()->json(['message' => 'Forbidden'], 403);
        }

        $data = $request->validate([
            'image' => 'required|file|image|max:8192',
        ]);

        $path = $request->file('image')->store('products', 'public');
        $product->cover_image_path = 'storage/' . $path;
        $product->save();

        $product->load('images', 'seller');
        return response()->json($product);
    }
}
