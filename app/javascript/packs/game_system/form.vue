<template>
  <div>
    <input v-model="gs.name">
    <p>{{ gs.name }}</p>
    <button v-on:click="submit">Submit</button>

  </div>
</template>

<script>
  export default {
    props: [
      'gs'
    ],
    data: function() {
      return {
        
      }
    },
    methods: {
      submit: function() {
        this.$http.post('/game_systems', { gs });
      }
    }
  }
</script>

<style scoped>
  p {
    font-size: 2em;
    text-align: center;
  }
</style>