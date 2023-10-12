# frozen_string_literal: true

class Shared::Sidebar < ApplicationComponent
    def template
        aside(class: 'fixed top-14 z-30 -ml-2 hidden h-[calc(100vh-3.5rem)] w-full shrink-0 md:sticky md:block') do
            div(class: 'relative overflow-hidden h-full py-6 pl-8 pr-6 lg:py-8', style: 'position:relative;--radix-scroll-area-corner-width:0px;--radix-scroll-area-corner-height:0px') do
                div(class: 'h-full w-full rounded-[inherit]', style: 'overflow: hidden scroll;') do
                    div(class: 'pb-4') do
                        h4(class: 'mb-1 rounded-md px-2 py-1 text-sm font-semibold') { "Components" }
                        div(class: 'grid grid-flow-row auto-rows-max text-sm') do
                            components.each do |component|
                                component_link(component)
                            end
                        end
                    end
                end
            end
        end
    end

    def components
        [
            { name: "Accordion", path: helpers.docs_accordion_path },
            { name: "Link", path: helpers.docs_link_path },
            { name: "Typography", path: helpers.docs_typography_path },
        ]
    end

    def component_link(component)
        current_path = component[:path] == helpers.request.path
        return a(href: component[:path], class: tokens('group flex w-full items-center rounded-md border border-transparent px-2 py-1 hover:underline', -> { current_path } => "text-foreground font-medium", -> { !current_path } => "text-muted-foreground")) { component[:name] }
    end
end