require_relative 'DataStructures/asteroid'

# AsteroidCounterWithArray#asteroids_remaining_after_collisions returns an array 
# of all the asteroids remaining after collisions.

# It runs in O(n ** 2) time and O(n) space, where n is the number of asteroids 
# before collisions.

# Array#delete(item) runs in O(n) time and we call it while iterating through 
# all n elements, so the method runs in O(n ** 2) time.

class AsteroidCounterWithArray
	attr_reader :asteroids

	def initialize(asteroids_array)
		@asteroids = asteroids_array
	end

	def asteroids_remaining_after_collisions
		asteroids_copy, i = asteroids.dup, 0

		while i < asteroids_copy.length - 1
			eliminated_asteroid = 
				Asteroid.eliminated_in_collision(asteroids_copy[i], asteroids_copy[i + 1])

			if eliminated_asteroid
				asteroids_copy.delete(eliminated_asteroid)
			else
				i += 1
			end
		end

		i = asteroids_copy.length - 1

		while i > 0
			eliminated_asteroid = 
				Asteroid.eliminated_in_collision(asteroids_copy[i - 1], asteroids_copy[i])

			if eliminated_asteroid
				asteroids_copy.delete(eliminated_asteroid)
			else
				i -= 1
			end
		end

		asteroids_copy
	end

	def rightward_asteroid_count_after_collisions
		asteroids_remaining_after_collisions.count {|ast| ast.dir == :right }
	end
end

asteroids1 = [Asteroid.new(:right, 5), Asteroid.new(:left, 3), 
	Asteroid.new(:left, 4), Asteroid.new(:right, 2), Asteroid.new(:right, 6), 
	Asteroid.new(:left, 7), Asteroid.new(:right, 8)]

asteroids2 = [Asteroid.new(:left, 3), Asteroid.new(:right, 9), 
	Asteroid.new(:left, 4), Asteroid.new(:right, 2), Asteroid.new(:right, 6), 
	Asteroid.new(:left, 7), Asteroid.new(:right, 8)]

asteroids3 = [Asteroid.new(:right, 9), Asteroid.new(:left, 4), 
	Asteroid.new(:right, 2), Asteroid.new(:right, 6), Asteroid.new(:left, 3), 
	Asteroid.new(:left, 7), Asteroid.new(:right, 8), Asteroid.new(:left, 10)]

p AsteroidCounterWithArray.new(asteroids1).asteroids_remaining_after_collisions
p AsteroidCounterWithArray.new(asteroids2).asteroids_remaining_after_collisions
p AsteroidCounterWithArray.new(asteroids3).asteroids_remaining_after_collisions
p AsteroidCounterWithArray.new(asteroids1).rightward_asteroid_count_after_collisions
p AsteroidCounterWithArray.new(asteroids2).rightward_asteroid_count_after_collisions
p AsteroidCounterWithArray.new(asteroids3).rightward_asteroid_count_after_collisions
