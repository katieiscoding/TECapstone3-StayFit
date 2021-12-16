import axios from 'axios';

export default {

  createExercise(exercise) {
    return axios.post('/exercise/add', exercise)
  },

  editExercise(exercise) {
    return axios.put(`/exercise/${exercise.id}`, exercise)
  },
  listExercises() {
    return axios.get(`/exercise/all`);
  },
  deleteExercise(exercise){
    return axios.delete(`/exercise/${exercise.id}`);
  }
}

  

