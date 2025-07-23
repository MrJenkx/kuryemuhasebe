<?php

use Illuminate\Support\Facades\Route;
use Illuminate\Support\Facades\Artisan;

Route::get('/', function () {
    return view('welcome');
});

Route::get('/run-migrations', function () {
    try {
        Artisan::call('migrate', ['--force' => true]);
        $output = Artisan::output();
        return '<pre>' . $output . '</pre>';
    } catch (\Exception $e) {
        return '<pre>HATA: ' . $e->getMessage() . "\n" . $e->getTraceAsString() . '</pre>';
    }
});
