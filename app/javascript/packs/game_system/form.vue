<template>
  <div>
    <div>
      <label for="gs.name">Name</label>
      <input v-model="gs.name"><br>
      <label for="gs.slug">Slug</label>
      <input v-model="gs.slug"><br>
      <label for="gs.publisher">Publisher</label>
      <input v-model="gs.publisher"><br>
      <label for="gs.description">Description</label><br>
      <textarea v-model="gs.description"></textarea><br>
    </div>
    <div>
      <ul>
        <li v-for="section, index in sections">
          <sectionForm :id="index" :parentId="gsId" parentType="gs" :section.sync="section" v-on:section-remove="removeSection($event)"></sectionForm>
          <hr>
        </li>
      </ul>
    </div>
    <button @click="addSection">Add Section</button>
    <button v-if="new_gs" @click="create">Create</button>
    <button v-else @click="update">Update</button>
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
      'gsSections': Array,
      'new_gs': Boolean
    },
    data: function() {
      // console.log()
      return {
        gsId: this.gs._id.$oid,
        sections: this.gsSections
      }
    },
    created: function() {
      // console.log(this.gsSections);
    },
    methods: {
      create: function() {
        this.gs.sections = this.sections;
        this.$http.post('/game_systems', this.gs).then(function(r) {
          // Turbolinks.clearCache();
          // Turbolinks.visit(`/game_systems`, { "action": "replace" });
        });
      },
      update: function() {
        this.gs.sections = this.sections;
        this.$http.patch(`/game_systems/${this.gsId}`, this.gs).then(function(r) {
          // Turbolinks.clearCache();
          // Turbolinks.visit(`/game_systems/${this.gsId}`, { "action": "replace" });
        });
      },
      addSection: function() {
        if (this.sections.length < 1) {
          this.sections = [];
        };
        this.sections.push({
          name: '',
          keep: false,
          child_sections: [],
          keys: [],
          traits: []
        });
      },
      removeSection: function(e) {
        this.sections.splice(e, 1);
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
