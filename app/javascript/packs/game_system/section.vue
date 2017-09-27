<template>
  <div>
    <label for="section.name">Name</label>
    <input v-model="section.name">
    <label for="section.keep">Keep</label>
    <input type="checkbox" v-model="section.keep">
    <ul>
      <li v-for="trait in section.traits">
        <label for="trait.name">Name</label>
        <input v-model="trait.name"><br>
        <label for="trait.property">Property</label>
        <input v-model="trait.property"><br>
      </li>
    </ul>
    <ul>
      <li v-for="section in section.child_sections">
        <sectionForm v-bind:section="section"></sectionForm>
      </li>
    </ul>
    <button v-on:click="addTrait(section)">Add Trait</button>
    <button v-on:click="addChildSection(section)">Add Child Section</button>
  </div>
</template>

<script>
  import Vue from 'vue';

  export default {
    name: 'sectionForm',
    props: {
      'section': Object
    },
    data: function() {
      return {
        
      }
    },
    methods: {
      addChildSection: function(section) {
        section.child_sections.push({
          name: '',
          keep: false,
          traits: [],
          child_sections: []
        });
      },
      addTrait: function(section) {
        section.traits.push({
          name: '',
          property: ''
        });
      }
    }
  }
</script>

<style scoped>
  label {
    text-align: center;
    color: purple;
  }
  ul {
    list-style-type: none;
  }
  .col-2 {
    width: 50%;
  }
  .row {
    display: flex;
  }

</style>