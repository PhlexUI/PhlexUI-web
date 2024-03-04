# frozen_string_literal: true

class Docs::ShortcutKeyView < ApplicationView
  def template
    div(class: "max-w-2xl mx-auto w-full py-10 space-y-10") do
      render Docs::Header.new(title: "Shortcut Key", description: "A component for displaying keyboard shortcuts.")

      render PhlexUI::Typography::H2.new { "Usage" }

      render Docs::VisualCodeExample.new(title: "Example", context: self) do
        <<~RUBY
          div(class: "flex flex-col items-center gap-y-4") do
            render PhlexUI::ShortcutKey.new do
              span(class: "text-xs") { "⌘" }
              plain "K"
            end
            p(class: "text-muted-foreground text-sm text-center") { "Note this does not trigger anything, it is purely a visual prompt" }
          end
        RUBY
      end

      render Docs::ComponentsTable.new(components)
    end
  end

  private

  def components
    [
      Docs::ComponentStruct.new(name: "PhlexUI::ShortcutKey", source: "https://github.com/PhlexUI/phlex_ui/blob/main/lib/phlex_ui/shortcut_key.rb", built_using: :phlex)
    ]
  end
end
