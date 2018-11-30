class ConvertController < ApplicationController
  def convert
    clean_raw_html = params[:html].gsub!('{{ ', '{{')
    clean_raw_html.gsub!(' }}', '}}')

    premailer = Premailer.new(clean_raw_html, with_html_string: true)

    converted_html = premailer.to_inline_css
    converted_text = premailer.to_plain_text

    # replace html entities due to this bug https://github.com/premailer/premailer/issues/193
      # says it's fixed, but it's actually not
    converted_text.gsub!('%7B%7B%20', '{{ ')
    converted_text.gsub!('%7B%7B', '{{')
    converted_text.gsub!('%20%7D%7D', ' }}')
    converted_text.gsub!('%7D%7D', '}}')

    render :json => { html: converted_html, text: converted_text }
  end
end
