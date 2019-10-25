"""
There are two target networks in the DQN , the action - value function and the target 
action value function. 

When we are about to update the neural networks parameters , we start by drawing from the minibatch with 32 transitions
With the simplicity basis we consider one transition now, it consists of a state, an aciton that was performed in the stateself.
the recieved reward, the new state and a bool saying whether the episode is over. 

The step that is taken place is a gradient descent step, the main network tends to look
at the state and estimates the Q_prediction values which attempt to determine what is 
the advantage of taking a particular action at a state. 

The Q_target values are normally conducted through the traditional bellman equation,
then we compare the estimates of Q_prediction to the target Q_target. The quadratic loss
function is used for simplicity: 

        L = 1/2(Q_prediction - Q_target)^2

this introduces a regression for the current Q_prediction values for state towards the 
Q_target values

The point of using two networks is that both the Q_prediciton and Q_target are dependent
on the same parameters therefore it introduces a notion of instability when only one network
is used for Q_prediction's regression towards Q_target values this happens through a "Moving Target"
The target value remains unstable which can cause the algorithm to diverge. Therefore
by introducing a new network for the Q_target values we are able to have fixed target values and only
have to occasionally update parameters of the target Q_values while Q_prediction would have continious 
parameter updates. 

Minh et al 2015:
    Non- linear function approximators are deemed to have instability and cause divergence within 
    the training of an Agent. One of the key problems with the use of Neural networks a common type of 
    Non-linear function approximator is that small updates in the Q value may significantly change the 
    policy and the data distribution. 

    To address this problem we introduce two key_ideas:
        1. Experience replay -> randomizes batchs of previous traversed nodes by the agent so that the agnet
        can learn through those previous experiences this tends to remove correlations in the observeration sequence
        and normalizes the data distribution
        2. the iterative update updatse the action values(Q) towards target values thereby reducing correlations 
        with the target. 

Double Q - learning
Dqn has been observed to estimate very high values for the Q - values which tend to also
be unrealistic, this is due to the bellman equation which includes the maximization
step estimated action values , which tends to prefer overestimated values due to the 
nature of choosing the action with the best Q - value, 
        1. The point being that if all values were incremented uniformly then there
        would be no problem but there are certain biases to overestimation of the 
        Q values and due to it being non - uniform this is where the main problem is
        arising. 
        2. The algoirthm only yields more accurate value estimates , but leads to much
        higher scores on several games, this demonstrates that the overestimations of
        DQN were indeed leading to poorer policies and that it is beneficial to 
        reduce them. 
The estimated q values are noisy , true Q value is - for all actions, but because of
noisy of estimations. Some Q values tend to be slightly positive and others slightly 
negative. Max positive q value tends to always choose the small positive values, 
despite this the functions are not actually better. Instead of generating Q - values
with just the target network, we change to use a main network to estimate which action
is the best and then ask the target network how high the Q value is for that datetime A combination of a date and a time.
Therefore the main network tends to prefer the action , small positive Q but beacuse 
of the noisy kind of results estimation, The target network will predict a small
positive or small negative Q - value for that action and on average, the predicted
Q - values will be closer to 0. 

the reason for overestimation is that the expectation of a maximum is greater than or 
equal to the maximum of an expectation. 

There is a chnage in the bellman equation, where the main network that is estimated 
the next action for the next state is the best. The target network then tends to estimate
what the q value of the action is. 

Normal DQN: Ask the target network for the highest Q value , if the noisy Q values are for
example for actions with index 0 and 1 respectively , the target Q network will answer 0.1

Double DQN: ask the main network which action has the highest Q-value, if the noisy Q values are for
actions with index 0 and 1 respectively. Main networks tend to asnwer that action with index 0
has the highest q value, the target network which has different noise with what the Q - values for the next
action-value for action with the chosen index (0 in this example) is. Let's assume the target network's
noisy estimates will answer. 

problem of overesitmated Q values beacuse the two netwaorks have different noise and the bias
towards slightly larger noisy Q - values cancels
""" 

def learn(session, replay_memory, main_dqn, target_dqn, batch_size, gamma):
    """
    Args:
        session: A tensorflow sesson object
        replay_memory: A ReplayMemory object
        main_dqn: A DQN object
        target_dqn: A DQN object
        batch_size: Integer, Batch size
        gamma: Float, discount factor for the Bellman equation
    Returns:
        loss: The loss of the minibatch, for tensorboard
    Draws a minibatch from the replay memory, calculates the 
    target Q-value that the prediction Q-value is regressed to. 
    Then a parameter update is performed on the main DQN.
    """
    # Draw a minibatch from the replay memory
    states, actions, rewards, new_states, terminal_flags = replay_memory.get_minibatch()    
    # The main network estimates which action is best (in the next 
    # state s', new_states is passed!) 
    # for every transition in the minibatch
    arg_q_max = session.run(main_dqn.best_action, feed_dict={main_dqn.input:new_states})
    # The target network estimates the Q-values (in the next state s', new_states is passed!) 
    # for every transition in the minibatch
    q_vals = session.run(target_dqn.q_values, feed_dict={target_dqn.input:new_states})
    double_q = q_vals[range(batch_size), arg_q_max]
    # Bellman equation. Multiplication with (1-terminal_flags) makes sure that 
    # if the game is over, targetQ=rewards
    target_q = rewards + (gamma*double_q * (1-terminal_flags))
    # Gradient descend step to update the parameters of the main network
    loss, _ = session.run([main_dqn.loss, main_dqn.update], 
                          feed_dict={main_dqn.input:states, 
                                     main_dqn.target_q:target_q, 
                                     main_dqn.action:actions})
    return loss

"""

so this often tends to cause parameters of the main network are periodically copied every
10,000 steps to the target newtork. so there are simply peroid updates which are occuring for each
of these steps 

"""

class TargetNetworkUpdater(object):
    """Copies the parameters of the main DQN to the target DQN"""
    def __init__(self, main_dqn_vars, target_dqn_vars):
        """
        Args:
            main_dqn_vars: A list of tensorflow variables belonging to the main DQN network
            target_dqn_vars: A list of tensorflow variables belonging to the target DQN network
        """
        self.main_dqn_vars = main_dqn_vars
        self.target_dqn_vars = target_dqn_vars

    def _update_target_vars(self):
        update_ops = []
        for i, var in enumerate(self.main_dqn_vars):
            copy_op = self.target_dqn_vars[i].assign(var.value())
            update_ops.append(copy_op)
        return update_ops
            
    def __call__(self, sess):
        """
        Args:
            sess: A Tensorflow session object
        Assigns the values of the parameters of the main network to the 
        parameters of the target network
        """
        update_ops = self._update_target_vars()
        for copy_op in update_ops:
            sess.run(copy_op)


"""
We can also use this function to generate a Gif
"""
def generate_gif(frame_number, frames_for_gif, reward, path):
    """
        Args:
            frame_number: Integer, determining the number of the current frame
            frames_for_gif: A sequence of (210, 160, 3) frames of an Atari game in RGB
            reward: Integer, Total reward of the episode that es ouputted as a gif
            path: String, path where gif is saved
    """
    for idx, frame_idx in enumerate(frames_for_gif): 
        frames_for_gif[idx] = resize(frame_idx, (420, 320, 3), 
                                     preserve_range=True, order=0).astype(np.uint8)
        
    imageio.mimsave(f'{path}{"ATARI_frame_{0}_reward_{1}.gif".format(frame_number, reward)}', 
                    frames_for_gif, duration=1/30)