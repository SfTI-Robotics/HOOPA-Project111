""" So there are many variation of DQN but some of the potent variations is the double
DQN and the Dueling DQN and these kinds of variations optimise the normal dqn so with 
Dueling DQN architecture that there has been a bridge between the state action value 
function and this is split into the state function known as V and the advantage function
determined for taking a particular piece of action and thus this ultimately allows
for states which do not need to be traversed to be pruned when making action selection
and makes the algorithm converge faster towards an optimal policy. 

Dueling DQN and DQN have the same low - level architecture which consists of the first
convolutional layer which has 32 8x8 filters with stride 4, the second 64 4x4 filters 
with stride 2 and the third and final convolutional layer consists of 64 3x3 filters 
with 1 stride

The dueling architecture splits the final convolutional layer into two seperate streams
that represent the value and advantage functions that predict a state value V(s) that 
depends only on the state and the action advatnages A(s,a) which depends on the state
and action respectively

This is the advantage of the dueling architecture it is open to learn which states are 
valuable without having to learn the effect of each action for each state, this 
particularly useful in states where its actions do not affect the environment in any
relevant way in the experiements. We demonstrate that the dueling architecture can
move quickly and identify the correct action during policy evaluation as redundant
or similar actions are added to the learning problem. 

The value state V(s) is normally used to predict how good it is to be in a certain state(s)
and the action advantage A(s,a) predcits how good it is to perform an action a at the
state s

This DQN implementation has some key points which have to be taken into consideration:
---- normalizing the input pixel values to [0,1] by dividing the input with 0xFF=255
The reason for this is the pixel values of the frames, the environment returns are uint8
which can store values in the range[0,255]
---- There needs to be the right weights added therefore use the following version in
Tensorflow which involves the tf.variance_scaling_initializer with scale = 2
"""
class DQN(object):
    """Implements a Deep Q Network"""
    
    # pylint: disable=too-many-instance-attributes
    
    def __init__(self, n_actions, hidden=1024, learning_rate=0.00001, 
                 frame_height=84, frame_width=84, agent_history_length=4):
        """
        Args:
            n_actions: Integer, number of possible actions
            hidden: Integer, Number of filters in the final convolutional layer. 
                    This is different from the DeepMind implementation
            learning_rate: Float, Learning rate for the Adam optimizer
            frame_height: Integer, Height of a frame of an Atari game
            frame_width: Integer, Width of a frame of an Atari game
            agent_history_length: Integer, Number of frames stacked together to create a state
        """
        self.n_actions = n_actions
        self.hidden = hidden
        self.learning_rate = learning_rate
        self.frame_height = frame_height
        self.frame_width = frame_width
        self.agent_history_length = agent_history_length
        
        self.input = tf.placeholder(shape=[None, self.frame_height, 
                                           self.frame_width, self.agent_history_length], 
                                    dtype=tf.float32)
        # Normalizing the input
        self.inputscaled = self.input/255
        
        # Convolutional layers
        self.conv1 = tf.layers.conv2d(
            inputs=self.inputscaled, filters=32, kernel_size=[8, 8], strides=4,
            kernel_initializer=tf.variance_scaling_initializer(scale=2),
            padding="valid", activation=tf.nn.relu, use_bias=False, name='conv1')
        self.conv2 = tf.layers.conv2d(
            inputs=self.conv1, filters=64, kernel_size=[4, 4], strides=2, 
            kernel_initializer=tf.variance_scaling_initializer(scale=2),
            padding="valid", activation=tf.nn.relu, use_bias=False, name='conv2')
        self.conv3 = tf.layers.conv2d(
            inputs=self.conv2, filters=64, kernel_size=[3, 3], strides=1, 
            kernel_initializer=tf.variance_scaling_initializer(scale=2),
            padding="valid", activation=tf.nn.relu, use_bias=False, name='conv3')
        self.conv4 = tf.layers.conv2d(
            inputs=self.conv3, filters=hidden, kernel_size=[7, 7], strides=1, 
            kernel_initializer=tf.variance_scaling_initializer(scale=2),
            padding="valid", activation=tf.nn.relu, use_bias=False, name='conv4')
        
        # Splitting into value and advantage stream
        self.valuestream, self.advantagestream = tf.split(self.conv4, 2, 3)
        self.valuestream = tf.layers.flatten(self.valuestream)
        self.advantagestream = tf.layers.flatten(self.advantagestream)
        self.advantage = tf.layers.dense(
            inputs=self.advantagestream, units=self.n_actions,
            kernel_initializer=tf.variance_scaling_initializer(scale=2), name="advantage")
        self.value = tf.layers.dense(
            inputs=self.valuestream, units=1, 
            kernel_initializer=tf.variance_scaling_initializer(scale=2), name='value')
        
        # Combining value and advantage into Q-values as described above
        self.q_values = self.value + tf.subtract(self.advantage, tf.reduce_mean(self.advantage, axis=1, keepdims=True))
        self.best_action = tf.argmax(self.q_values, 1)
        
        # The next lines perform the parameter update. This will be explained in detail later.
        
        # targetQ according to Bellman equation: 
        # Q = r + gamma*max Q', calculated in the function learn()
        self.target_q = tf.placeholder(shape=[None], dtype=tf.float32)
        # Action that was performed
        self.action = tf.placeholder(shape=[None], dtype=tf.int32)
        # Q value of the action that was performed
        self.Q = tf.reduce_sum(tf.multiply(self.q_values, tf.one_hot(self.action, self.n_actions, dtype=tf.float32)), axis=1)
        
        # Parameter updates
        self.loss = tf.reduce_mean(tf.losses.huber_loss(labels=self.target_q, predictions=self.Q))
        self.optimizer = tf.train.AdamOptimizer(learning_rate=self.learning_rate)
        self.update = self.optimizer.minimize(self.loss)