<?php

use Illuminate\Support\Facades\Route;

Route::inertia('/', 'welcome')->name('home');

Route::middleware(['auth', 'verified'])->group(function () {
    Route::inertia('dashboard', 'dashboard')->name('dashboard');
});

Route::get('/health', function () {
    return 'ok';
});

Route::get('/test', function () {
    return 'test';
});

require __DIR__.'/settings.php';
