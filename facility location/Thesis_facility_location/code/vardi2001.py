
# coding: utf-8

# In[1]:

get_ipython().magic('matplotlib inline')
# math libs
import math
import numpy as np
from scipy.spatial import distance
from scipy.spatial import ConvexHull

# plotting libs
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D

import random


# In[2]:

def parse_points(points):
    X = [elem[0] for elem in points]
    Y = [elem[1] for elem in points]
    Z = [elem[2] for elem in points]
    return X, Y, Z

def gen_random_point(dim, lower=-1e1, upper=1e1):
    return [random.uniform(lower, upper) for i in range(dim)]

def plot_points(points,
                size=(15,12),
                style='g.', legend='No label'):
    pp = parse_points(points)
    figure = plt.figure(figsize=size)
    ax = figure.gca(projection='3d')
    ax.plot(pp[0], pp[1], pp[2], style,label=legend, alpha=0.6)
    ax.set_xlabel('x axis')
    ax.set_ylabel('y axis')
    ax.set_zlabel('z axis')
    ax.legend()
    
    return ax


# In[3]:

class Algorithm:
    x = []
    
    def __init__(self, points, weights):
        self.points = points
        self.weights = weights

    def solve(self, x_0, epsilon): ...

    def _w(self, i, y):
        ans = self.weights[i] / distance.euclidean(y, self.points[i])
        coef = 0.
        for j in range(len(self.points)):
            if not np.array_equal(y, self.points[j]):
                coef = coef + self.weights[j] / distance.euclidean(y, self.points[j])
        return ans / coef

    def _tilde_T(self, y):
        ans = 0.
        for i in range(len(self.points)):
            if not np.array_equal(y, self.points[i]):
                ans = ans + self._w(i, y) * self.points[i]

        return ans


# ## A Modified Weiszfeld algorhitm

# Let $$d_i(y) \equiv \lVert y - x_i \rVert$$

# Than $$w_i(y) = \frac{\eta_i}{d_i(y)} \Big\{  \sum\limits_{x_j \neq y}^{} \frac{n_j}{d_j(y)} \Big\} ^{-1} $$

# $$\tilde{T}: y \to \tilde{T}(y) \equiv \sum\limits_{x_i \neq y}^{} w_i(y)x_i$$
# 
# Than
# 
# $$y \to T_0(y) = \begin{cases} \tilde{T}(y), & \mbox{if } y \notin \{x_1, ... , x_m \}\\ x_k, & \mbox{if } y = x_k, k = \overline{1,m} \end{cases}$$

# In[4]:

class ModifiedWeiszfeld(Algorithm):
    
    def _T_0(self, y):
        for x in self.points:
            if np.array_equal(y, x):
                return x

        return self._tilde_T(y)
    
    
    def solve(self, x_0, epsilon):
        self.x = [x_0, self._T_0(x_0)]

        while not distance.euclidean(self.x[-1], self.x[-2]) < epsilon:
            self.x.append(self._T_0(self.x[-1]))


# Let $x_1, ... , x_m$ be m distinct points in $R^{d}$ and $\eta_1, ... , \eta_m$ be $m$ positive numbers.

# In[5]:

x = np.array([        
        np.array([1,-1,1]),
        np.array([1,-1,-1]),
        np.array([1,1,1]),
        np.array([1,1,-1]),
        np.array([-1,1,1]),
        np.array([-1,1,-1]),
        np.array([-1,-1,1]),
        np.array([-1,-1,-1]),
        np.array([1.5,0,0]),
        np.array([-1.5,0,0]),
        np.array([0,1.5,0]),
        np.array([0,-1.5,0]),
        np.array([0,0,1.5]),
        np.array([0,0,-1.5])
    ])

eta = np.array([random.randint(1, 1e1) for i in range(len(x))])

print(eta)


# In[6]:

plot_points(x, legend="set of {x}")


# Let initialise $y_0$ with some values.

# In[7]:

y_0 = np.array([1.5,1.5,1.5])


# Let $\varepsilon = 1E^{-10}$.

# In[8]:

epsilon = 1e-10


# In[9]:

mwzfld = ModifiedWeiszfeld(x, eta)
mwzfld.solve(y_0, epsilon)
mwzfld.x[-1]


# In[10]:

figure = plt.figure(figsize=(15,12))
ax = figure.gca(projection='3d')

pp = parse_points(x)
ax.plot(pp[0], pp[1], pp[2], 'g.', alpha=0.6)

