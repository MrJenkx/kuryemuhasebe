use Illuminate\Support\Facades\Route;
use Illuminate\Support\Facades\Artisan;

Route::get('/run-migrations', function () {
    try {
        Artisan::call('migrate', ['--force' => true]);
        $output = Artisan::output(); // Çıktıyı al
        return '<pre>' . $output . '</pre>'; // HTML çıktısı
    } catch (\Exception $e) {
        return '<pre>HATA: ' . $e->getMessage() . "\n" . $e->getTraceAsString() . '</pre>';
    }
});
