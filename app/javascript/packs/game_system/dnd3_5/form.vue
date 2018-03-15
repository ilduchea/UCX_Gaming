<template>
  <div>
    <div class="info">
      <div class="col-sm-4">
        <div class="col-sm-12">
          <input v-model="char.name"><br>
          <label for="char.name">Character Name</label><br>
          <input v-model="char.cs_class_level"><br>
          <label for="char.cs_class_level">Class and Level</label><br>
        </div>
        <div class="col-sm-3">
          <input v-model="char.cs_size"><br>
          <label for="char.cs_size">Size</label>
        </div>
        <div class="col-sm-3">
          <input v-model="char.cs_age"><br>
          <label for="char.cs_age">Age</label>
        </div>
        <div class="col-sm-3">
          <input v-model="char.cs_gender"><br>
          <label for="char.cs_gender">Gender</label>
        </div>
        <div class="col-sm-3">
          <input v-model="char.cs_height"><br>
          <label for="char.cs_height">Height</label>
        </div>
      </div>

      <div class="col-sm-4">
        <div class="col-sm-12">
          <input v-model="char.player_name"><br>
          <label for="char.player_name">Player Name</label>
        </div>
        <div class="col-sm-4">
          <input v-model="char.cs_race"><br>
          <label for="char.cs_race">Race</label>
        </div>
        <div class="col-sm-4">
          <input v-model="char.cs_alignment"><br>
          <label for="char.cs_alignment">Alignment</label>
        </div>
        <div class="col-sm-4">
          <input v-model="char.cs_deity"><br>
          <label for="char.cs_deity">Deity</label>
        </div>
        <div class="col-sm-3">
          <input v-model="char.cs_weight"><br>
          <label for="char.cs_weight">Weight</label>
        </div>
        <div class="col-sm-3">
          <input v-model="char.cs_eyes"><br>
          <label for="char.cs_eyes">Eyes</label>
        </div>
        <div class="col-sm-3">
          <input v-model="char.cs_hair"><br>
          <label for="char.cs_hair">Hair</label>
        </div>
        <div class="col-sm-3">
          <input v-model="char.cs_skin"><br>
          <label for="char.cs_skin">Skin</label>
        </div>
      </div>

      <div class="col-sm-4 height-spacer">
        <button v-if="new_char" v-on:click="createChar">Create</button>
        <button v-else v-on:click="updateChar">Save</button>
      </div>
    </div>

    <div class="col-sm-4">
      <div class="col-sm-3">
        <p>ABILITY NAME</p>
        <div class="inverse">
          <strong>STR</strong>
          <p>STRENGTH</p>
        </div>
        <div class="inverse">
          <strong>DEX</strong>
          <p>DEXTERITY</p>
        </div>
        <div class="inverse">
          <strong>CON</strong>
          <p>CONSTITUTION</p>
        </div>
        <div class="inverse">
          <strong>INT</strong>
          <p>INTELLIGENCE</p>
        </div>
        <div class="inverse">
          <strong>WIS</strong>
          <p>WISDOM</p>
        </div>
        <div class="inverse">
          <strong>CHA</strong>
          <p>CHARISMA</p>
        </div>
      </div>
      <div class="col-sm-2">
        <p class="no-margin">ABILITY SCORE</p>
        <input v-model="char.cs_str" type="number" min="0" max="45" step="1" @change="updateStatMod(char.cs_str, 'str_mod')">
        <input v-model="char.cs_dex" type="number" min="0" max="45" step="1" @change="updateStatMod(char.cs_dex, 'dex_mod')">
        <input v-model="char.cs_con" type="number" min="0" max="45" step="1" @change="updateStatMod(char.cs_con, 'con_mod')">
        <input v-model="char.cs_int" type="number" min="0" max="45" step="1" @change="updateStatMod(char.cs_int, 'int_mod')">
        <input v-model="char.cs_wis" type="number" min="0" max="45" step="1" @change="updateStatMod(char.cs_wis, 'wis_mod')">
        <input v-model="char.cs_cha" type="number" min="0" max="45" step="1" @change="updateStatMod(char.cs_cha, 'cha_mod')">
      </div>
      <div class="col-sm-2">
        <p class="no-margin">ABILITY MODIFIER</p>
        <input v-model="str_mod" type="number" disabled>
        <input v-model="dex_mod" type="number" disabled>
        <input v-model="con_mod" type="number" disabled>
        <input v-model="int_mod" type="number" disabled>
        <input v-model="wis_mod" type="number" disabled>
        <input v-model="cha_mod" type="number" disabled>
      </div>
      <div class="col-sm-1"></div>
      <div class="col-sm-2 no-margin">
        <p class="no-margin">TEMPORARY SCORE</p>
        <div class="dark-highlight">
          <input v-model="char.cs_temp_str" type="number" max="45" step="1" @change="updateStatMod(char.cs_temp_str, 'temp_str_mod')">
          <input v-model="char.cs_temp_dex" type="number" max="45" step="1" @change="updateStatMod(char.cs_temp_dex, 'temp_dex_mod')">
          <input v-model="char.cs_temp_con" type="number" max="45" step="1" @change="updateStatMod(char.cs_temp_con, 'temp_con_mod')">
          <input v-model="char.cs_temp_int" type="number" max="45" step="1" @change="updateStatMod(char.cs_temp_int, 'temp_int_mod')">
          <input v-model="char.cs_temp_wis" type="number" max="45" step="1" @change="updateStatMod(char.cs_temp_wis, 'temp_wis_mod')">
          <input v-model="char.cs_temp_cha" type="number" max="45" step="1" @change="updateStatMod(char.cs_temp_cha, 'temp_cha_mod')">
        </div>
      </div>
      <div class="col-sm-2 no-margin">
        <p class="no-margin">TEMPORARY MODIFIER</p>
        <div class="dark-highlight">
          <input v-model="temp_str_mod" type="number" disabled>
          <input v-model="temp_dex_mod" type="number" disabled>
          <input v-model="temp_con_mod" type="number" disabled>
          <input v-model="temp_int_mod" type="number" disabled>
          <input v-model="temp_wis_mod" type="number" disabled>
          <input v-model="temp_cha_mod" type="number" disabled>
        </div>
      </div>
    </div>
    <div class="col-sm-7 row-margin">
      <div class="row">
        <div class="inverse col-sm-2 hp">
          <strong>HP</strong>
          <p>HIT POINTS</p>
        </div>
        <div class="col-sm-2">
          <p>TOTAL</p>
          <input v-model="char.cs_hp">
        </div>
        <div class="col-sm-2">
          <p>WOUNDS/CURRENT HP</p>
          <input v-model="char.cs_current_hp">
        </div>
        <div class="col-sm-2">
          <p>NONLETHAL DAMAGE</p>
          <input v-model="char.cs_nonlethal_dmg">
        </div>
        <div class="col-sm-1 dmg-reduction">
          <p>DAMAGE REDUCTION</p>
          <input v-model="char.cs_dmg_reduction">
        </div>
        <div class="col-sm-2">
          <p><b>SPEED</b></p>
          <input v-model="char.cs_speed">
        </div>
      </div>
      <div class="row ac">
        <div class="inverse col-sm-2 hp">
          <strong>AC</strong>
          <p>ARMOR CLASS</p>
        </div>
        <div class="col-sm-2 ">
          <input v-model="char.cs_ac" class="total">
          <span>= 10 +</span>
          <p>TOTAL</p>
        </div>
        <div class="col-sm-1">
          <input v-model="char.cs_armor_bonus">
          <span>+</span>
          <p>ARMOR BONUS</p>
        </div>
        <div class="col-sm-1">
          <input v-model="char.cs_shield_bonus">
          <span>+</span>
          <p>SHIELD BONUS</p>
        </div>
        <div class="col-sm-1">
          <input v-if="temp_dex_mod === ''" v-model="dex_mod" class="dex_mod" disabled>
          <input v-else v-model="temp_dex_mod" class="dex_mod" disabled>
          <span>+</span>
          <p>DEX MODIFIER</p>
        </div>
        <div class="col-sm-1">
          <input v-model="char.cs_size_mod">
          <span>+</span>
          <p>SIZE MODIFIER</p>
        </div>
        <div class="col-sm-1">
          <input v-model="char.cs_natural_armor">
          <span>+</span>
          <p>NATURAL ARMOR</p>
        </div>
        <div class="col-sm-1">
          <input v-model="char.cs_deflection_mod">
          <span>+</span>
          <p>DEFLECTION MODIFIER</p>
        </div>
        <div class="col-sm-1">
          <input v-model="char.cs_misc_ac_mod">
          <p>MISC MODIFIER</p>
        </div>
      </div>
    </div>
    <div class="col-sm-3 row-margin">
      <div class="row">
        <div class="inverse touch-ac">
          <strong>TOUCH</strong>
          <p>ARMOR CLASS</p>
        </div>
        <input v-model="char.cs_touch_ac">
        <div class="inverse ff-ac">
          <strong>FLAT-FOOTED</strong>
          <p>ARMOR CLASS</p>
        </div>
        <input v-model="char.cs_ff_ac">
      </div>
    </div>
    <div class="col-sm-4">

    </div>
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
    'char': Object,
    'charSections': Array,
    'new_char': Boolean
  },
  data: function() {
    // console.log()
    return {
      gsId: this.gs._id.$oid,
      charId: this.char._id.$oid,
      sections: this.charSections,
      stats: this.gsSections.find(this.findSection('stats')),
      str_mod: '',
      dex_mod: '',
      con_mod: '',
      int_mod: '',
      wis_mod: '',
      cha_mod: '',
      temp_str_mod: '',
      temp_dex_mod: '',
      temp_con_mod: '',
      temp_int_mod: '',
      temp_wis_mod: '',
      temp_cha_mod: ''
    }
  },
  created: function() {
    console.log('sections: ', this.sections);
    console.log('char: ', this.char);
    this.setCharStats();
  },
  methods: {
    createChar: function() {
      this.char.sections = this.sections;
      this.$http.post(`/game_systems/${this.gsId}/characters`, this.char).then(function(r) {
        // Turbolinks.clearCache();
        // Turbolinks.visit(`/game_systems/${this.gsId}`, { "action": "replace" });
      });
    },
    updateChar: function() {
      this.char.sections = this.sections;
      this.$http.patch(`/game_systems/${this.gsId}/characters/${this.char._id.$oid}`, this.char).then(function(r) {
        // Turbolinks.clearCache();
        // Turbolinks.visit(`/game_systems/${this.gsId}`, { "action": "reload" });
      });
    },
    setCharStats: function() {
      if (this.char._id) {
        this.updateStatMod(this.char.cs_str, 'str_mod');
        this.updateStatMod(this.char.cs_dex, 'dex_mod');
        this.updateStatMod(this.char.cs_con, 'con_mod');
        this.updateStatMod(this.char.cs_int, 'int_mod');
        this.updateStatMod(this.char.cs_wis, 'wis_mod');
        this.updateStatMod(this.char.cs_cha, 'cha_mod');
      }
    },
    findSection: function(name) {
      return function(e) {
        return e.name === name;
      }
    },
    findStatScore: function(score) {
      return function(e) {
        return e.sec_score === score;
      }
    },
    updateStatMod: function(value, name) {
      if (value === '') {
        this[name] = '';
      } else {
        this[name] = Math.floor(value / 2) - 5;
      }
    },
    addSection: function() {
      // if (this.sections.length < 1) {
      //   this.sections = [];
      // };
      // this.sections.push({
      //   name: '',
      //   keep: false,
      //   child_sections: [],
      //   keys: [],
      //   traits: []
      // });
    },
    removeSection: function(e) {
      this.sections.splice(e, 1);
    }
  }
}
</script>

