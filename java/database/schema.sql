DROP TABLE IF EXISTS user_type, users, exercise, workout, trainer, trainer_exercise, workout_exercise CASCADE;

BEGIN TRANSACTION;

DROP SEQUENCE IF EXISTS seq_type_id;

CREATE SEQUENCE seq_type_id
  INCREMENT BY 1
  NO MAXVALUE
  NO MINVALUE
  CACHE 1;


CREATE TABLE user_type (
	type_id integer DEFAULT nextval('seq_type_id'::regclass) NOT NULL,
	type_name varchar(50) UNIQUE NOT NULL,
	CONSTRAINT PK_type PRIMARY KEY (type_id)
);

INSERT INTO user_type (type_name) VALUES ('ROLE_USER');
INSERT INTO user_type (type_name) VALUES ('ROLE_ADMIN');


COMMIT TRANSACTION;



BEGIN TRANSACTION;

DROP SEQUENCE IF EXISTS seq_user_id;

CREATE SEQUENCE seq_user_id
  INCREMENT BY 1
  NO MAXVALUE
  NO MINVALUE
  CACHE 1;


CREATE TABLE users (
	user_id int DEFAULT nextval('seq_user_id'::regclass) NOT NULL,
	username varchar(50) UNIQUE NOT NULL,
	password_hash varchar(200) NOT NULL,
	role varchar(50) NOT NULL,
	CONSTRAINT PK_user PRIMARY KEY (user_id),
	CONSTRAINT fk_role FOREIGN KEY(role) REFERENCES user_type(type_name)
);

INSERT INTO users (username,password_hash,role) VALUES ('user','$2a$08$UkVvwpULis18S19S5pZFn.YHPZt3oaqHZnDwqbCW9pft6uFtkXKDC','ROLE_USER');
INSERT INTO users (username,password_hash,role) VALUES ('admin','$2a$08$UkVvwpULis18S19S5pZFn.YHPZt3oaqHZnDwqbCW9pft6uFtkXKDC','ROLE_ADMIN');
INSERT INTO users (username,password_hash,role) VALUES ('Benny','$2a$08$UkVvwpULis18S19S5pZFn.YHPZt3oaqHZnDwqbCW9pft6uFtkXKDC','ROLE_ADMIN');
INSERT INTO users (username,password_hash,role) VALUES ('Juni','$2a$08$UkVvwpULis18S19S5pZFn.YHPZt3oaqHZnDwqbCW9pft6uFtkXKDC','ROLE_ADMIN');
INSERT INTO users (username,password_hash,role) VALUES ('Richard','$2a$08$UkVvwpULis18S19S5pZFn.YHPZt3oaqHZnDwqbCW9pft6uFtkXKDC','ROLE_ADMIN');
INSERT INTO users (username,password_hash,role) VALUES ('Connie','$2a$08$UkVvwpULis18S19S5pZFn.YHPZt3oaqHZnDwqbCW9pft6uFtkXKDC','ROLE_ADMIN');
INSERT INTO users (username,password_hash,role) VALUES ('Simon','$2a$08$UkVvwpULis18S19S5pZFn.YHPZt3oaqHZnDwqbCW9pft6uFtkXKDC','ROLE_USER'); 


COMMIT TRANSACTION;

 
 
BEGIN TRANSACTION;

DROP SEQUENCE IF EXISTS seq_exercise_id;

CREATE SEQUENCE seq_exercise_id
  INCREMENT BY 1
  NO MAXVALUE
  NO MINVALUE
  CACHE 1;


CREATE TABLE exercise (
	exercise_id integer DEFAULT nextval('seq_exercise_id'::regclass) NOT NULL,
	exercise_name varchar(50) UNIQUE NOT NULL,
	exercise_description varchar(8000) NOT NULL,
	exercise_target varchar(50) NOT NULL,
	weight integer,
	reps integer,
	exercise_duration integer NOT NULL,
	creator_name varchar(50),
	CONSTRAINT PK_exercise PRIMARY KEY (exercise_id),
	CONSTRAINT fk_creator_name FOREIGN KEY(creator_name) REFERENCES users(username)

);

