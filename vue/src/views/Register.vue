<template>
<section>
    <header>
      <nav></nav>
    </header>
    <body>
    <section class="main">  
    <div id="register" class="text-center row justify-content-center">
    <div class="bigPic">
      <img id="sidePic" alt="person with ponytail lunging with hand weight" src="../assets/target-whole-body.png">
    </div>
    <div class="loginForm col-md-6 xs-10 mx-auto">
    <form class="form-register" @submit.prevent="register">
      <h1 class="h3 headline mb-3 font-weight-normal">Create Account</h1>
      <h4 id="appDesc">Register below to begin!</h4>
      <div class="alert alert-danger" role="alert" v-if="registrationErrors">
        {{ registrationErrorMsg }}
      </div>
      <div class="loginBG">
      <div class="login-field">
      <label for="username" class="sr-only">Username:</label>
      <input
        type="text"
        id="username"
        class="form-control mt-2"
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
        class="form-control mt-2"
        placeholder="Password"
        v-model="user.password"
        required
      />
      <input 
        type="password"
        id="confirmPassword"
        class="form-control mt-2"
        placeholder="Confirm Password"
        v-model="user.confirmPassword"
        required
      />
      </div>
      <div class="login-register">
      <button class="btn btn-lg btn-primary btn-block mt-2" type="submit">
        Create Account
      </button>
      <router-link class="textLink" :to="{ name: 'login' }">Already have an account?</router-link>
      </div>
      </div>
    </form>
    </div>
  </div>
  </section>
  </body>
</section>
</template>

<script>
import authService from '../services/AuthService';
export default {
  name: 'register',
  data() {
    return {
      user: {
        username: '',
        password: '',
        confirmPassword: '',
        role: 'user',
      },
      registrationErrors: false,
      registrationErrorMsg: 'There were problems registering this user.',
    };
  },
  methods: {
    register() {
      if (this.user.password != this.user.confirmPassword) {
        this.registrationErrors = true;
        this.registrationErrorMsg = 'Password & Confirm Password do not match.';
      } else {
        authService
          .register(this.user)
          .then((response) => {
            if (response.status == 201) {
              this.$router.push({
                path: '/login',
                query: { registration: 'success' },
              });
            }
          })
          .catch((error) => {
            const response = error.response;
            this.registrationErrors = true;
            if (response.status === 400) {
              this.registrationErrorMsg = "Registration error; please try again.";
            }
          });
      }
    },
    clearErrors() {
      this.registrationErrors = false;
      this.registrationErrorMsg = 'There were problems registering this user.';
    },
  },
};
</script>

<style>

@import url('https://fonts.googleapis.com/css2?family=Crete+Round&family=Lato:wght@300;400;700&display=swap');

/* these styles are for elements that are ONLY represented in the Register.vue file */


#password {
  margin-bottom: 10px;
}

#confirmPassword {
  margin-bottom: 10px;
}

</style>