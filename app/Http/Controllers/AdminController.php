<?php

namespace App\Http\Controllers;

use App\Models\Tag;
use App\Models\Blog;
use App\Models\Role;
use App\Models\User;
use App\Models\BlogTag;
use App\Models\Category;
use App\Models\BlogCategory;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Auth;

class AdminController extends Controller
{
    public function index(Request $request)
    {
        
        
       if(!Auth::check() && $request->path()!='login'){
         return  redirect('/login');
       }
       if(Auth::check() && $request->path()=='login'){
      
         return redirect('/');
       }
       $user= Auth::user();
       return $this->checkForPermission($user ,$request);
    }
    public function checkForPermission($user, $request)
    {
        if($user){
            $permission=json_decode($user->role->permission);
            $hasPermission = false;
            if($permission){
                foreach($permission as $p){
                    if($p->name==$request->path()){
                        
                        if($p->read){
                            $hasPermission = true;
                        }
                    }
                }
                if($hasPermission){
                    return view('welcome');
                }else{
                    return view('welcome');
                    // return view('page-not-found');
                }
            }else{
                return view('welcome');
            }
        }else{
            return view('welcome');
        }
    }
    // public function checkForPermission($user, $request)
    // {
    //     $permission = json_decode($user->role->permission);
    //     $hasPermission = false;
    //     if (!$permission) {
    //         return view('welcome');
    //     }

    //     foreach ($permission as $p) {
    //         if ($p->name == $request->path()) {
    //             if ($p->read) {
    //                 $hasPermission = true;
    //             }
    //         }
    //     }
    //     if ($hasPermission) {
    //         return view('welcome');
    //     }

    //     return view('welcome');
    //     // return view('notfound');
    // }
    public function user_logout(Request $request)
    {
 
       Auth::logout();
       return redirect('/login');;
    }
    public function addTag(Request $request)
    {
        $this->validate($request,[
            'tagName'=>'required',
        ]);
        return Tag::create([
            'tagName'=>$request->tagName,
        ]);
    }
    public function updateTag(Request $request)
    {
        $this->validate($request,[
            'tagName'=>'required',
            'id'=>'required',
        ]);
        return Tag::where('id',$request->id)->update([
            'tagName'=>$request->tagName,
        ]);
    }
    public function deleteTag(Request $request)
    {
        $this->validate($request,[
            'id'=>'required',
        ]);
        return Tag::where('id',$request->id)->delete();
    }
    public function getTag()
    {
        return Tag::orderBy('id','desc')->get();
    }
    public function uploadCategory(Request $request)
    {
        $this->validate($request,[
            'file'=>'required|mimes:jpg,jpeg,png'
        ]);
        $picName= time().'.'.$request->file->extension();
        $request->file->move(public_path('uploads'),$picName);
        return $picName;
    }
    public function uploadEditorImage(Request $request)
    {
        $this->validate($request,[
            'image'=>'required|mimes:jpg,jpeg,png'
        ]);
        $picName= time().'.'.$request->image->extension();
        $request->image->move(public_path('uploads'),$picName);
        return response()->json([
            'success'=>1,
            'file'=>[
                'url'=>env('APP_URL').'uploads/'.$picName,
            ],
        ]);
        return $picName;
    }
    public function deleteIcon(Request $request)
    {
        $filePath=public_path().$request->iconImage;
        // return $filePath;
        $this->deleteServerFile($filePath);
        return 'done';
    }
    public function deleteServerFile($file)
    {
        if(file_exists($file)){
            @unlink($file);
        }
    }
    public function createCategory(Request $request)
    {
        $this->validate($request,[
            'categoryName'=>'required',
            'iconImage'=>'required',
        ]);
        return Category::create([
            'categoryName'=>$request->categoryName,
            'iconImage'=>$request->iconImage,
        ]);
    }
    public function getCategory()
    {
        return Category::orderBy('id','desc')->get();
    }
    
