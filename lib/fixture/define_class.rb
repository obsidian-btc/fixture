module Fixture
  module Define
    module DefineClass
      def define_class(name=nil, base=nil, &blk)
        raise "Class definition requires a block" unless block_given?

        name ||= "C#{RandomID.random_id}"

        class_const = DefineClass.get_class(name, self)

        class_const.class_eval(&blk)

        class_const
      end

      def self.get_class(name, outer=Object, base=nil)
        mod = nil

        if outer.const_defined?(name)
          mod = outer.const_get(name)
        else
          cls = base.nil? ? Class.new : Class.new(base)
          mod = outer.const_set(name, cls)
        end

        mod
      end
    end
  end
end
