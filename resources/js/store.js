import Vue from 'vue'
import Vuex, { mapGetters } from 'vuex'
Vue.use(Vuex)
export default new Vuex.Store({
    state:{
         counter:100,
            deleteModalObj:{
            showDeleteModal: false,
            deleteUrl:'',
            data:{},
            isDeleted:false,
            deletingIndex:-1
         },
         user:false,
         userPermission:null
     },
     getters:{
        getCounter(state){
            return state.counter
        },
        getDeletedModalObj(state){
            return state.deleteModalObj
        },
        getUserPermission(state){
            return state.userPermission
        }
     }, 
     mutations:{
        changeTheCounter(state,data){
            state.counter+=data
        },
        setDeletedModal(state,data){
            const deleteModalObj={
                showDeleteModal: false,
                deleteUrl:'',
                data:{},
                isDeleted:data,
                deletingIndex:state.deleteModalObj.deletingIndex
             }
            state.deleteModalObj=deleteModalObj
        },
        setDeletingModalObj(state,data){
            state.deleteModalObj=data
        },
        updateUser(state,data){
            state.user=data
        },
        setUserPermission(state,data){
            state.userPermission=data
        }
     },
     actions:{
        changeCounterAction({commit},data){
            commit('changeTheCounter',data)
        },
        
     },
    
 })