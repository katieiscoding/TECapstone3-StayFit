<template>
  <section>
    <div class="container text-center">
      <div class="row justify-content-center">
        <div class="col-12">
          <form>
            <div class="display-4 my-4">Choose your exercise filters</div>
            <div class="row d-md-none">
              <div class="col-lg-6 col-xs-12">
                <div class="row">
                  <div class="col">
                    <p class="mb-1">Legs</p>
                    <label class="switch">
                      <input type="checkbox" v-model="filterLegs" />
                      <span class="slider round"></span>
                    </label>
                  </div>
                  <div class="col">
                    <p class="mb-1">Back</p>
                    <label class="switch">
                      <input type="checkbox" v-model="filterLegs" />
                      <span class="slider round"></span>
                    </label>
                  </div>
                </div>
              </div>
              <div class="col-lg-6 col-xs-12 my-3">
                <div class="row">
                  <div class="col">
                    <p class="mb-1">Arms</p>
                    <label class="switch">
                      <input type="checkbox" v-model="filterLegs" />
                      <span class="slider round"></span>
                    </label>
                  </div>
                  <div class="col">
                    <p class="mb-1">Cardio</p>
                    <label class="switch">
                      <input type="checkbox" v-model="filterLegs" />
                      <span class="slider round"></span>
                    </label>
                  </div>
                  <div class="col">
                    <p class="mb-1">Abs</p>
                    <label class="switch">
                      <input type="checkbox" v-model="filterLegs" />
                      <span class="slider round"></span>
                    </label>
                  </div>
                  <div class="col">
                    <p class="mb-1">Whole Body</p>
                    <label class="switch">
                      <input type="checkbox" v-model="filterLegs" />
                      <span class="slider round"></span>
                    </label>
                  </div>
                </div>
              </div>
            </div>
            <table
              class="table d-none d-md-inline"
              style="border: none; color: white;"
            >
              <tr style="border: none;">
                <td style="border: none;">Legs</td>
                <td style="border: none;">Back</td>
                <td style="border: none;">Arms</td>
                <td style="border: none;">Cardio</td>
                <td style="border: none;">Abs</td>
                <td style="border: none;">Whole Body</td>
              </tr>
              <tr style="border: none;">
                <td style="border: none;">
                  <label class="switch">
                    <input type="checkbox" v-model="filterLegs" />
                    <span class="slider round"></span>
                  </label>
                </td>
                <td style="border: none;">
                  <label class="switch">
                    <input type="checkbox" v-model="filterBack" />
                    <span class="slider round"></span>
                  </label>
                </td>
                <td style="border: none;">
                  <label class="switch">
                    <input type="checkbox" v-model="filterArms" />
                    <span class="slider round"></span>
                  </label>
                </td>
                <td style="border: none;">
                  <label class="switch">
                    <input type="checkbox" v-model="filterCardio" />
                    <span class="slider round"></span>
                  </label>
                </td>
                <td style="border: none;">
                  <label class="switch">
                    <input type="checkbox" v-model="filterAbs" />
                    <span class="slider round"></span>
                  </label>
                </td>
                <td style="border: none;">
                  <label class="switch">
                    <input type="checkbox" v-model="filterWholeBody" />
                    <span class="slider round"></span>
                  </label>
                </td>
              </tr>
            </table>

            <div></div>
          </form>

          <table class="table table-striped">
            <thead>
              <tr>
                <th class="text-left col-1">Name</th>
                <th class="text-center">Target</th>
                <th class="text-center">Sets</th>
                <th class="text-center">Reps</th>
                <th class="text-center">Time</th>
                <th class="text-center" v-if="admin"></th>
                <th class="text-center" v-if="admin"></th>
              </tr>
            </thead>
            <tbody>
              <tr
                v-for="e in this.exercises"
                v-bind:key="e.id"
                v-show="
                  filterExerciseBodyPart(e.bodyTargetId) &&
                    filterExerciseTime(e.time)
                "
              >
                <td class="text-left">{{ e.name }}</td>
                <td class="text-center">
                  {{ bodyTargetIdToWord(e.bodyTargetId) }}
                </td>
                <td class="text-center">{{ e.sets }}</td>
                <td class="text-center">{{ e.reps }}</td>
                <td class="text-center">{{ e.time }}</td>
                <td v-if="admin" class="text-center">
                  <router-link
                    v-bind:to="{ name: 'edit', params: { id: e.id } }"
                  >
                    <i class="fas fa-edit" alt="edit"></i>
                  </router-link>
                </td>
                <td v-if="admin" class="text-center">
                  <i
                    class="fas fa-trash-alt"
                    alt="delete"
                    v-on:click="deleteExercise(e)"
                  ></i>
                </td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>
    </div>
  </section>
