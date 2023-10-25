# frozen_string_literal: true

class Docs::ShortcutKeyView < ApplicationView
  def template
    div(class: "max-w-2xl mx-auto w-full py-10 space-y-10") do
      div(class: 'space-y-2') do
        render Typography::H1.new { "Shortcut Key" }
        render Typography::P.new { "A component for displaying keyboard shortcuts." }
      end

      code_example = <<~RUBY
        div(class: "flex flex-col items-center gap-y-4") do
          render ShortcutKey.new do
            span(class: "text-xs") { "⌘" }
            plain "K"
          end
          p(class: "text-muted-foreground text-sm text-center") { "Note this is just for visualisation" }
        end
      RUBY
      render Docs::VisualCodeExample.new(code: code_example) do
        eval(code_example)
      end

      render Docs::InstallationInstructionsComingSoon.new
    end
  end
end
