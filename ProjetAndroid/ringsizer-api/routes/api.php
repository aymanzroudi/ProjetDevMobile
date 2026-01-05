<?php

use App\Http\Controllers\AuthController;
use App\Http\Controllers\CartController;
use App\Http\Controllers\FavoriteController;
use App\Http\Controllers\GoldPriceController;
use App\Http\Controllers\ProductController;
use App\Http\Controllers\SavedSizeController;
use Illuminate\Support\Facades\Route;

Route::post('auth/register', [AuthController::class, 'register']);
Route::post('auth/login', [AuthController::class, 'login']);

Route::get('products', [ProductController::class, 'index']);
Route::get('products/{product}', [ProductController::class, 'show']);

Route::get('gold/latest', [GoldPriceController::class, 'latest']);
Route::get('gold/history', [GoldPriceController::class, 'history']);

Route::middleware('auth:sanctum')->group(function () {
    Route::post('auth/logout', [AuthController::class, 'logout']);

    // Measurements (saved sizes)
    Route::get('me/sizes', [SavedSizeController::class, 'index']);
    Route::put('me/sizes/{type}', [SavedSizeController::class, 'upsert']);
    Route::delete('me/sizes/{id}', [SavedSizeController::class, 'destroy']);

    // Favorites
    Route::get('me/favorites', [FavoriteController::class, 'index']);
    Route::post('me/favorites', [FavoriteController::class, 'store']);
    Route::delete('me/favorites/{productId}', [FavoriteController::class, 'destroy']);

    // Cart
    Route::get('cart', [CartController::class, 'index']);
    Route::post('cart', [CartController::class, 'add']);
    Route::put('cart/{productId}', [CartController::class, 'update']);
    Route::delete('cart/{productId}', [CartController::class, 'remove']);
    Route::delete('cart', [CartController::class, 'clear']);

    Route::post('products', [ProductController::class, 'store']);
    Route::put('products/{product}', [ProductController::class, 'update']);
    Route::patch('products/{product}', [ProductController::class, 'update']);
    Route::delete('products/{product}', [ProductController::class, 'destroy']);
    Route::post('products/{product}/images', [ProductController::class, 'addImage']);
    Route::post('products/{product}/upload-image', [ProductController::class, 'uploadCoverImage']);
});
