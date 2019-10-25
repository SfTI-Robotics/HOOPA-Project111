"""
    Learning directly from consecutive samples is ineffcient, this due to strong 
    correlations existing between the samples, randomizing the samples breaks these
    correlations and therefore reduces the variance of the updates. On-policy always
    determines the current parameters determin ethe next data sample which is used for
    the parameters to be trained on. This means that when we choose an action or perform
    a step to recieve a reward, the network does not learn from this last step rather
    adds the transitions to the replay memory. It then draws random minibatch from the 
    replay memory to peform a graident descent step. 

    The replay memory as a base stores the last 1 million interactions , the transition is
    added to the replay memory which from it draws random minibatches of memory to perform
    a gradient descent step. Using the most current memories tends to introduce a bias to
    the current actions are taken and the agent doesn't learn as fully as the randomization
    of the replay memory. 

    The states inputted into the convolutional neural network have 4 inputs generally therfore
    since we have a current state and the new state the total number of frames would be 8 million
    but since there is a stacking mechanism it is sufficient to use the latest 1 million frames
    and then providing a slice when we need tate or new state which is equivalent to having 
    8 million frames/ DQN expects an input of the dimension (84,84. None)
"""

class ReplayMemory(object):
    """Replay Memory that stores the last size=1,000,000 transitions"""
    def __init__(self, size=1000000, frame_height=84, frame_width=84, 
                 agent_history_length=4, batch_size=32):
        """
        Args:
            size: Integer, Number of stored transitions
            frame_height: Integer, Height of a frame of an Atari game
            frame_width: Integer, Width of a frame of an Atari game
            agent_history_length: Integer, Number of frames stacked together to create a state
            batch_size: Integer, Number if transitions returned in a minibatch
        """
        self.size = size
        self.frame_height = frame_height
        self.frame_width = frame_width
        self.agent_history_length = agent_history_length
        self.batch_size = batch_size
        self.count = 0
        self.current = 0
        
        # Pre-allocate memory
        self.actions = np.empty(self.size, dtype=np.int32)
        self.rewards = np.empty(self.size, dtype=np.float32)
        self.frames = np.empty((self.size, self.frame_height, self.frame_width), dtype=np.uint8)
        self.terminal_flags = np.empty(self.size, dtype=np.bool)
        
        # Pre-allocate memory for the states and new_states in a minibatch
        self.states = np.empty((self.batch_size, self.agent_history_length, 
                                self.frame_height, self.frame_width), dtype=np.uint8)
        self.new_states = np.empty((self.batch_size, self.agent_history_length, 
                                    self.frame_height, self.frame_width), dtype=np.uint8)
        self.indices = np.empty(self.batch_size, dtype=np.int32)
        
    def add_experience(self, action, frame, reward, terminal):
        """
        Args:
            action: An integer between 0 and env.action_space.n - 1 
                determining the action the agent perfomed
            frame: A (84, 84, 1) frame of an Atari game in grayscale
            reward: A float determining the reward the agend received for performing an action
            terminal: A bool stating whether the episode terminated
        """
        if frame.shape != (self.frame_height, self.frame_width):
            raise ValueError('Dimension of frame is wrong!')
        self.actions[self.current] = action
        self.frames[self.current, ...] = frame
        self.rewards[self.current] = reward
        self.terminal_flags[self.current] = terminal
        self.count = max(self.count, self.current+1)
        self.current = (self.current + 1) % self.size
             
    def _get_state(self, index):
        if self.count is 0:
            raise ValueError("The replay memory is empty!")
        if index < self.agent_history_length - 1:
            raise ValueError("Index must be min 3")
        return self.frames[index-self.agent_history_length+1:index+1, ...]
        
    def _get_valid_indices(self):
        for i in range(self.batch_size):
            while True:
                index = random.randint(self.agent_history_length, self.count - 1)
                if index < self.agent_history_length:
                    continue
                if index >= self.current and index - self.agent_history_length <= self.current:
                    continue
                if self.terminal_flags[index - self.agent_history_length:index].any():
                    continue
                break
            self.indices[i] = index
            
    def get_minibatch(self):
        """
        Returns a minibatch of self.batch_size = 32 transitions
        """
        if self.count < self.agent_history_length:
            raise ValueError('Not enough memories to get a minibatch')
        
        self._get_valid_indices()
            
        for i, idx in enumerate(self.indices):
            self.states[i] = self._get_state(idx - 1)
            self.new_states[i] = self._get_state(idx)
        
        return np.transpose(self.states, axes=(0, 2, 3, 1)), self.actions[self.indices], self.rewards[self.indices], np.transpose(self.new_states, axes=(0, 2, 3, 1)), self.terminal_flags[self.indices]


