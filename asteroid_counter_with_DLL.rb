require_relative 'DataStructures/asteroid'
require_relative 'DataStructures/doubly_linked_list'

# AsteroidCounterWithDLL#asteroids_remaining_after_collisions returns an array 
# of all the asteroids remaining after collisions.

# It runs in O(n) time and O(n) space, where n is the number of asteroids 
# before collisions. The advantage we gain in using a doubly linked list instead 
# of an array to store the asteroids is that DoublyLinkedList#remove(node) runs 
# in O(1) time, whereas Array#delete(item) runs in O(n) time.

class AsteroidCounterWithDLL
	attr_reader :asteroids

	def initialize(asteroids_array)
		@asteroids = asteroids_array
	end

	def asteroids_remaining_after_collisions
		asteroids_DLL = DoublyLinkedList.new(asteroids)

		previous_node, current_node = asteroids_DLL.head, asteroids_DLL.head.next

		while current_node
			eliminated_asteroid = 
				Asteroid.eliminated_in_collision(previous_node.value, current_node.value)

			if eliminated_asteroid
				previous_node, current_node = remove_eliminated_asteroid_node(
					asteroids_DLL, previous_node, current_node, eliminated_asteroid)
			else
				previous_node, current_node = current_node, current_node.next
			end
		end

		asteroids_DLL.to_a.map(&:value)
	end

	def find_eliminated_node(previous_node, current_node, eliminated_asteroid)
		[previous_node, current_node].find { |node| node.value == eliminated_asteroid }
	end

	def find_remaining_node(previous_node, current_node, eliminated_asteroid)
		[previous_node, current_node].find { |node| node.value != eliminated_asteroid }
	end

	def remove_eliminated_asteroid_node(asteroids_DLL, previous_node, 
			current_node, eliminated_asteroid)
		
		eliminated_node = 
			find_eliminated_node(previous_node, current_node, eliminated_asteroid)
		remaining_node = 
			find_remaining_node(previous_node, current_node, eliminated_asteroid)

		asteroids_DLL.remove(eliminated_node)

		if remaining_node.prev
			[remaining_node.prev, remaining_node]
		else
			[remaining_node, remaining_node.next]
		end
	end

	def rightward_asteroid_count_after_collisions
		# Same as in Array implementation
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

p AsteroidCounterWithDLL.new(asteroids1).asteroids_remaining_after_collisions
p AsteroidCounterWithDLL.new(asteroids2).asteroids_remaining_after_collisions
p AsteroidCounterWithDLL.new(asteroids3).asteroids_remaining_after_collisions
p AsteroidCounterWithDLL.new(asteroids1).rightward_asteroid_count_after_collisions
p AsteroidCounterWithDLL.new(asteroids2).rightward_asteroid_count_after_collisions
p AsteroidCounterWithDLL.new(asteroids3).rightward_asteroid_count_after_collisions