INSERT INTO exercise (exercise_name, exercise_description, exercise_target, weight, reps, exercise_duration, creator_name) VALUES ('Bicep Curl', 'Stand with feet hip-width apart, holding weights in front of the thighs with palms out. Bend the arms and curl the weights toward your shoulders. Slowly lower the weights, but avoid locking the elbows.', 'Arms', '5', '10', '1', 'Richard');
INSERT INTO exercise (exercise_name, exercise_description, exercise_target, weight, reps, exercise_duration, creator_name) VALUES ('Arm Circle', 'Stand with feet shoulder-width apart and arms extended parallel to the floor at each side, holding weights. Gently circle arms forward in small circles, gradually increasing the size of the circles. Reverse the direction of the circles to complete one rep.', 'Arms', '3', '20', '2', 'Connie');
INSERT INTO exercise (exercise_name, exercise_description, exercise_target, weight, reps, exercise_duration, creator_name) VALUES ('Shoulder Press', 'Stand with feet shoulder-width apart, holding weights at shoulder height with elbows out at a right angle. Slowly raise the weights over your head until arms are almost straight. Slowly return to the starting position to complete one rep.', 'Arms', '20', '10', '1', 'Connie');
INSERT INTO exercise (exercise_name, exercise_description, exercise_target, reps, exercise_duration, creator_name) VALUES ('Push-Up', 'Position yourself face down with elbows bent, forearms and balls of feet on the floor. Look toward the floor. Engaging your abs, bend the elbows to lower the entire body to the floor. Slowly raise back up to the starting position to complete one rep.', 'Arms', '20', '2', 'Juni');
INSERT INTO exercise (exercise_name, exercise_description, exercise_target, reps, exercise_duration, creator_name) VALUES ('Tricep Dip', 'Place your hands behind you so the palms are on the front of a chair seat, fingers facing forward. Extend your legs and start bending your elbows as you lower your body down to a 90-degree angle. Slowly raise back up until arms are straight.', 'Arms', '20', '2', 'Benny');
INSERT INTO exercise (exercise_name, exercise_description, exercise_target, reps, exercise_duration, creator_name) VALUES ('Calf Raise', 'Standing up straight, push up onto your tiptoes slowly. Slowly lower back to starting position to complete a rep.', 'Legs', '30', '2', 'Richard');
INSERT INTO exercise (exercise_name, exercise_description, exercise_target, reps, exercise_duration, creator_name) VALUES ('Squat', 'Stand with your feet shoulder-width apart. Bend your knees while lowering your hips backward into a seated position. Stop when your thighs are parallel to the ground and slowly push back up to standing.', 'Legs', '50', '5', 'Benny');
INSERT INTO exercise (exercise_name, exercise_description, exercise_target, reps, exercise_duration, creator_name) VALUES ('Bridge', 'Lie on your back with knees bent and feet flat on the floor. Engage your core and raise hips up until they align with your knees. Hold for five seconds and slowly return to the starting position.', 'Legs', '30', '3', 'Juni');
INSERT INTO exercise (exercise_name, exercise_description, exercise_target, reps, exercise_duration, creator_name) VALUES ('Lateral Lunge', 'Stand with your feet wider than hip-width apart. Bend your left knee forward while leaning your left hip back and keeping your core upright. Keeping your right leg straight, continue down, bending your left knee until your thigh is parallel with the ground. Slowly return to starting and repeat on the other side.', 'Legs', '20', '2', 'Juni');
INSERT INTO exercise (exercise_name, exercise_description, exercise_target, reps, exercise_duration, creator_name) VALUES ('Wall Sit', 'Stand with back against a wall, feet shoulder width apart and two feet away from the wall. Engage your core and slide your back down against the wall into a parallel squat position. Hold for 30 seconds, then slide slowly back up the wall to the starting position to complete a rep.', 'Legs', '10', '5', 'Connie');
INSERT INTO exercise (exercise_name, exercise_description, exercise_target, reps, exercise_duration, creator_name) VALUES ('Plank', 'Position yourself face down with elbows bent, forearms and balls of feet on the floor. Look toward the floor. Engaging your abs, pull your belly back toward your spine. Keep your back straight and hold for 10 seconds. Gently release to the floor.', 'Abs', '10', '5', 'Richard');
INSERT INTO exercise (exercise_name, exercise_description, exercise_target, reps, exercise_duration, creator_name) VALUES ('Bicycle Crunch', 'Lying on your back, raise your knees to a 90-degree angle and alternately extend your legs in a bike-pedaling motion. With each pedal motion, twist your torso and touch your elbow to the opposite knee.', 'Abs', '50', '5', 'Connie');
INSERT INTO exercise (exercise_name, exercise_description, exercise_target, reps, exercise_duration, creator_name) VALUES ('Crunch', 'Lie on your back with knees bent and feet flat on the floor, hip-width apart. Cross your arms across the chest. Lift your upper body straight up, then slowly relax back to starting position.', 'Abs', '50', '5', 'Benny');
INSERT INTO exercise (exercise_name, exercise_description, exercise_target, reps, exercise_duration, creator_name) VALUES ('Deadbug', 'Lie on your back with knees bent and feet on the floor. Pull your shoulders down away from your ears. Lift your hands so your elbows are near the ears with fists facing in toward the center of the body. Raise knees to be directly over the hips. Gently lower your left arm and right leg until almost touching the floor. Bring them back up and repeat on the other side to complete one rep.', 'Abs', '20', '3', 'Juni');
INSERT INTO exercise (exercise_name, exercise_description, exercise_target, reps, exercise_duration, creator_name) VALUES ('Seated Leg Lift', 'Sit up straight in a chair or on the floor with legs extended. Tighten the abs as you lift one leg up, then gently lower down. Repeat on the other side to complete one rep.', 'Abs', '30', '3', 'Richard');
INSERT INTO exercise (exercise_name, exercise_description, exercise_target, reps, exercise_duration, creator_name) VALUES ('Superman', 'Lie face down with legs and arms outstretched. Raise arms and legs several inches simultaneously and hold for five seconds. Gently lower back down.', 'Back', '10', '2', 'Benny');
INSERT INTO exercise (exercise_name, exercise_description, exercise_target, weight, reps, exercise_duration, creator_name) VALUES ('Good Morning', 'Stand with knees slightly bent, feet hip-width apart and weights held up beside the head at ear level. Hinge forward from the hip, keeping your back flat. Lean forward until your back is parallel to the floor, then slowly straighten up again.', 'Back', '15', '20', '3', 'Juni');
INSERT INTO exercise (exercise_name, exercise_description, exercise_target, weight, reps, exercise_duration, creator_name) VALUES ('Shoulder Shrug', 'Stand with your feet shoulder-width apart and knees slightly bent. Hold weights at your sides, palms facing the legs, elbows slightly bent. Keeping your arms nearly straight, slowly raise your shoulders up to your ears. Pause and then slowly release back to the starting position.', 'Back', '20', '20', '3', 'Richard');
INSERT INTO exercise (exercise_name, exercise_description, exercise_target, weight, reps, exercise_duration, creator_name) VALUES ('Delt Raise', 'Stand with knees slightly bent, feet hip-width apart. Bend over halfway while shifting hips back. With palms facing the ground, lift weights straight out to shoulder height. Lower weights gently.', 'Back', '15', '10', '2', 'Benny');
INSERT INTO exercise (exercise_name, exercise_description, exercise_target, weight, reps, exercise_duration, creator_name) VALUES ('Row', 'Holding weights in either hand, hinge at the hip to bend forward almost parallel to the ground. Bending both elbows, draw weights back to either side of the waist. Slowly release back to starting position.', 'Back', '10', '20', '3', 'Connie');
INSERT INTO exercise (exercise_name, exercise_description, exercise_target, reps, exercise_duration, creator_name) VALUES ('Jumping Jack', 'Stand upright with feet almost together and arms at sides, then jump into a position with arms raised up and out, landing with legs spread a little past shoulder-width. Jump back into a feet-together position and clap arms down to sides to complete a rep.', 'Cardio', '50', '5', 'Connie');
INSERT INTO exercise (exercise_name, exercise_description, exercise_target, reps, exercise_duration, creator_name) VALUES ('Squat Jump', 'Stand with your feet shoulder-width apart. Bend your knees while lowering your hips backward into a squat. When thighs are parallel to the ground, jump up with an explosive movement and land again with feet in starting position.', 'Cardio', '20', '3', 'Richard');
INSERT INTO exercise (exercise_name, exercise_description, exercise_target, exercise_duration, creator_name) VALUES ('Jump Rope', 'With the rope behind you and a handle in either hand, bend your knees slightly as you swing the rope overhead to the front. Jump as the rope passes your shins by leaping up from your toes. Focus on your wrist motions to control the rope and stay on the balls of your feet when you land.', 'Cardio', '5', 'Benny');
INSERT INTO exercise (exercise_name, exercise_description, exercise_target, exercise_duration, creator_name) VALUES ('Jog in Place', 'Lightly run in place without moving forward. Hold arms at a right angle with elbows near sides, swinging fists back and forth as you jog. For variation, lift knees higher as you step.', 'Cardio', '5', 'Juni');
INSERT INTO exercise (exercise_name, exercise_description, exercise_target, reps, exercise_duration, creator_name) VALUES ('Burpee', 'Stand with feet shoulder-width apart, arms at sides. Pushing the hips back, lower the body into a squat. Shift your weight onto your hands on the floor right in front of and in between your feet. Hop the feet backward to a plank. Hop the feet forward to the previous frog position. Leap up into the air with arms overhead. Land directly back into a squat.', 'Whole Body', '20', '3', 'Benny');
INSERT INTO exercise (exercise_name, exercise_description, exercise_target, reps, exercise_duration, creator_name) VALUES ('Squat to Overhead Press', 'Holding a dumbbell in each hand with palms facing inward, weights at shoulder height, push the hips back and lower into a squat, keeping the weights at the shoulders. When the hips reach your knees, stand back up and raise the arms overhead. Slowly return weights to shoulder height to complete one rep.', 'Whole Body', '20', '3', 'Connie');
INSERT INTO exercise (exercise_name, exercise_description, exercise_target, weight, reps, exercise_duration, creator_name) VALUES ('Goblet Squat', 'Stand with feet shoulder-width apart. Hold a kettlebell at chest height, using both hands, with elbows bent and weight at the center of your chest. Keeping your back aligned, bend your knees and lower back into the hips until thighs are parallel to the floor. Slowly raise back up to the starting position.', 'Whole Body', '15', '20', '3', 'Juni');
INSERT INTO exercise (exercise_name, exercise_description, exercise_target, weight, reps, exercise_duration, creator_name) VALUES ('Weighted Step-Up', 'Standing before a step, with elbows bent in front of you, hold weights at the shoulders. Step up with the left foot until your left leg is straight. Bend your left knee to step back down onto the right foot. Step the left foot down to meet the right. Repeat on the other side to complete a rep.', 'Whole Body', '20', '20', '3', 'Richard');

