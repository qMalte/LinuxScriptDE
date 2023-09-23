<?php

use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "web" middleware group. Make something great!
|
*/

Route::get('/', function () {
    return view('welcome');
});
Route::get('/imprint', function () {
    return view('imprint');
});
Route::get('/privacy', function () {
    return view('privacy');
});

Route::get('/use-root', function () {
    return \Illuminate\Support\Facades\Response::download(storage_path('app/scripts/EnsureLoggedInAsAdmin.sh'));
});
Route::get('/open-browser-at-boot', function () {
    return \Illuminate\Support\Facades\Response::download(storage_path('app/scripts/openBrowserAtBoot.sh'));
});
Route::get('/install-nodejs', function () {
    return \Illuminate\Support\Facades\Response::download(storage_path('app/scripts/installNodeJS.sh'));
});
Route::get('/install-signalk', function () {
    return \Illuminate\Support\Facades\Response::download(storage_path('app/scripts/installSignalK.sh'));
});
Route::get('/install-mariadb', function () {
    return \Illuminate\Support\Facades\Response::download(storage_path('app/scripts/installMariaDB.sh'));
});
Route::get('/set-splash-screen', function () {
    return \Illuminate\Support\Facades\Response::download(storage_path('app/scripts/setSplashImage.sh'));
});
Route::get('/myship', function () {
    return \Illuminate\Support\Facades\Response::download(storage_path('app/scripts/myship-toolkit.sh'));
});