    public function deleteCategory(Request $request)
    {
        $this->validate($request,[
            'id'=>'required',
        ]);
        if(file_exists(public_path().$request->iconImage)){
            @unlink(public_path().$request->iconImage);
        }
        return Category::where('id',$request->id)->delete();
    }
    public function updateCategory(Request $request)
    {
        $this->validate($request,[
            'categoryName'=>'required',
            'iconImage'=>'required',
            'id'=>'required',
        ]);
        return Category::where('id',$request->id)->update([
            'categoryName'=>$request->categoryName,
            'iconImage'=>$request->iconImage,
        ]);
    }
    public function addUser(Request $request)
    {
        $this->validate($request,[
            'fullName'=>'required',
            'email'=>'bail|required|email|unique:users',
            'password'=>'required|min:6',
            'role_id'=>'required',
        ]);
        return User::create([
            'fullName'=>$request->fullName,
            'email'=>$request->email,
            'password'=>bcrypt($request->password),
            'role_id'=>$request->role_id,
        ]);
    }
    public function getUsers()
    {
        return User::orderBy('id','desc')->get();
    }
    public function updateUser(Request $request)
    {
        $this->validate($request,[
            'fullName'=>'required',
            'email'=>"bail|required|email|unique:users,email,$request->id",
            'password'=>'min:6',
            'role_id'=>'required',
        ]);
        $data=[
            'fullName'=>$request->fullName,
            'email'=>$request->email,
            'role_id'=>$request->role_id,
        ];
        if($request->password){
            $data['password']=bcrypt($request->password);
        }
        return User::where('id',$request->id)->update( $data);
    }
    public function deleteUser(Request $request)
    {
        $this->validate($request,[
            'id'=>'required',
        ]);
        return User::where('id',$request->id)->delete();
    }
    public function adminLogin(Request $request)
    {
        $this->validate($request,[
            'email'=>"bail|required|email",
            'password'=>'required|min:6',
        ]);
        if(Auth::attempt(['email'=>$request->email,'password'=>$request->password])){
            $user=Auth::user();
            if($user->role->isAdmin==0){
                Auth::logout();
                return response()->json(['msg'=>'Incorrect Login Details'],401);
            }
            return response()->json(['msg'=>'You Have Logged in'],200);
        }else{
            return response()->json(['msg'=>'Incorrect Login Details'],401);
        }
    }
    public function addRole(Request $request)
    {
        $this->validate($request,[
            'roleName'=>'required',
        ]);
        return Role::create([
            'roleName'=>$request->roleName,
        ]);
    }
    public function updateRole(Request $request)
    {
        $this->validate($request,[
            'roleName'=>'required',
            'id'=>'required',
        ]);
        return Role::where('id',$request->id)->update([
            'roleName'=>$request->roleName,
        ]);
    }
    public function deleteRole(Request $request)
    {
        $this->validate($request,[
            'id'=>'required',
        ]);
        return Role::where('id',$request->id)->delete();
    }
    public function getRole()
    {
        return Role::orderBy('id','desc')->get();
    }
    public function assignRoles(Request $request)
    {
        $this->validate($request,[
            'permission'=>'required',
            'id'=>'required',
        ]);
        return Role::where('id',$request->id)->update([
            'permission'=>$request->permission
        ]);
    }
    public function slug()
    {
        $title='this is title';
        return Blog::create([
            'title'=>$title,
            'post'=>'this is post',
            'post_excerpt'=>'afdsfsd',
            'user_id'=>1,
            'metaDescription'=>'afdsfsd',
            'featuredImage'=>'afdsfsd',
            'slug'=>'this-is-slug'
         
        ]);
        return $title;
    }
    //create blog
    public function createBlog(Request $request)
    {
        $this->validate($request, [
            'title' => 'required',
            'post' => 'required',
            'post_excerpt' => 'required',
            'metaDescription' => 'required',
            'jsonData' => 'required',
            'category_id' => 'required',
            'tag_id' => 'required',
        ]);
        $categories = $request->category_id;
        $tags = $request->tag_id;
        $blogCategories = [];
        $blogTags = [];
        try {
            DB::beginTransaction();
            $blog = Blog::create([
                'title' => $request->title,
                'slug' => $request->title,
                'post' => $request->post,
                'post_excerpt' => $request->post_excerpt,
                'user_id' => Auth::user()->id,
                'metaDescription' => $request->metaDescription,
                'jsonData' => $request->jsonData,
            ]);
            // insert blog categories
            foreach ($categories as $c) {
                array_push($blogCategories, ['category_id' => $c, 'blog_id' => $blog->id]);
            }
            BlogCategory::insert($blogCategories);
    
             // insert blog tags
             foreach ($tags as $t) {
                array_push($blogTags, ['tag_id' => $t, 'blog_id' => $blog->id]);
            }
            BlogTag::insert($blogTags);
            DB::commit();
            return 'done';
        } catch (\Throwable $th) {
            DB::rollback();
            return 'not done';
        }
       
    }
    //update blog
    public function updateBlog(Request $request,$id)
    {
 
        $this->validate($request, [
            'title' => 'required',
            'post' => 'required',
            'post_excerpt' => 'required',
            'metaDescription' => 'required',
            'jsonData' => 'required',
            'category_id' => 'required',
            'tag_id' => 'required',
        ]);
        $categories = $request->category_id;
        $tags = $request->tag_id;
        $blogCategories = [];
        $blogTags = [];
       
        try {
            DB::beginTransaction();
            $blog = Blog::where('id',$id)->update([
                'title' => $request->title,
                'slug' => $request->title,
                'post' => $request->post,
                'post_excerpt' => $request->post_excerpt,
                'user_id' => Auth::user()->id,
                'metaDescription' => $request->metaDescription,
                'jsonData' => $request->jsonData,
            ]);
          
           
            // insert blog categories
            foreach ($categories as $c) {
                array_push($blogCategories, ['category_id' => $c, 'blog_id' => $id]);
            }
            BlogCategory::where('blog_id',$id)->delete();
           
            BlogCategory::insert($blogCategories);
             // insert blog tags
             foreach ($tags as $t) {
                array_push($blogTags, ['tag_id' => $t, 'blog_id' => $id]);
            }
            BlogTag::where('blog_id',$id)->delete();
            BlogTag::insert($blogTags);
            DB::commit();
            return 'done';
        } catch (\Throwable $th) {
            return $th;
            DB::rollback(); 

            return response()->json(['errors'=>'server error'],500);
        }
       
    }
    public function blogData(Request $request)
    {
        return Blog::with(['tag','cat'])->orderBy('id','desc')->paginate($request->total);
    }
    function deleteBlog(Request $request){
        return  Blog::where('id',$request->id)->delete();
    }
    public function singleBlogItem(Request $request,$id)
    {
        // dd($id);
        return Blog::with(['tag','cat'])->where('id',$id)->first();
    }

}