COMMIT TRANSACTION;



BEGIN TRANSACTION;

DROP SEQUENCE IF EXISTS seq_workout_id;

CREATE SEQUENCE seq_workout_id
  INCREMENT BY 1
  NO MAXVALUE
  NO MINVALUE
  CACHE 1;


CREATE TABLE workout (
	workout_id integer DEFAULT nextval('seq_workout_id'::regclass) NOT NULL,
	workout_timestamp timestamp NOT NULL,
	workout_duration int NOT NULL,
	creator_name varchar(50) NOT NULL,
	CONSTRAINT PK_workout PRIMARY KEY (workout_id),
	CONSTRAINT fk_creator FOREIGN KEY(creator_name) REFERENCES users(username)	
);

INSERT INTO workout (workout_timestamp, workout_duration, creator_name) VALUES('2021-07-02 07:23:11', '13', 'Simon');
INSERT INTO workout (workout_timestamp, workout_duration, creator_name) VALUES('2021-07-09 11:11:07', '15', 'Simon');
INSERT INTO workout (workout_timestamp, workout_duration, creator_name) VALUES('2021-07-16 12:24:36', '10', 'Simon');
INSERT INTO workout (workout_timestamp, workout_duration, creator_name) VALUES('2021-07-23 23:07:11', '24', 'Simon'); 

