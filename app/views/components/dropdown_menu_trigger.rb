# frozen_string_literal: true

class DropdownMenuTrigger < ApplicationComponent
    def initialize(**attributes)
        @attributes = attributes
    end

    def template(&)
        div(**@attributes, data: { popover_target: 'trigger' }, &)
    end
end