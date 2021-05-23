<template>
    <div>
        <div class="content">
            <div class="container-fluid">
                <!--~~~~~~~ TABLE ONE ~~~~~~~~~-->
                <div
                    class="_1adminOverveiw_table_recent _box_shadow _border_radious _mar_b30 _p20"
                >
                    <p class="_title0">
                       Update Blogs
                    </p>
                    <div class="_input_field">
                        <Input
                            type="text"
                            v-model="data.title"
                            placeholder="Title"
                        />
                    </div>
                    <div class="_overflow _table_div blog_editor">
                        <editor v-if="initData"
                            ref="editor"
                            :headers="{
                                'x-csrf-token': token,
                                'X-Requested-With': 'XMLHttpRequest'
                            }"
                            :config="config"
                            autofocus
                            @save="onSave"
                            :init-data="initData"
                        />
                    </div>
                    <div class="_input_field">
                        <Input
                            type="textarea"
                            v-model="data.post_excerpt"
                            :rows="4"
                            placeholder="Post excerpt "
                        />
                    </div>
                    <div class="_input_field">
                        <Select
                            filterable
                            multiple
                            placeholder="Select category"
                            v-model="data.category_id"
                        >
                            <Option
                                v-for="(c, i) in category"
                                :value="c.id"
                                :key="i"
                                >{{ c.categoryName }}</Option
                            >
                        </Select>
                    </div>
                    <div class="_input_field">
                        <Select
                            filterable
                            multiple
                            placeholder="Select tag"
                            v-model="data.tag_id"
                        >
                            <Option
                                v-for="(t, i) in tag"
                                :value="t.id"
                                :key="i"
                                >{{ t.tagName }}</Option
                            >
                        </Select>
                    </div>
                    <div class="_input_field">
                        <Input
                            type="textarea"
                            v-model="data.metaDescription"
                            :rows="4"
                            placeholder="Meta description"
                        />
                    </div>
                    <div class="_input_field">
                        <Button
                            type="primary"
                            @click="saved"
                            :loading="isCreating"
                            :disabled="isCreating"
                            >{{
                                isCreating ? "Please wait..." : "Update  blog"
                            }}</Button
                        >
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>
<script>
export default {
    data() {
        return {
            config: {
                image: {
                    endpoints: {
                        byFile: "http://127.0.0.1:8000/createBlog",
                        byUrl: "http://127.0.0.1:8000/createBlog"
                    },
                    field: "image",
                    types: "image/*"
                }
            },
            initData: null,
            token: null,
            data: {
                title: "",
                post: "",
                post_excerpt: "",
                metaDescription: "",
                category_id: [],
                tag_id: [],
                jsonData: null
            },
            category: [],
            tag: [],
            isCreating: false
        };
    },
    methods: {
        async onSave(response) {
            let url = `app/update-blog/${this.$route.params.id}`
            console.log(url)
            var data = response;
            console.log(data);
            await this.outputHtml(data.blocks);
            this.data.post = this.articleHTML;
            this.data.jsonData = JSON.stringify(data);
            if (this.data.post.trim() == "")
                return this.error("Post is required");
            if (this.data.title.trim() == "")
                return this.error("Title is required");
            if (this.data.post_excerpt.trim() == "")
                return this.error("Post exerpt is required");
            if (this.data.metaDescription.trim() == "")
                return this.error("Meta description is required");
            this.isCreating = true;
            const res = await this.callApi(
                "post",
                `/app/update-blog/${this.$route.params.id}`,
                this.data
            );
            if (res.status === 200) {
                this.success("Blog has been created successfully!");
                this.$router.push("/blogs");
            } else {
                if (res.status == 422) {
                    for (let i in res.data.errors) {
                        this.error(res.data.errors[i][0]);
                    }
                } else {
                    this.swr();
                }
            }
            this.isCreating = false;
        },
        async saved() {
            const res = await this.$refs.editor.save();
        },
        outputHtml(articleObj) {
            articleObj.map(obj => {
                switch (obj.type) {
                    case "paragraph":
                        this.articleHTML += this.makeParagraph(obj);
                        break;
                    case "image":
                        this.articleHTML += this.makeImage(obj);
                        break;
                    case "header":
                        this.articleHTML += this.makeHeader(obj);
                        break;
                    case "raw":
                        this.articleHTML += `<div class="ce-block">
					<div class="ce-block__content">
					<div class="ce-code">
						<code>${obj.data.html}</code>
					</div>
					</div>
				</div>\n`;
                        break;
                    case "code":
                        this.articleHTML += this.makeCode(obj);
                        break;
                    case "list":
                        this.articleHTML += this.makeList(obj);
                        break;
                    case "quote":
                        this.articleHTML += this.makeQuote(obj);
                        break;
                    case "warning":
                        this.articleHTML += this.makeWarning(obj);
                        break;
                    case "checklist":
                        this.articleHTML += this.makeChecklist(obj);
                        break;
                    case "embed":
                        this.articleHTML += this.makeEmbed(obj);
                        break;
                    case "delimeter":
                        this.articleHTML += this.makeDelimeter(obj);
                        break;
                    default:
                        return "";
                }
            });
        }
    },
    async created() {
        const id= parseInt(this.$route.params.id)
        console.log(id)
        if(!id)  {
           return this.$router.push('/notfound')
        }
        const [blog, cat, tag] = await Promise.all([
            this.callApi("get", `/app/single_blog/${id}`),
            this.callApi("get", "/app/get_category"),
            this.callApi("get", "/app/get_tags")
        ]);
        if (cat.status == 200) {
            if(!blog.data) return this.$router.push('/notfound') 
            this.initData=JSON.parse(blog.data.jsonData)
            this.category = cat.data;
            this.tag = tag.data;
            for(let t of blog.data.tag){
                this.data.tag_id.push(t.id)
            }
             for(let c of blog.data.cat){
                this.data.category_id.push(c.id)
            }
            this.data.title = blog.data.title
            this.data.post_excerpt = blog.data.post_excerpt
            this.data.metaDescription = blog.data.metaDescription
           
        } else {
            this.swr();
        }
    }
};
</script>
<style>
.blog_editor {
    width: 717px;
    margin-left: 160px;
    padding: 4px 7px;
    font-size: 14px;
    border: 1px solid #dcdee2;
    border-radius: 4px;
    color: #515a6e;
    background-color: #fff;
    background-image: none;
  z-index: 0;
    position: relative;
}
.blog_editor:hover {
    border: 1px solid #57a3f3;
}
._input_field {
    margin: 20px 0 20px 160px;
    width: 717px;
}
</style>
