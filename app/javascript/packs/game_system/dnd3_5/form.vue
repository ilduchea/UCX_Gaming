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

      <div class="col-sm-4 height-spacer"></div>
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
        <select v-model="char.cs_str" v-on:change="updateStatMod(char.cs_str, 'cs_str_mod')">
          <option v-for="stat in stats.child_sections" :value="stat">
            {{ stat['sec_score'] }}
          </option>
        </select>
        <select v-model="char.cs_dex" v-on:change="updateStatMod(char.cs_dex, 'cs_dex_mod')">
          <option v-for="stat in stats.child_sections" :value="stat">
            {{ stat['sec_score'] }}
          </option>
        </select>
        <select v-model="char.cs_con" v-on:change="updateStatMod(char.cs_con, 'cs_con_mod')">
          <option v-for="stat in stats.child_sections" :value="stat">
            {{ stat['sec_score'] }}
          </option>
        </select>
        <select v-model="char.cs_int" v-on:change="updateStatMod(char.cs_int, 'cs_int_mod')">
          <option v-for="stat in stats.child_sections" :value="stat">
            {{ stat['sec_score'] }}
          </option>
        </select>
        <select v-model="char.cs_wis" v-on:change="updateStatMod(char.cs_wis, 'cs_wis_mod')">
          <option v-for="stat in stats.child_sections" :value="stat">
            {{ stat['sec_score'] }}
          </option>
        </select>
        <select v-model="char.cs_cha" v-on:change="updateStatMod(char.cs_cha, 'cs_cha_mod')">
          <option v-for="stat, index in stats.child_sections" :value="stat" v-bind:selected="index === 0 ? 'selected' : false">
            {{ stat['sec_score'] }}
          </option>
        </select>
      </div>
      <div class="col-sm-2">
        <p class="no-margin">ABILITY MODIFIER</p>
        <div id="cs_str_mod" class="fake-input"></div>
        <div id="cs_dex_mod" class="fake-input"></div>
        <div id="cs_con_mod" class="fake-input"></div>
        <div id="cs_int_mod" class="fake-input"></div>
        <div id="cs_wis_mod" class="fake-input"></div>
        <div id="cs_cha_mod" class="fake-input"></div>
      </div>
      <div class="col-sm-1"></div>
      <div class="col-sm-2 no-margin">
        <p class="no-margin">TEMPORARY SCORE</p>
        <div class="dark-highlight">
          <select v-model="char.cs_temp_str" v-on:change="updateStatMod(char.cs_temp_str, 'cs_temp_str_mod')">
            <option value="none" selected="true">n/a</option>
            <option v-for="stat in stats.child_sections" :value="stat">
              {{ stat['sec_score'] }}
            </option>
          </select>
          <select v-model="char.cs_temp_dex" v-on:change="updateStatMod(char.cs_temp_dex, 'cs_temp_dex_mod')">
            <option value="none" selected="true">n/a</option>
            <option v-for="stat in stats.child_sections" :value="stat">
              {{ stat['sec_score'] }}
            </option>
          </select>
          <select v-model="char.cs_temp_con" v-on:change="updateStatMod(char.cs_temp_con, 'cs_temp_con_mod')">
            <option value="none" selected="true">n/a</option>
            <option v-for="stat in stats.child_sections" :value="stat">
              {{ stat['sec_score'] }}
            </option>
          </select>
          <select v-model="char.cs_temp_int" v-on:change="updateStatMod(char.cs_temp_int, 'cs_temp_int_mod')">
            <option value="none" selected="true">n/a</option>
            <option v-for="stat in stats.child_sections" :value="stat">
              {{ stat['sec_score'] }}
            </option>
          </select>
          <select v-model="char.cs_temp_wis" v-on:change="updateStatMod(char.cs_temp_wis, 'cs_temp_wis_mod')">
            <option value="none" selected="true">n/a</option>
            <option v-for="stat in stats.child_sections" :value="stat">
              {{ stat['sec_score'] }}
            </option>
          </select>
          <select v-model="char.cs_temp_cha" v-on:change="updateStatMod(char.cs_temp_cha, 'cs_temp_cha_mod')">
            <option value="none" selected="true">n/a</option>
            <option v-for="stat, index in stats.child_sections" :value="stat" v-bind:selected="index === 0 ? 'selected' : false">
              {{ stat['sec_score'] }}
            </option>
          </select>
        </div>
      </div>
      <div class="col-sm-2 no-margin">
        <p class="no-margin">TEMPORARY MODIFIER</p>
        <div class="dark-highlight">
          <div id="cs_temp_str_mod" class="fake-input"></div>
          <div id="cs_temp_dex_mod" class="fake-input"></div>
          <div id="cs_temp_con_mod" class="fake-input"></div>
          <div id="cs_temp_int_mod" class="fake-input"></div>
          <div id="cs_temp_wis_mod" class="fake-input"></div>
          <div id="cs_temp_cha_mod" class="fake-input"></div>
        </div>
      </div>
    </div>
    <div class="col-sm-1"></div>
    <div class="col-sm-7">
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
        <div class="col-sm-1"></div>
        <div class="col-sm-2">
          <p><b>SPEED</b></p>
          <input v-model="char.cs_speed">
        </div>
      </div>
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
    'charSections': Array
  },
  data: function() {
    // console.log()
    return {
      gsId: this.gs._id.$oid,
      charId: this.char._id.$oid,
      sections: this.charSections,
      stats: this.gsSections.find(this.findSectionStats)
    }
  },
  created: function() {
    // console.log(this.gsSections);
    // console.log(this.stats);
  },
  methods: {
    findSectionStats: function(e) {
      if (e.name === 'stats') return e;
    },
    findStatsScore: function(e) {
      if (e.name === 'stats') return e;
    },
    updateStatMod: function(value, name) {
      if (value === 'none') {
        $(`#${name}`).text('');
      } else {
        $(`#${name}`).text(`${value.sec_mod}`);
      }
    },
    create: function() {
      this.char.sections = this.sections;
      this.$http.post(`/game_systems/${this.gsId}/characters`, this.char);
    },
    update: function() {
      this.char.sections = this.sections;
      this.$http.patch(`/game_systems/${this.gsId}/characters/${this.charId}`, this.char);
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

</style>