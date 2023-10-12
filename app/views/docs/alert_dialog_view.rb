# frozen_string_literal: true

class Docs::AlertDialogView < ApplicationView
  def template
    div(class: "max-w-2xl mx-auto w-full py-10 space-y-8") do
      div(class: 'space-y-2') do
        render Typography::H1.new { "Alert Dialog" }
        render Typography::P.new { "A modal dialog that interrupts the user with important content and expects a response." }
      end

      render Docs::Component.new(title: "Default") do
        render AlertDialog.new do |alert_dialog|
          render AlertDialogTrigger.new do
            render Button.new { "Show dialog" }
          end
          render AlertDialogContent.new() do
            render AlertDialogHeader.new do
              h2(class: "text-lg font-semibold") do
                "Are you absolutely sure?"
              end
              p(id: "radix-:r4p:", class: "text-sm text-muted-foreground") do
                "This action cannot be undone. This will permanently delete your account and remove your data from our servers."
              end
            end
            div(class: "flex flex-col-reverse sm:flex-row sm:justify-end sm:space-x-2") do
              button(
                type: "button",
                class: "inline-flex items-center justify-center rounded-md text-sm font-medium transition-colors focus-visible:outline-none focus-visible:ring-1 focus-visible:ring-ring disabled:pointer-events-none disabled:opacity-50 border border-input bg-transparent shadow-sm hover:bg-accent hover:text-accent-foreground h-9 px-4 py-2 mt-2 sm:mt-0",
                data: { action: 'click->dismissable#dismiss' }
              ) { "Cancel" }
              button(
                type: "button",
                class:
                  "inline-flex items-center justify-center rounded-md text-sm font-medium transition-colors focus-visible:outline-none focus-visible:ring-1 focus-visible:ring-ring disabled:pointer-events-none disabled:opacity-50 bg-primary text-primary-foreground shadow hover:bg-primary/90 h-9 px-4 py-2"
              ) { "Continue" }
            end
          end
        end
      end
    end
  end
end