pp = parse_points(mwzfld.x)
ax.plot(pp[0], pp[1], pp[2], 'r.', alpha=0.6)

ax.set_xlabel('x axis')
ax.set_ylabel('y axis')
ax.set_zlabel('z axis')
figure.suptitle('A Modified Weiszfeld algorhitm')
ax.legend(['set of {x}', 'set of {y}'])


# ## The new algorithm

# $$y \to T(y) \equiv \Big( 1 - \frac{\eta(y)}{r(y)}\Big)^{+} \tilde{T}(y) + min \Big(1, \frac{\eta(y)}{r(y)}\Big)y$$
# 
# with convention 0/0 = 0 in the computation of $\eta(y) / r(y)$, where $\tilde{T}(y)$ is
# 
# $$\tilde{T}: y \to \tilde{T}(y) \equiv \sum\limits_{x_i \neq y}^{} w_i(y)x_i,$$
# 
# $$r(y) \equiv \lVert \tilde{R}(y) \rVert,$$
# 
# $$\tilde{R}(y) = \sum\limits_{x_i \neq y}^{} \eta_i \frac{x_i - y}{\lVert x_i - y \rVert}$$

# $$\eta(y) \equiv \begin{cases} \eta_k, & \mbox{if } y = x_k, k = \overline{1,m} \\ 0, & \mbox{if } y \notin \{ x_1, ... , x_m\} \end{cases}$$

# In[11]:

class NewAlgorithm(Algorithm):
    
    def _tilde_R(self, y):
        ans = np.zeros(len(y))
        for i in range(len(self.points)):
            if not np.array_equal(self.points[i], y):
                ans = ans + (self.points[i] - y) * self.weights[i] / distance.euclidean(self.points[i], y)
        return ans
    
    
    def _r(self, y):
        return distance.euclidean(0, self._tilde_R(y));
    
    
    def _Eta(self, y):
        for k in range(len(self.points)):
            if np.array_equal(y, self.points[k]):
                return self.weights[k]

        return 0
    
    
    def _new_tilde_T(self, y):
        tmp = self._Eta(y) / self._r(y)
        ans = max(0, 1 - tmp) * self._tilde_T(y) + min(1, tmp) * y
        return ans
    
    
    def solve(self, x_0, epsilon):
        self.x = [x_0, self._new_tilde_T(x_0)]

        while not distance.euclidean(self.x[-1], self.x[-2]) < epsilon:
            self.x.append(self._new_tilde_T(self.x[-1]))


# In[12]:

nalgo = NewAlgorithm(x, eta)
nalgo.solve(y_0, epsilon)
nalgo.x[-1]


# In[13]:

figure = plt.figure(figsize=(15,12))
ax = figure.gca(projection='3d')

pp = parse_points(x)
ax.plot(pp[0], pp[1], pp[2], 'g.', alpha=0.6)

pp = parse_points(nalgo.x)
ax.plot(pp[0], pp[1], pp[2], 'r.', alpha=0.6)

ax.set_xlabel('x axis')
ax.set_ylabel('y axis')
ax.set_zlabel('z axis')
figure.suptitle('The new algorithm')
ax.legend(['set of {x}', 'set of {y}'])


# In[14]:

print('A Modified Weiszfeld algorhitm calculate:', mwzfld.x[-1])
print('The new algorithm calculate:', nalgo.x[-1])


# ### Some tests

# In[15]:

def test(m, dimension):
    points = np.random.rand(m, dimension) # points from [0;1)
    hull = ConvexHull(points)
    points = [np.array(points[index]) for index in hull.vertices]
    weights = np.array([random.randint(1, 1000) for i in range(m)])

    started_point = np.array([random.uniform(-100., 100.) for i in range(dimension)])

    mwzfld = ModifiedWeiszfeld(points, weights)
    mwzfld.solve(started_point, 1e-5)

    nalgo = NewAlgorithm(points, weights)
    nalgo.solve(started_point, 1e-5)

    print('Dimension - ', dimension, ', count of points -', m)
    print('Weights:')
    print(weights)
    print('Modified -', mwzfld.x[-1], 'count of steps -', len(mwzfld.x))
    print('New algo -', nalgo.x[-1], 'count of steps -', len(nalgo.x))


# In[18]:

test(random.randint(100, 200), 2)
print('\n')

test(random.randint(100, 300), 3)
print('\n')

test(random.randint(100, 400), 4)
print('\n')

test(random.randint(100, 500), 5)


# In[ ]:



