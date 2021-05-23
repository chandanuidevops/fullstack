<?php

namespace App\Models;

// use App\Models\Blog;
use Illuminate\Support\Str;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use App\Models\Tag;
use App\Models\Category;
class Blog extends Model
{
    use HasFactory;
    // protected $guarded=[];
    protected $fillable = ['title','post', 'post_excerpt','slug','user_id','featuredImage','metaDescription','views','jsonData'];

    public function setSlugAttribute($val)
    {
        $this->attributes['slug']=$this->uniqueSlug($val);
    }
    public function uniqueSlug($val){
        $slug = trim(preg_replace("/[^\w\d]+/i","-",$val),"-");
        $count=Blog::where('slug','like',"%${slug}%")->count();
        $newCount = $count>0?++$count:'';
        return $newCount>0?"$slug-$newCount":$slug;
    }

    public function tag()
    {
        return $this->belongsToMany(Tag::class,'blog_tags');
    }
    public function cat()
    {
        return $this->belongsToMany(Category::class,'blog_categories');
    }
}
