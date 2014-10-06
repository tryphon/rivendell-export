require "rivendell/export/version"

require 'active_support/core_ext/class/attribute_accessors'
require 'active_support/core_ext/module/delegation'
require 'active_support/core_ext/string/inflections.rb'
require 'progressbar'
require 'rivendell/db'
require 'rsox-command'
require 'logger'

I18n.enforce_available_locales = false

module Rivendell
  module Export
    # Your code goes here...
  end
end

require "rivendell/export/cut"
require "rivendell/export/cuts"
