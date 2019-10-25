#DQN was devised by Deepmind which is wanting to have it successfully control policise
# in different Atari 2600 games and recieving only screen as pixels as inputs and a reward
# when the game score changes 

#even with the advent of more advanced methods Deep - Q learning is still quite an important
#method and is worth using as a benchmark for this portion of the project. 

#the key here is to make a gif after every episode so that the gif can be shown to display
#the way that the AI is being trained

#reinforcement learning basically uses the same philosophy which tends to use the computer 
#to let it explore the environment and occasionally giving it a reward when the score 
#increases 

#RL algorithms are normally supposed to be able to learn from a scalar reward signal 
#that is frequenctly sparse [...] and delayed. They delay between actions and resulting
#rewards, which can be thousands of timesteps long, seems practicularly duanting when
#compared to the direct association between inputs and targets found in supervised learnin


#the discounted return is based on the fact that you are getting return based on the 
#the rewards which are determined in the future of the agent learning policy and the 
#future rewards which are going to be given for taking these actions. 

#Q learning is a type of learning algorithm which tends to use the bellman equation in
#order to determine what the right policy is too take by associating a weighting of
#state - action value to all the nodes of a network when actions are being taken. 

"""
Implementation of Deep Q learning algoirhtm by Dweep Kapadia, this used the Traditional
Approach of the Deepmind's DQN but changing the way it has been developed so that 
it is developed distinctly by us using abstraction of classes and such
"""

import os
import random
import gym
import tensorflow as tf
import numpy as np
import imageio
from skimage.transform import resize


class FrameProcessor(object):
    """Resizes and converts RGB Atari frames to grayscale"""
    def __init__(self, frame_height=84, frame_width=84):
        """
        Args:
            frame_height: Integer, Height of a frame of an Atari game
            frame_width: Integer, Width of a frame of an Atari game
        """
        self.frame_height = frame_height
        self.frame_width = frame_width
        self.frame = tf.placeholder(shape=[210, 160, 3], dtype=tf.uint8)
        self.processed = tf.image.rgb_to_grayscale(self.frame)
        self.processed = tf.image.crop_to_bounding_box(self.processed, 34, 0, 160, 160)
        self.processed = tf.image.resize_images(self.processed, 
                                                [self.frame_height, self.frame_width], 
                                                method=tf.image.ResizeMethod.NEAREST_NEIGHBOR)
    
    def __call__(self, session, frame):
        """
        Args:
            session: A Tensorflow session object
            frame: A (210, 160, 3) frame of an Atari game in RGB
        Returns:
            A processed (84, 84, 1) frame in grayscale
        """
        return session.run(self.processed, feed_dict={self.frame:frame})
