<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('gold_prices', function (Blueprint $table) {
            $table->id();
            $table->string('source')->default('goldapi');
            $table->string('base_currency')->default('USD');
            $table->decimal('price_per_ounce', 12, 4);
            $table->decimal('price_per_gram', 12, 4);
            $table->decimal('price_per_gram_mad', 12, 4)->nullable();
            $table->unsignedTinyInteger('karat')->default(24); // 24k price reference
            $table->timestamp('collected_at')->index();
            $table->timestamps();

            $table->index(['karat', 'collected_at']);
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('gold_prices');
    }
};
