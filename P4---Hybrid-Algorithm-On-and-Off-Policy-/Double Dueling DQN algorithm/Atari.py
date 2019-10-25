"""
The environment we tend to use is already integrated in open-ai gym, therefore it is 
paramount that the right version of the environment is used since there are multiple 
different environments which can be used which involve changing environments, also
there are different action values that are provided for these different environments

Therefore its quite easy to figure out the number of actions , such as using it for 
env.action_space_n and the and get the meaning for those actions based on env.unwrapped.get_action_meanin

there is special boolean value is the terminal life which is when the life is lost when playing the game
they way we like to characterize life is that there is no punishment for life is lost , therefore it makes the 
agent really think about losing life, but this only needed to be conducted in the replay memory , the reset is after
the replay memory life is also lost in some instances hence having two boolean values. One to rest the game and the 
other to rest the replay memory. 
"""
class Atari(object):
    """Wrapper for the environment provided by gym"""
    def __init__(self, envName, no_op_steps=10, agent_history_length=4):
        self.env = gym.make(envName)
        self.process_frame = FrameProcessor()
        self.state = None
        self.last_lives = 0
        self.no_op_steps = no_op_steps
        self.agent_history_length = agent_history_length

    def reset(self, sess, evaluation=False):
        """
        Args:
            sess: A Tensorflow session object
            evaluation: A boolean saying whether the agent is evaluating or training
        Resets the environment and stacks four frames ontop of each other to 
        create the first state
        """
        frame = self.env.reset()
        self.last_lives = 0
        terminal_life_lost = True # Set to true so that the agent starts 
                                  # with a 'FIRE' action when evaluating
        if evaluation:
            for _ in range(random.randint(1, self.no_op_steps)):
                frame, _, _, _ = self.env.step(1) # Action 'Fire'
        processed_frame = self.process_frame(sess, frame)   # (★★★)
        self.state = np.repeat(processed_frame, self.agent_history_length, axis=2)
        
        return terminal_life_lost

    def step(self, sess, action):
        """
        Args:
            sess: A Tensorflow session object
            action: Integer, action the agent performs
        Performs an action and observes the reward and terminal state from the environment
        """
        new_frame, reward, terminal, info = self.env.step(action)  # (5★)
            
        if info['ale.lives'] < self.last_lives:
            terminal_life_lost = True
        else:
            terminal_life_lost = terminal
        self.last_lives = info['ale.lives']
        
        processed_new_frame = self.process_frame(sess, new_frame)   # (6★)
        new_state = np.append(self.state[:, :, 1:], processed_new_frame, axis=2) # (6★)   
        self.state = new_state
        
        return processed_new_frame, reward, terminal, terminal_life_lost, new_frame
    





def clip_reward(reward):
    if reward > 0:
        return 1
    elif reward == 0:
        return 0
    else:
        return -1
        
        
    """
        here we declare the constants that tend to define the beahviour of the agents:
        specificially the max episode length, evaluation frequency, evaluation steps, network update frequency
        discount factor, replay memory_start_size, max_frames, memory_size, No_op_steps 
    """
    
  
    
    