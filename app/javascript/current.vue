<template>
  <div id="">
      <p class="text-muted fs-5 fw-bold text-end"> .سجل اليوم  </p>
      <p v-if="loading"> جاري التحميل .... </p>
      <div v-for="user in users" :key="user.id">
         <div v-if="user.status == 2 || user.status == 5">
           
           <div v-if="user.status == 2"   class="bg-success text-white br-10 p-1 border-top mb-1">

              <p class="text-center fw-bold fs-6 mb-1"> دخول الان </p> 
              <p class="fw-bold fs-6 mb-1"> {{ user.name }} </p>
              <p class="fs-6">
                الموعد: 
                <span class="fw-bold text-uppercase"> {{ user.app_time | moment('hh:mm a') }} </span>
                <br>
                موعد الدخول:
                <span class="fw-bold text-uppercase"> {{ user.approval_time | moment('hh:mm a') }} </span>

              </p>
              <div class="d-grid">

                <button class="btn btn-warning fw-bold" @click="alreadyIn(user.id)"> تم الخروج </button>
              </div>

           </div>

           <div v-if="user.status == 5"   class="bg-light text-black br-10 p-1 border mb-1">
             
              <p class="text-center fw-bold fs-6 mb-1 text-success"> تم الدخول </p> 
              <p class="fw-bold fs-6 mb-1"> {{ user.name }} </p>
              <p class="fs-6">
                الموعد: 
                <span class="fw-bold text-uppercase"> {{ user.app_time | moment('hh:mm a') }} </span>
                <br>
                موعد الدخول:
                <span class="fw-bold text-uppercase"> {{ user.approval_time | moment('hh:mm a') }} </span>

              </p>
              <div class="d-grid">

                
              </div>


           </div>

         </div>
      </div>
    
  </div>
</template>

<script>
import axios from 'axios'

let devUrl = 'http://127.0.0.1:3000/appointments/'
let prodUrl = 'https://appmanager251.herokuapp.com/appointments/'

export default {
  data: function () {
    return {
      id: 0,
      users: [],
      loading: false
    }
  },
  channels: {
    AppointmentChannel: {
      connected() {
        console.log('connected from Current')
      },
      received(data) {
        console.log(data)
        this.id = data['id']
        axios.get(`${devUrl}${this.id}`).then(res => {
            console.log(res['data'])
            console.log('from here')
            this.users.splice(0, 0, res['data'])
        })
        let audio = new Audio(require('./audios/to-the-point.mp3'))
        audio.play()
      },
      disconnected() {}
    }
  },
  methods: {
    alreadyIn(id) {
      axios.patch(`${devUrl}${id}/already_in`, { status: 5 }).then(res => {
        if(res['data']['success'] == true) {
          this.users.find( user => user.id == id ).status = 5
          delete this.users.find( user => user.id == id )
        }
      })
    }
  },
  mounted () {
    this.$cable.subscribe({
      channel: 'AppointmentChannel'
    })

    this.loading = true
    axios.get('appointments/today_approve/today').then(res => {
      this.loading = false
      this.users = res['data']
    })
    
  }
}
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>