COMMIT TRANSACTION;


BEGIN TRANSACTION;

DROP SEQUENCE IF EXISTS seq_trainer_id;

CREATE SEQUENCE seq_trainer_id
  INCREMENT BY 1
  NO MAXVALUE
  NO MINVALUE
  CACHE 1;


CREATE TABLE trainer (
	trainer_id integer DEFAULT nextval('seq_trainer_id'::regclass) NOT NULL,
	trainer_name varchar(50) UNIQUE NOT NULL,
	CONSTRAINT PK_trainer PRIMARY KEY (trainer_id)
	
);

INSERT INTO trainer(trainer_name) VALUES ('Benny');
INSERT INTO trainer(trainer_name) VALUES ('Juni');
INSERT INTO trainer(trainer_name) VALUES ('Richard');
INSERT INTO trainer(trainer_name) VALUES ('Connie');


COMMIT TRANSACTION;


BEGIN TRANSACTION;

DROP SEQUENCE IF EXISTS seq_trainer_exercise_id;

CREATE SEQUENCE seq_trainer_exercise_id
  INCREMENT BY 1
  NO MAXVALUE
  NO MINVALUE
  CACHE 1;


CREATE TABLE trainer_exercise (
	trainer_exercise_id integer DEFAULT nextval('seq_trainer_exercise_id'::regclass) NOT NULL,
	trainer_id int NOT NULL,
	exercise_id int UNIQUE NOT NULL,
	CONSTRAINT PK_trainer_exercise PRIMARY KEY(trainer_exercise_id),
	CONSTRAINT FK_trainer_id FOREIGN KEY(trainer_id) REFERENCES trainer(trainer_id),
	CONSTRAINT FK_exercise_id FOREIGN KEY(exercise_id) REFERENCES exercise(exercise_id)
	
);

