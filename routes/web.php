<?php

use Illuminate\Support\Facades\Route;
use Illuminate\Support\Facades\Artisan; // EN ÜSTE ALINDI ✅

Route::get('/', function () {
    return view('welcome');
});

Route::get('/run-migrations', function () {
    Artisan::call('migrate', ['--force' => true]);
    return 'Migration tamamlandı.';
});
