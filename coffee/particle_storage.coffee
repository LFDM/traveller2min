# Particle, ParticleStorage

#= require <boundary_handler>

class Particle
  constructor: (parameter_value, objective_value) ->
    @parameter_value = parameter_value
    @objective_value = objective_value
class ParticleStorage
  constructor: (parameter) ->
    @parameter = parameter
    @boundary_handler = new boundary_handler @parameter.search_space
  shuffle:  ->
    @particles = new Array()
    @current_best_particle = null
    shuffling_i = 0
    while shuffling_i < @parameter.number_of_particles
      @add_random_particle()
      shuffling_i++

  check_best_particle: (new_particle) ->
    return  if @current_best_particle? and @current_best_particle.objective_value < new_particle.objective_value
    @parameter.on_best_particle_changes(new_particle) 
    @current_best_particle = new_particle

  check_parameter_value_in_search_space: (parameter_value) ->
    @boundary_handler.check_parameter_value_in_search_space parameter_value

  construct_particle: (parameter_value, objective_value) ->
    new Particle parameter_value, objective_value

  add: (parameter_value, objective_value) ->
    particle = @construct_particle parameter_value, objective_value
    @particles.push particle
    @parameter.on_particle_creation particle
    @check_best_particle particle

  add_random_particle: ->
    parameter_value = @boundary_handler.create_random_parameter_value()
    objective_value = @parameter.objective(parameter_value)
    @add parameter_value, objective_value

  # TODO: make create function, check distance, quasi-random
  pick_random_particle: ->
    index = Math.round(Math.random() * (@particles.length - 1))
    @particles[index]

Particle::dominates = (other) ->
  @objective_value < other.objective_value


Particle::to_string = ->
  display_float = (float) ->
     if float < 0.0000001
       0
     float
  parameter_value = "("
  for dimension_value in @parameter_value
     parameter_value += display_float(dimension_value) + ", "
  parameter_value += ")"
  objective_value = display_float @objective_value
  "parameter value: " + parameter_value + "<br/>objective value: " + objective_value
