# frozen_string_literal: true

class Docs::VisualCodeExample < ApplicationComponent
    def initialize(title: nil, description: nil, code: "Code snippet coming soon...")
        @title = title
        @description = description
        @code = code
    end

    def template(&block)
        div(id: @title) do
            render_header if @title || @description
            render_tabs(&block)
        end
    end

    private

    def render_header
        div(class: 'space-y-1 mb-4') do
            render Typography::H4.new { @title } if @title
            render Typography::P.new { @description } if @description
        end
    end

    def render_tabs(&block)
        render Tabs.new(default_value: "preview") do
            render_tab_triggers
            render_tab_contents(&block)
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
