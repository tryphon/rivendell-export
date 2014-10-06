module Rivendell::Export
  class Cuts

    attr_accessor :group, :scheduler_code

    def initialize(options = {})
      options.each { |k,v| send "#{k}=", v }
    end

    def cart_scope
      cart_scope =
        if group
          Rivendell::DB::Group.get(group).carts
        else
          Rivendell::DB::Cart
        end
      cart_scope = cart_scope.scheduler_code(scheduler_code) if scheduler_code
      cart_scope
    end

    def scope
      cart_scope.cuts
    end

    def each(&block)
      scope.each do |db_cut|
        yield Cut.new(db_cut)
      end
    end

    def count
      scope.count
    end

  end
end
