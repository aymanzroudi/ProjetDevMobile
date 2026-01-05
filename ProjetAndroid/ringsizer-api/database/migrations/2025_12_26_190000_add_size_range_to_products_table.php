<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('products', function (Blueprint $table) {
            $table->decimal('size_min_mm', 6, 2)->nullable()->after('category');
            $table->decimal('size_max_mm', 6, 2)->nullable()->after('size_min_mm');
        });
    }

    public function down(): void
    {
        Schema::table('products', function (Blueprint $table) {
            $table->dropColumn(['size_min_mm', 'size_max_mm']);
        });
    }
};
