x = 1

# def foo
#   puts x
# end

# foo

self.class.class_eval do
  define_method :foo do
    puts x
  end
end

foo
