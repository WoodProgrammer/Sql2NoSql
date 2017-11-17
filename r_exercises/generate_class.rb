class_name = 'foo'.capitalize
klass = Object.const_set(class_name,Class.new)

names = ['instance1', 'instance2'] # Array of instance vars

klass.class_eval do
  attr_accessor *names

  define_method(:initialize) do |*values|
    names.each_with_index do |name,i|
      instance_variable_set("@"+name, values[i])
      
    end
  end

end

