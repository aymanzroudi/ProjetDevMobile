<?php

namespace App\Http\Controllers;

use App\Models\SavedSize;
use Illuminate\Http\Request;
use Illuminate\Validation\Rule;

class SavedSizeController extends Controller
{
    public function index(Request $request)
    {
        $user = $request->user();

        return SavedSize::where('user_id', $user->id)
            ->orderBy('type')
            ->get();
    }

    public function upsert(Request $request, string $type)
    {
        $user = $request->user();

        $data = $request->validate([
            'diameter_mm' => ['nullable', 'numeric', 'min:0'],
            'circumference_mm' => ['nullable', 'numeric', 'min:0'],
            'standard' => ['nullable', 'string', 'max:20'],
            'label' => ['nullable', 'string', 'max:255'],
        ]);

        $type = strtolower($type);
        if (!in_array($type, ['ring', 'bracelet'], true)) {
            return response()->json(['message' => 'Invalid type'], 422);
        }

        $saved = SavedSize::updateOrCreate(
            ['user_id' => $user->id, 'type' => $type],
            $data
        );

        return response()->json($saved);
    }

    public function destroy(Request $request, int $id)
    {
        $user = $request->user();

        $size = SavedSize::where('user_id', $user->id)->where('id', $id)->firstOrFail();
        $size->delete();

        return response()->json(['message' => 'Deleted']);
    }
}
