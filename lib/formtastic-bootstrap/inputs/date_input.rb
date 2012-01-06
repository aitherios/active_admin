module FormtasticBootstrap
  module Inputs
    class DateInput < Formtastic::Inputs::DateInput
      include Base
      include Base::Stringish
      include Formtastic::Inputs::Base::Timeish

      def to_html
        generic_input_wrapping do
          inline_inputs_div_wrapping do
            fragments.map do |fragment|
              fragment_input_html(fragment)
            end.join.html_safe
          end
        end
      end

    end
  end
end