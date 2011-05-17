require 'coderay'
 require 'htmlentities'

 class CodeFilter < Nanoc3::Filter
  identifier :code
  type :text

  def run(content, params={})
   regex = %r{(<code class="(\w+)">(.+?)</code>)}m

   while content =~ regex
    original, language, code = $1, $2, $3

    if code
     # Convert tabs to spaces
     code.gsub!("\t", ' ')

     # Convert HTML entities
     coder = HTMLEntities.new
     code = coder.decode(code)

     content.gsub!(
      original, 
      '<code>' + CodeRay.scan(code, language).html + '</code>'
     )
    end
   end
   content
  end
 end
