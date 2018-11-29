%matplotlib inline
# math libs
import math
import numpy as np
from scipy.spatial import distance
from scipy.spatial import ConvexHull

# plotting libs
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D

import random

def parse_points(points):
    X = [elem[0] for elem in points]
    Y = [elem[1] for elem in points]
    return X, Y

def gen_random_point(dim, lower=-1e1, upper=1e1):
    return [random.uniform(lower, upper) for i in range(dim)]

def plot_points(points,
                size=(15,12),
                style='g.', legend='No label'):
    pp = parse_points(points)
    figure = plt.figure(figsize=size)
    ax = figure.gca(projection='3d')
    ax.scatter(pp[0], pp[1],label=legend, alpha=0.6)
    ax.set_xlabel('x axis')
    ax.set_ylabel('y axis')
    ax.legend()
    
    return ax

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
#Let  be m distinct points in  and  be  positive numbers.


x = np.array([        
        np.array([1,-1]),
        np.array([1,-1]),
        np.array([1,1]),
        np.array([1,1]),
        np.array([-1,1]),
        np.array([-1,1]),
        np.array([-1,-1]),
        np.array([-1,-1]),
        np.array([1.5,0]),
        np.array([-1.5,0]),
        np.array([0,1.5]),
        np.array([0,-1.5]),
        np.array([0,0]),
        np.array([0,0])
    ])

eta = np.array([random.randint(1, 1e1) for i in range(len(x))])

print(eta)

plot_points(x, legend="set of {x}")
#Let initialise  with some values.
"""#------------------
import matplotlib.pyplot as plt
plt.plot([1,1,1,1,-1,-1,-1,-1,1.5,-1.5,0,0,0,0], [-1,-1,1,1,1,1,-1,-1,0,0,1.5,-1.5,0,0], 'ro')
matplotlib.pyplot.scatter([-9.37574394e-11],[-1.53832939e-10],color=['blue'])
plt.axis([0, 2, 0, 2])
plt.show()
#--------------------"""
y_0 = np.array([1.5,1.5])
epsilon = 1e-10
mwzfld = ModifiedWeiszfeld(x, eta)
mwzfld.solve(y_0, epsilon)
mwzfld.x[-1]


figure = plt.figure(figsize=(15,12))
ax = figure.gca(projection='3d')

pp = parse_points(x)
ax.plot(pp[0], pp[1], 'g.', alpha=0.6)

pp = parse_points(mwzfld.x)
ax.plot(pp[0], pp[1], 'r.', alpha=0.6)

ax.set_xlabel('x axis')
ax.set_ylabel('y axis')

figure.suptitle('A Modified Weiszfeld algorhitm')
ax.legend(['set of {x}', 'set of {y}'])
            