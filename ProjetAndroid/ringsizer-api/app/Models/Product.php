<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Product extends Model
{
    use HasFactory;

    protected $fillable = [
        'seller_id',
        'title',
        'description',
        'category',
        'size_min_mm',
        'size_max_mm',
        'karat',
        'weight_g',
        'price',
        'stock',
        'cover_image_path',
        'status',
    ];

    protected $casts = [
        'size_min_mm' => 'float',
        'size_max_mm' => 'float',
        'weight_g' => 'float',
        'price' => 'float',
        'stock' => 'integer',
        'karat' => 'integer',
    ];

    public function seller()
    {
        return $this->belongsTo(User::class, 'seller_id');
    }

    public function images()
    {
        return $this->hasMany(ProductImage::class);
    }

    public function favorites()
    {
        return $this->hasMany(Favorite::class);
    }

    public function cartItems()
    {
        return $this->hasMany(CartItem::class);
    }
}
