class Asteroid
	attr_reader :dir, :weight

	def initialize(dir, weight)
		@dir, @weight = dir, weight
	end

	def self.eliminated_in_collision(left_asteroid, right_asteroid)
		if left_asteroid.dir == :right && right_asteroid.dir == :left
			[left_asteroid, right_asteroid].min_by {|asteroid| asteroid.weight}
		end
	end
end
