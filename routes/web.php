<?php

use App\Http\Middleware\AdminCheck;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/
Route::prefix('app')->middleware(['admin.check'])->group(function(){
    Route::post('/create_tag',['App\Http\Controllers\AdminController','addTag']);
    Route::post('/update_tag',['App\Http\Controllers\AdminController','updateTag']);
    Route::post('/delete_tag',['App\Http\Controllers\AdminController','deleteTag']);
    Route::get('/get_tags',['App\Http\Controllers\AdminController','getTag']);
    Route::post('/upload_category',['App\Http\Controllers\AdminController','uploadCategory']);
    Route::post('/delete_icon',['App\Http\Controllers\AdminController','deleteIcon']);
    Route::post('/create_category',['App\Http\Controllers\AdminController','createCategory']);
    Route::get('/get_category',['App\Http\Controllers\AdminController','getCategory']);
    Route::post('/delete_category',['App\Http\Controllers\AdminController','deleteCategory']);
    Route::post('/update_category',['App\Http\Controllers\AdminController','updateCategory']);
    Route::post('/create_user',['App\Http\Controllers\AdminController','addUser']);
    Route::get('/get_users',['App\Http\Controllers\AdminController','getUsers']);
    Route::post('/update_user',['App\Http\Controllers\AdminController','updateUser']);
    Route::post('/delete_user',['App\Http\Controllers\AdminController','deleteUser']);
    Route::post('/create_role',['App\Http\Controllers\AdminController','addRole']);
    Route::post('/update_role',['App\Http\Controllers\AdminController','updateRole']);
    Route::post('/delete_role',['App\Http\Controllers\AdminController','deleteRole']);
    Route::get('/get_roles',['App\Http\Controllers\AdminController','getRole']);
    Route::post('/admin_login',['App\Http\Controllers\AdminController','adminLogin']);
    Route::post('/assign_roles',['App\Http\Controllers\AdminController','assignRoles']);
    Route::post('/create-blog',['App\Http\Controllers\AdminController','createBlog']);
    Route::post('/update-blog/{id}',['App\Http\Controllers\AdminController','updateBlog']);
    Route::get('/blogData',['App\Http\Controllers\AdminController','blogData']);
    Route::post('/delete_blog',['App\Http\Controllers\AdminController','deleteBlog']);
    Route::get('/single_blog/{id}',['App\Http\Controllers\AdminController','singleBlogItem']);

});
Route::post('createBlog',['App\Http\Controllers\AdminController','uploadEditorImage']);

Route::get('slug',['App\Http\Controllers\AdminController','slug']);
Route::get('/', ['App\Http\Controllers\AdminController','index']);
Route::get('/logout', ['App\Http\Controllers\AdminController','user_logout']);
Route::any('{slugs}',['App\Http\Controllers\AdminController','index'])->where('slugs', "([A-z\d/]+)?");


