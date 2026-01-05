<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class GoldPrice extends Model
{
    use HasFactory;

    protected $fillable = [
        'source',
        'base_currency',
        'price_per_ounce',
        'price_per_gram',
        'price_per_gram_mad',
        'karat',
        'collected_at',
    ];

    protected $casts = [
        'collected_at' => 'datetime',
    ];
}