</template>



<script>


import exerciseService from "@/services/ExerciseService";
export default {
  data() {
    return {
      exercises: [],
      filterExercises: [true, true, true, true, true, true, true],
      filterArms: true,
      filterBack: true,
      filterCardio: true,
      filterWholeBody: true,
      filterLegs: true,
      filterAbs: true,
      maxLength: 99999,
    };
  },
  created() {
    this.getExercises();
  },
  methods: {
    bodyTargetIdToWord(id) {
      switch (id) {
        case 1:
          return "Legs";
        case 2:
          return "Back";
        case 3:
          return "Arms";
        case 4:
          return "Cardio";
        case 5:
          return "Whole Body";
        case 6:
          return "Abs";
        default:
          return "Other";
      }
    },
    getExercises() {
      exerciseService.listExercises().then((response) => {
        this.exercises = response.data;
        this.exercises.forEach((e) => {
          switch (e.body_target_id) {
            case 1:
              e.body_target = "Legs";
              break;
            case 2:
              e.body_target = "Back";
              break;
            case 3:
              e.body_target = "Arms";
              break;
            case 4:
              e.body_target = "Cardio";
              break;
            case 5:
              e.body_target = "Whole Body";
              break;
            case 6:
              e.body_target = "Abs";
              break;
            default:
              e.body_target = "Other";
          }
        });
        
      });
    },
   
    deleteExercise(exercise) {
      exerciseService
        .deleteExercise(exercise)
        .then((response) => {
          if (response.status === 204) {
            alert("Exercise successfully deleted.");
            this.getExercises();
          }
        })
        .catch((error) => {
          alert("Cannot delete exercises that are saved in workouts!");
          this.handleErrorResponse(error, "adding");
        });
      exerciseService.listExercises().then((response) => {
        this.exercises = response.data;
        this.exercises.forEach((e) => {
          switch (e.body_target_id) {
            case 1:
              e.body_target = "Legs";
              break;
            case 2:
              e.body_target = "Back";
              break;
            case 3:
              e.body_target = "Arms";
              break;
            case 4:
              e.body_target = "Cardio";
              break;
            case 5:
              e.body_target = "Whole Body";
              break;
            case 6:
              e.body_target = "Abs";
              break;
            default:
              e.body_target = "Other";
          }
        });
      }); 
    },
    filterExerciseBodyPart(e) {
      switch (e) {
        case 1:
          return this.filterLegs;
        case 2:
          return this.filterBack;
        case 3:
          return this.filterArms;
        case 4:
          return this.filterCardio;
        case 5:
          return this.filterWholeBody;
        case 6:
          return this.filterAbs;
        default:
          return false;
      }
    },
    filterExerciseTime(e) {
      return e <= this.maxLength;
    },
  },
  computed: {
    getExercisesArray() {
      return this.exercises;
    },
    admin() {
      if (this.$store.state.token != "") {
        return this.$store.state.user.authorities[0].name === "ROLE_ADMIN";
      }
      return false;
    },
  },
    name: "exercise"
};


</script>



