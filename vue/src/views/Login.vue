<template>
    <section class="main">  
    <div id="register" class="text-center row justify-content-center">
      <div class="bigPic">
        <img id="sidePic" alt="person with ponytail lunging with hand weight" src="../assets/target-whole-body.png">
      </div>
      <div class="loginForm col-md-6 xs-10 mx-auto">
        <form class="form-register" @submit.prevent="login">
          <h1 class="h3 headline mb-3 font-weight-normal">Welcome!</h1>
          <h4 id="appDesc">Exercise has never been so exciting.</h4>
            <div
              class="alert alert-danger"
              role="alert"
              v-if="invalidCredentials"
            >
              Invalid username or password!
            </div>
            <div
              class="alert alert-success"
              role="alert"
              v-if="this.$route.query.registration"
            >
              Thank you for registering; please sign in.
            </div>
            <div class="loginBG">
            <div class="login-field">
            <label for="username" class="sr-only">Username:</label>
            <input
              type="text"
              id="username"
              class="form-control my-2"
              placeholder="Username"
              v-model="user.username"
              required
              autofocus
            />
            </div>
            <div class="login-field">
            <label for="password" class="sr-only">Password:</label>
            <input
              type="password"
              id="password"
              class="form-control my-2"
              placeholder="Password"
              v-model="user.password"
              required
            />
            </div>
            <div class="login-register">
            <div class="mt-2">
              <button id="signIn"
                class="btn btn-lg btn-primary btn-block my-2"
                type="submit">
                Sign in
              </button>
            </div>
            <div class="mt-2">
              <router-link
                :to="{ name: 'register' }" class="textLink">Need an account?</router-link>
            </div>
            <div class="smallPic"><img id="lockers" alt="lockers" src="../assets/login-trainer.png"></div>
            </div>
            </div>
          </form>
      </div>
    </div>
</section>
</template>

<script>
import authService from "../services/AuthService";
import exerciseService from "../services/ExerciseService";
export default {
  name: "login",
  components: {},
  data() {
    return {
      user: {
        username: "",
        password: "",
      },
      invalidCredentials: false,
    };
  },
  methods: {
    login() {
      authService
        .login(this.user)
        .then((response) => {
          if (response.status == 200) {
            this.$store.commit("SET_AUTH_TOKEN", response.data.token);
            this.$store.commit("SET_USER", response.data.user);
            this.$router.push("/customize");
          }
        })
        .catch((error) => {
          const response = error.response;
          if (response.status === 401) {
            this.invalidCredentials = true;
          }
        });
    },
    addExercise() {
      exerciseService.createExercise({"exerciseName":"running"});

    }
  },
};
</script>
<style>
@import url('https://fonts.googleapis.com/css2?family=Crete+Round&family=Lato:wght@300;400;700&display=swap');

/* these styles are for elements that are ONLY represented in the Login.vue file */


.smallPic {
  display: flex;
  justify-content: center;
  width: 100%;
}

#lockers {
  width: 100px;
  height: auto;
  padding-top: 8px;
}

</style>