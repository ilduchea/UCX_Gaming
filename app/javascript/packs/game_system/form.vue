<template>
  <div>
    <div>
      <label for="name">Name</label>
      <input v-model="name"><br>
      <label for="publisher">Publisher</label>
      <input v-model="publisher"><br>
      <label for="description">Description</label><br>
      <textarea v-model="description"></textarea><br>
    </div>
    <div>
      <ul>
        <li v-for="section in sections">
          <sectionForm v-bind:section="section"></sectionForm>
        </li>
      </ul>
    </div>
    <button v-on:click="addSection">Add Section</button>
    <button v-if="new_gs" v-on:click="create">Create</button>
    <button v-else v-on:click="update">Update</button>
  </div>
</template>

<script>
  import Vue from 'vue';
  import VueResource from 'vue-resource';
  import SectionForm from './section.vue';

  Vue.use(VueResource);

  export default {
    components: {
      'sectionForm': SectionForm
    },
    props: {
      'gs': Object,
      'new_gs': Boolean,
      'edit': Boolean
    },
    data: function() {
      // console.log()
      return {
        name: this.gs.name,
        publisher: this.gs.publisher,
        description: this.gs.description,
        sections: []
      }
    },
    methods: {
      create: function() {
        this.$http.post('/game_systems', {
          name: this.name,
          publisher: this.publisher,
          description: this.description,
          sections: this.sections
        });
      },
      update: function() {
        this.$http.patch(`/game_systems/${this.gs._id.$oid}`, {
          name: this.name,
          publisher: this.publisher,
          description: this.description,
          sections: this.sections
        });
      },
      addSection: function() {
        this.sections.push({
          name: '',
          keep: false,
          traits: [],
          child_sections: []
        });
      }
    }
  }
</script>

<style scoped>
  label {
    text-align: center;
    color: crimson;
  }
  ul {
    list-style-type: none;
  }
</style>