<style scoped>
input {
  width: 100%;
}

input[type="number"] {
  margin-bottom: 15px;
  text-align: center;
}

select {
  height: 30px;
  margin-bottom: 11px;
}

ul {
  list-style-type: none;
}

.inverse {
  background-color: #000;
  color: #f1f1f1;
  text-align: center;
}

.inverse strong {
  font-size: 1em;
}

p {
  font-size: .6em;
  text-align: center;
}

.no-margin {
  margin: 0;
  padding: 0;
}

.height-spacer {
  height: 153px;
}

.fake-input {
  border: 2px inset;
  height: 30px;
  margin: 0px 3px 11px 3px;
  background-color: #d1d1d1;
  font-size: 1.15em;
  line-height: 27px;
  font-weight: bold;
  text-align: center;
}

.dark-highlight {
  background-color: #555;
  padding: 1px;
}

.hp {
  height: 32px;
  margin-top: 16px;
  margin-right: 5px;
}

.ac span {
  height: 32px;
  line-height: 28px;
}

.ac input {
  width: 75%;
  margin-top: 16px;
}

.ac input.total {
  width: 50%;
}

.dmg-reduction input {
  margin-top: 0px;
  height: 25px;
}

.dmg-reduction p {
  margin-bottom: 0px;
}

.row-margin {
  margin-left: 30px;
}

.touch-ac {
  width: 70px;
  display: inline-block;
}

.ff-ac {
  width: 110px;
  display: inline-block;
}

.touch-ac + input, .ff-ac + input {
  width: 40px;
}

</style>
