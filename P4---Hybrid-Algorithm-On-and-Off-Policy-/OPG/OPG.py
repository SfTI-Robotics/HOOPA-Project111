#this is a test document for trying out pong basically added a simple executable environment to Pong, in RL the agent percieves its environment 
#through observations and rewards and acts upon it through actions, the agent attempts to learn to maximize the reward, given what it learned
# from the environment
# Agent ----> Pong AI
# Action ---> Ouput of the model:Tells where the paddle should go
# Environment -----> everything that determines the state of the game
# Reward ----> what the agent gains after taking a certain action in the environment (it loses -1 after missing the ball, +1 when it hits the ball)
#its important to note that for most cases the rewards shall be zero in Pong in steps in our environment, because no points are scored in the moment.

#input is simply the sequence of frames it gets from the observations
#Output is policy - a set of rules that say what to do in every situations

import gym
import random
import time
from keras.layers import Dense 
from keras.models import Sequential
import numpy as np
from karpathy import prepro, discount_rewards

#create a generic neural network architecture, genereating a simple neural network with 200 layers. The 80*80 is preprocessing which is made 
#from raw pixels demonstrated by Karpathy which is using balls and paddles, normally the pre-processed version of the current frame and the 
#last frame to express things like the direction of the ball. Result of the two frames normally depends on the order of the last two frames
#thus that difference encodes the position of the ball for two frames and the order between those frames which gives you the direction of the ball
#Neural networks have an inbuilt function in order to generate regularities in the input. Adjusting the weights between the input (frames) and the hidden layer
#the neural network tends to incorporate regularities (like the direction of the ball) into the model
#the Sigmoid activation is used for the output layer because it must predict a probability of choosing the action UP (sigmoid lies between 0 and 1) and is basically a graph
#the last value is the binary_crossentropy loss (standrad loss for classificiation problems) because, there are different preprocessed frames for different movements, the sigmoid bootstraps into the cross-entropy Loss funciton

#Policy gradient normally aims at directly finding the best policy in policy-space, the gradient is a demonstration of the optimization process
#that usually involves gradient descent, when tuning set of parameters (which are the weights of the neural networks) 

#Training in reinforcement learning as a specific quality is that it tends to use data like other approaches of Machine learning but it doesn't have
#labelled data, training is seperate into phases which are episodes where it is a sequence of frames from the beginning of the game. 
#Each episode starts with the generation of data and then train our algoirthm using this data

model = Sequential()
#hidden layer takes pre-processed frames as an input, and has 200 units
model.add(Dense(units=200,input_dim=80*80, activation="relu", kernel_initializer="glorot_uniform"))
#output layer
model.add(Dense(units=1, activation='sigmoid', kernel_initializer='RandomNormal'))
#Compile the model using traditional machine learning losses and optimizers
model.compile(loss='binary_crossentropy',optimizer='adam',metrics=['accuracy'])

#Gym initialization
env = gym.make("SpaceInvaders-v0")
observation = env.reset()
prev_input = None

#code for the two only actions in Pong, these are the declarations of the two possible actions which are able to be taken in Pong which are
#essentially up and down actions
UP_ACTION = 2
DOWN_ACTION = 3

#Hyper - Parameters 
gamma = 0.99

#Initiaization of Variables used in the main loop
x_train, y_train, rewards = [], [], []
reward_sum = 0
episode_nb = 0


#main loop
while (True):
        env.render()
        #preprocess the observaton, set the input as the difference of the position of the ball between the images
        cur_input = prepro(observation)
        x = cur_input - prev_input if prev_input is not None else np.zeros(80 * 80)
        prev_input = cur_input
        
        #Model.predict determines what the current model thinks about probability of doing UP_action given the current frame setting, forward the policy network and sample
        #action according to the proba distribution
        proba = model.predict(np.expand_dims(x, axis=1).T)
        
        #Sampling the next action using the probability from the model
        action = UP_ACTION if np.random.uniform() < proba else DOWN_ACTION
        
        #adding a label y in y_train for the input x corresponding to the action (which is used in training)
        y = 1 if action == UP_ACTION else 0 #0 and 1 are the labels
        
        #log the input and label the train later
        x_train.append(x)
        y_train.append(y)
        
        #doing one step in the environment (go from current frame to next frame by using either UP and DOWN) through the usage of env.step(aciton)m logging the reward
        observation, reward, done, info = env.step(action)
        rewards.append(reward)
        reward_sum += reward
        
        #end of an episode
        if done:
                print('At the end of the episode: ', episode_nb, 'the Total reward was :', reward_sum)
                #increment episode number
                episode_nb += 1
                
                #training part in model.fit is as follows if an action leads to a positive reward, it tunes the weights of the neural network so it keeps on predicting
                #this winning action, otherwise it tunes them in the opposite way, the function from Karpathy attributes to discount_rewards transforms the list of rewards
                #so that even actions that remotely lead to positive rewards are encouraged. X-tran provides inconsistencies within it when there are difference between the frames
                # the y train is determines the up and down actions based on 1 and 0 respectively, rewards are given through the association of -1 if it is missed ball, 0 if 
                #nothing happens and 1 if opponent misses the ball, so we get the instance the following array. Discounted rewards are the future actions taken into consideration.
                model.fit(x=np.vstack(x_train),y=np.vstack(y_train),verbose=1,sample_weight=discount_rewards(rewards,gamma))
                
                #finally reinitializes
                x_train, y_train, rewards = [], [], []
                observation = env.reset()
                reward_sum = 0
                prev_input = None
                
                env.reset()