INSERT INTO trainer_exercise(trainer_id, exercise_id) VALUES (3, 1);
INSERT INTO trainer_exercise(trainer_id, exercise_id) VALUES (4, 2);
INSERT INTO trainer_exercise(trainer_id, exercise_id) VALUES (4, 3);
INSERT INTO trainer_exercise(trainer_id, exercise_id) VALUES (2, 4);
INSERT INTO trainer_exercise(trainer_id, exercise_id) VALUES (1, 5);

INSERT INTO trainer_exercise(trainer_id, exercise_id) VALUES (3, 6);
INSERT INTO trainer_exercise(trainer_id, exercise_id) VALUES (1, 7);
INSERT INTO trainer_exercise(trainer_id, exercise_id) VALUES (2, 8);
INSERT INTO trainer_exercise(trainer_id, exercise_id) VALUES (2, 9);
INSERT INTO trainer_exercise(trainer_id, exercise_id) VALUES (4, 10);

INSERT INTO trainer_exercise(trainer_id, exercise_id) VALUES (3, 11);
INSERT INTO trainer_exercise(trainer_id, exercise_id) VALUES (4, 12);
INSERT INTO trainer_exercise(trainer_id, exercise_id) VALUES (1, 13);
INSERT INTO trainer_exercise(trainer_id, exercise_id) VALUES (2, 14);
INSERT INTO trainer_exercise(trainer_id, exercise_id) VALUES (3, 15);

INSERT INTO trainer_exercise(trainer_id, exercise_id) VALUES (1, 16);
INSERT INTO trainer_exercise(trainer_id, exercise_id) VALUES (2, 17);
INSERT INTO trainer_exercise(trainer_id, exercise_id) VALUES (3, 18);
INSERT INTO trainer_exercise(trainer_id, exercise_id) VALUES (1, 19);
INSERT INTO trainer_exercise(trainer_id, exercise_id) VALUES (4, 20);

