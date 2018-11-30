class ConvertController < ApplicationController
  def convert
    premailer = Premailer.new(params[:html], with_html_string: true, line_length: 120)

    converted_html = premailer.to_inline_css
    converted_text = premailer.to_plain_text

    # replace html entities due to this bug https://github.com/premailer/premailer/issues/193
      # says it's fixed, but it's actually not
    converted_text.gsub!('%7B%7B%20', '{{ ')
    converted_text.gsub!('%7B%7B', '{{')
    converted_text.gsub!('%20%7D%7D', ' }}')
    converted_text.gsub!('%7D%7D', '}}')

    # fix other issues
    converted_text.gsub!('.html }}}', '.text }}}')

    render :json => { html: converted_html, text: converted_text }
  end
end
