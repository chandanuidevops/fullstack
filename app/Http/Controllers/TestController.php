<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class TestController extends Controller
{
    public function index(Type $var = null)
    {
        return response()->json(
            ['msg'=>'Json response']
        );
    }
    public function test(Type $var = null)
    {
        return response()->json(['msg'=>'Json response'],422);
    }
}
