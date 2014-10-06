module Rivendell::Export
  class Cuts

    attr_accessor :group

    def initialize(options = {})
      options.each { |k,v| send "#{k}=", v }
    end

    def cart_scope
      if group
        Rivendell::DB::Group.get(group).carts
      else
        Rivendell::DB::Cart
      end
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