INSERT INTO trainer_exercise(trainer_id, exercise_id) VALUES (4, 21);
INSERT INTO trainer_exercise(trainer_id, exercise_id) VALUES (3, 22);
INSERT INTO trainer_exercise(trainer_id, exercise_id) VALUES (1, 23);
INSERT INTO trainer_exercise(trainer_id, exercise_id) VALUES (2, 24);
INSERT INTO trainer_exercise(trainer_id, exercise_id) VALUES (1, 25);
INSERT INTO trainer_exercise(trainer_id, exercise_id) VALUES (4, 26);
INSERT INTO trainer_exercise(trainer_id, exercise_id) VALUES (2, 27);
INSERT INTO trainer_exercise(trainer_id, exercise_id) VALUES (3, 28);

COMMIT TRANSACTION;



BEGIN TRANSACTION;


DROP SEQUENCE IF EXISTS seq_workout_exercise_id;

CREATE SEQUENCE seq_workout_exercise_id
  INCREMENT BY 1
  NO MAXVALUE
  NO MINVALUE
  CACHE 1;


CREATE TABLE workout_exercise (
	workout_exercise_id integer DEFAULT nextval('seq_workout_exercise_id'::regclass) NOT NULL,
	workout_id int NOT NULL,
	exercise_name varchar(50) NOT NULL,
	username varchar(50) NOT NULL,
	CONSTRAINT PK_workout_exercise PRIMARY KEY(workout_exercise_id),
	CONSTRAINT FK_workout_id FOREIGN KEY(workout_id) REFERENCES workout(workout_id),
	CONSTRAINT FK_exercise_name FOREIGN KEY(exercise_name) REFERENCES exercise(exercise_name),
	CONSTRAINT FK_username FOREIGN KEY(username) REFERENCES users(username)
	);

INSERT INTO workout_exercise (workout_id, exercise_name, username) VALUES('1', 'Arm Circle', 'Simon'); 
INSERT INTO workout_exercise (workout_id, exercise_name, username) VALUES('1', 'Plank', 'Simon'); 
INSERT INTO workout_exercise (workout_id, exercise_name, username) VALUES('1', 'Wall Sit', 'Simon'); 
INSERT INTO workout_exercise (workout_id, exercise_name, username) VALUES('1', 'Shoulder Press', 'Simon'); 

INSERT INTO workout_exercise (workout_id, exercise_name, username) VALUES('2', 'Jumping Jack', 'Simon'); 
INSERT INTO workout_exercise (workout_id, exercise_name, username) VALUES('2', 'Superman', 'Simon'); 
INSERT INTO workout_exercise (workout_id, exercise_name, username) VALUES('2', 'Bicep Curl', 'Simon'); 
INSERT INTO workout_exercise (workout_id, exercise_name, username) VALUES('2', 'Goblet Squat', 'Simon'); 
INSERT INTO workout_exercise (workout_id, exercise_name, username) VALUES('2', 'Squat Jump', 'Simon'); 
INSERT INTO workout_exercise (workout_id, exercise_name, username) VALUES('2', 'Bicep Curl', 'Simon'); 

INSERT INTO workout_exercise (workout_id, exercise_name, username) VALUES('3', 'Deadbug', 'Simon'); 
INSERT INTO workout_exercise (workout_id, exercise_name, username) VALUES('3', 'Jump Rope', 'Simon'); 
INSERT INTO workout_exercise (workout_id, exercise_name, username) VALUES('3', 'Delt Raise', 'Simon'); 

INSERT INTO workout_exercise (workout_id, exercise_name, username) VALUES('4', 'Burpee', 'Simon'); 
INSERT INTO workout_exercise (workout_id, exercise_name, username) VALUES('4', 'Row', 'Simon'); 
INSERT INTO workout_exercise (workout_id, exercise_name, username) VALUES('4', 'Crunch', 'Simon'); 
INSERT INTO workout_exercise (workout_id, exercise_name, username) VALUES('4', 'Wall Sit', 'Simon'); 
INSERT INTO workout_exercise (workout_id, exercise_name, username) VALUES('4', 'Seated Leg Lift', 'Simon'); 
INSERT INTO workout_exercise (workout_id, exercise_name, username) VALUES('4', 'Jog in Place', 'Simon'); 

COMMIT TRANSACTION;
