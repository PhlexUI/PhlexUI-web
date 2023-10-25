# frozen_string_literal: true

class Docs::VisualCodeExample < ApplicationComponent
    def initialize(title: nil, description: nil, code: "Code snippet coming soon...", locked: false)
        @title = title
        @description = description
        @code = code
        @locked = locked
    end

    def template(&block)
        div(id: @title) do
            div(class: 'relative') do
                render Tabs.new(default_value: "preview") do
                    div(class: 'flex justify-between items-end mb-4 gap-x-2') do
                        render_header
                        div(class: 'flex-grow') # Spacer 
                        if @locked
                            render_unlock_component
                        else
                            render_tab_triggers
                        end
                    end
                    if @locked
                        render_preview_tab(&block)
                    else
                        render_tab_contents(&block)
                    end
                end
            end
        end
    end

    private

    def render_unlock_component
        div(class: 'flex justify-end') do
            render Link.new(href: helpers.root_path(anchor: :pricing), variant: :ghost, class: 'text-violet-500 flex-shrink-0') do
                plain "Get the code"
                svg(
                    xmlns: "http://www.w3.org/2000/svg",
                    viewbox: "0 0 20 20",
                    fill: "currentColor",
                    class: "w-4 h-4 ml-1"
                ) do |s|
                    s.path(
                        fill_rule: "evenodd",
                        d:
                        "M3 10a.75.75 0 01.75-.75h10.638L10.23 5.29a.75.75 0 111.04-1.08l5.5 5.25a.75.75 0 010 1.08l-5.5 5.25a.75.75 0 11-1.04-1.08l4.158-3.96H3.75A.75.75 0 013 10z",
                        clip_rule: "evenodd"
                    )
                end
            end
        end
    end

    def render_header
        div do
            h4(class: 'mb-1 font-medium text-lg') { @title } if @title
            p { @description } if @description
        end
    end

    def render_tab_triggers
        render TabsList.new do
            render_tab_trigger("preview", "Preview", method(:eye_icon))
            render_tab_trigger("code", "Code", method(:code_icon))
        end
    end

    def render_tab_trigger(value, label, icon_method)
        render TabsTrigger.new(value: value) do
            icon_method.call
            span { label }
        end
    end

    def render_tab_contents(&block)
        render TabsContent.new(value: "preview") { render_preview_tab(&block) }
        render TabsContent.new(value: "code") { render_code_tab }
    end

    def render_preview_tab(&block)
        div(class: 'mt-2 ring-offset-background focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2 relative rounded-md border') do
            div(class: 'preview flex min-h-[350px] w-full justify-center p-10 items-center', &block)
        end
    end

    def render_code_tab
        div(class: 'mt-2 ring-offset-background focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2 relative rounded-md border') do
            render Codeblock.new { @code }
            # div(class: "w-full rounded-md [&_pre]:my-0 [&_pre]:max-h-[350px] [&_pre]:overflow-auto") do
            #     div(data_rehype_pretty_code_fragment: "") do
            #         pre(class: "mb-4 mt-6 max-h-[650px] overflow-x-auto rounded-md border text-white bg-zinc-950 py-4 dark:bg-zinc-900") do
            #             code(class: "relative rounded px-6 py-[0.2rem] font-mono text-sm") { @code }
            #         end
            #     end
            # end
        end
    end

    def eye_icon
        svg(
            xmlns: "http://www.w3.org/2000/svg",
            fill: "none",
            viewbox: "0 0 24 24",
            stroke_width: "1.5",
            stroke: "currentColor",
            class: "w-4 h-4 mr-2"
            ) do |s|
            s.path(
                stroke_linecap: "round",
                stroke_linejoin: "round",
                d:
                "M2.036 12.322a1.012 1.012 0 010-.639C3.423 7.51 7.36 4.5 12 4.5c4.638 0 8.573 3.007 9.963 7.178.07.207.07.431 0 .639C20.577 16.49 16.64 19.5 12 19.5c-4.638 0-8.573-3.007-9.963-7.178z"
            )
            s.path(
                stroke_linecap: "round",
                stroke_linejoin: "round",
                d: "M15 12a3 3 0 11-6 0 3 3 0 016 0z"
            )
        end
    end

    def code_icon
        svg(
            xmlns: "http://www.w3.org/2000/svg",
            fill: "none",
            viewbox: "0 0 24 24",
            stroke_width: "1.5",
            stroke: "currentColor",
            class: "w-4 h-4 mr-2"
            ) do |s|
            s.path(
                stroke_linecap: "round",
                stroke_linejoin: "round",
                d: "M17.25 6.75L22.5 12l-5.25 5.25m-10.5 0L1.5 12l5.25-5.25m7.5-3l-4.5 16.5"
            )
        end
    end
end
