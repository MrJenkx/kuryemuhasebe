Route::get('/run-migrations', function () {
    try {
        Artisan::call('migrate', ['--force' => true]);
        return 'Migration tamamlandı.';
    } catch (\Exception $e) {
        return 'HATA: ' . $e->getMessage();
    }
});
