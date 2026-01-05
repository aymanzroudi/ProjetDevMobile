<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class SavedSize extends Model
{
    use HasFactory;

    protected $fillable = [
        'user_id',
        'type',
        'diameter_mm',
        'circumference_mm',
        'standard',
        'label',
    ];

    public function user()
    {
        return $this->belongsTo(User::class);
    }
}
