<template>
  <div id="">
      <div class="bg-success p-3 br-10 border text-white">
          <p class="fw-bold"> جاري الاجتماع ب </p>
          <h6 class="fw-bold"> {{ user.name }} </h6>
          <p > 
             الجهه:
            <span v-if="user.from == 1">
                داخل الاداره
            </span>  
            <span v-if="user.from == 2">
                خارج الاداره
            </span>
            </p>

            <p > 
            الاداره:
            <span v-if="user.department === ''">
                غير متوفر
            </span>

            <span v-if="user.department !== ''">
                {{ user.department }}
            </span>

            </p>

            <p > 
            سبب المقابله:
            <br><br>
            <span v-if="user.description === ''">
                غير متوفر
            </span>

            <span v-if="user.description !== ''">
                {{ user.description }}
            </span>  
        
            </p>

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
      user: null
    }
  },
  channels: {
    AppointmentChannel: {
      connected() {
        console.log('connected from Manager')
      },
      received(data) {
        console.log(data)
        this.id = data['id']
        axios.get(`${devUrl}${this.id}`).then(res => {
            console.log(res['data'])
            this.user = res['data']
        })
      },
      disconnected() {}
    }
  },
  mounted () {
    this.$cable.subscribe({
      channel: 'AppointmentChannel'
    })
  }
}
</script>


<style scoped>

</style>
