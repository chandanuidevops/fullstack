<template>
    <div>
        <!-- delete alert modal -->
         <Modal :value="getDeletedModalObj.showDeleteModal"
            :mask-closable="false"
			:closable="false"
          width="360">
            <p slot="header" style="color:#f60;text-align:center">
                <Icon type="ios-information-circle"></Icon>
                <span>Delete confirmation</span>
            </p>
            <div style="text-align:center">
                <p>Will you delete it?</p>
            </div>
            <div slot="footer">
                <Button type="default" size="large"  @click="closeModal" >Close</Button>
                <Button type="error" size="large"   :loading="isDeleting" :disabled="isDeleting" @click="deleteData">Delete</Button>
               
            </div>
        </Modal>
    </div>
</template>
<script>
import {mapGetters} from 'vuex'
export default {
    data(){
        return {
             isDeleting: false,
             
        }
    },
    methods:{
        async deleteData(){
             this.isDeleting=true
                const res = await this.callApi('post',this.getDeletedModalObj.deleteUrl,this.getDeletedModalObj.data)
                if(res.status==200){
                    this.success('Item deleted successfully')
                    this.$store.commit('setDeletedModal',true)
                }else{
                    this.swr()
                    this.$store.commit('setDeletedModal',false)
                }
                this.isDeleting=false
            },
        closeModal(){
            this.$store.commit('setDeletedModal', false)
        }
    },
    computed:{
        ...mapGetters(['getDeletedModalObj'])
    }
}
</script>

<style>

</style>
