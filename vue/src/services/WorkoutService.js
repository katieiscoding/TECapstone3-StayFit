import axios from 'axios';



  export default{
    listTrainers() {
        return axios.get(`/workout`);
      },

    generateWorkout(totalTime, trainerId, bodyPartIds) {
      let query = "?totalTime=" + totalTime + "&creatorName=" + trainerId;
      
        return axios.post(`/workout/generate` + query,bodyPartIds);
    },

    // addToWorkout(exercise) {
    //   // what should the query be if we are clicking on a card
    //   return axios.post(`/workout/generate` + exercise);
    // },

    saveCompletedWorkoutToDatabase(exercises) {
        return axios.post('workout/save/',exercises);

    },
    getSavedUserWorkouts(){
      return axios.get('/workout/history');
    },
    getAllUsers(){
      return axios.get('/allUsers');
    },
    getIdFromUsername(username){
      return axios.get('/user/' + username);
    },
    getWorkoutsFromUser(username) {
      return axios.get('/workout/history/' + username);
    }
    
  }