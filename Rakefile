require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "memcached_stats"
    gem.summary = %Q{Gather Memcached Stats as well as Slabs}
    gem.description = %Q{Gather Memcached Stats as well as Slabs}
    gem.email = "bananastalktome@gmail.com"
    gem.homepage = "http://github.com/bananastalktome/memcached_stats"
    gem.authors = ["William Schneider"]
    gem.add_development_dependency "thoughtbot-shoulda", ">= 0"
    gem.files = Dir.glob('lib/**/*.rb')
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end

begin
  require 'rcov/rcovtask'
  Rcov::RcovTask.new do |test|
    test.libs << 'test'
    test.pattern = 'test/**/test_*.rb'
    test.verbose = true
  end
rescue LoadError
  task :rcov do
    abort "RCov is not available. In order to run rcov, you must: sudo gem install spicycode-rcov"
  end
end

task :test => :check_dependencies

task :default => :test

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "memcached_stats #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

## Task to convert markup to html, so I can check the output before committing. Makes life easier.
task :markup do
  require 'RedCloth'
  textile = File.open("#{File.dirname(__FILE__)}/README.textile")
  output = RedCloth.new(textile.read).to_html
  file = "#{File.dirname(__FILE__)}/README.html"
  if File.exists?(file)
    File.delete file
  end
  final = github_markup_text(output)
  File.open(file, "w") { |f| f.write(final) }
end

def github_markup_text(output); GITHUB_STYLE_WRAP+output+"</div></body></html>" end

GITHUB_STYLE_WRAP = <<-eos
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html id="readme">
<head>
<style type="text/css">
* { margin:0; padding: 0; }
body * {
line-height:1.4em;
}
#readme {
font:13.34px helvetica,arial,freesans,clean,sans-serif;
}
#readme.announce {
margin:1em 0;
}
#readme span.name {
font-size:140%;
padding:0.8em 0;
}
#readme div.plain, #readme div.wikistyle {
background-color:#F8F8F8;
padding:0.7em;
}
#readme.announce div.plain, #readme.announce div.wikistyle {
border:1px solid #E9E9E9;
}
#readme.blob div.plain, #readme.blob div.wikistyle {
border-top:medium none;
}
#readme div.plain pre {
color:#444444;
font-family:'Bitstream Vera Sans Mono','Courier',monospace;
font-size:85%;
}
#missing-readme {
background-color:#FFFFCC;
border:1px solid #CCCCCC;
font:13.34px helvetica,arial,freesans,clean,sans-serif;
padding:0.7em;
text-align:center;
}
#readme.rst .borderless, #readme.rst table.borderless td, #readme.rst table.borderless th {
border:0 none;
}
#readme.rst table.borderless td, #readme.rst table.borderless th {
padding:0 0.5em 0 0 !important;
}
#readme.rst .first {
margin-top:0 !important;
}
#readme.rst .last, #readme.rst .with-subtitle {
margin-bottom:0 !important;
}
#readme.rst .hidden {
display:none;
}
#readme.rst a.toc-backref {
color:black;
text-decoration:none;
}
#readme.rst blockquote.epigraph {
margin:2em 5em;
}
#readme.rst dl.docutils dd {
margin-bottom:0.5em;
}
#readme.rst div.abstract {
margin:2em 5em;
}
#readme.rst div.abstract p.topic-title {
font-weight:bold;
text-align:center;
}
#readme.rst div.admonition, #readme.rst div.attention, #readme.rst div.caution, #readme.rst div.danger, #readme.rst div.error, #readme.rst div.hint, #readme.rst div.important, #readme.rst div.note, #readme.rst div.tip, #readme.rst div.warning {
border:medium outset;
margin:2em;
padding:1em;
}
#readme.rst div.admonition p.admonition-title, #readme.rst div.hint p.admonition-title, #readme.rst div.important p.admonition-title, #readme.rst div.note p.admonition-title, #readme.rst div.tip p.admonition-title {
font-family:sans-serif;
font-weight:bold;
}
#readme.rst div.attention p.admonition-title, #readme.rst div.caution p.admonition-title, #readme.rst div.danger p.admonition-title, #readme.rst div.error p.admonition-title, #readme.rst div.warning p.admonition-title {
color:red;
font-family:sans-serif;
font-weight:bold;
}
#readme.rst div.dedication {
font-style:italic;
margin:2em 5em;
text-align:center;
}
#readme.rst div.dedication p.topic-title {
font-style:normal;
font-weight:bold;
}
#readme.rst div.figure {
margin-left:2em;
margin-right:2em;
}
#readme.rst div.footer, #readme.rst div.header {
clear:both;
font-size:smaller;
}
#readme.rst div.line-block {
display:block;
margin-bottom:1em;
margin-top:1em;
}
#readme.rst div.line-block div.line-block {
margin-bottom:0;
margin-left:1.5em;
margin-top:0;
}
#readme.rst div.sidebar {
background-color:#FFFFEE;
border:medium outset;
clear:right;
float:right;
margin:0 0 0.5em 1em;
padding:1em;
width:40%;
}
#readme.rst div.sidebar p.rubric {
font-family:sans-serif;
font-size:medium;
}
#readme.rst div.system-messages {
margin:5em;
}
#readme.rst div.system-messages h1 {
color:red;
}
#readme.rst div.system-message {
border:medium outset;
padding:1em;
}
#readme.rst div.system-message p.system-message-title {
color:red;
font-weight:bold;
}
#readme.rst div.topic {
margin:2em;
}
#readme.rst h1.section-subtitle, #readme.rst h2.section-subtitle, #readme.rst h3.section-subtitle, #readme.rst h4.section-subtitle, #readme.rst h5.section-subtitle, #readme.rst h6.section-subtitle {
margin-top:0.4em;
}
#readme.rst h1.title {
text-align:center;
}
#readme.rst h2.subtitle {
text-align:center;
}
#readme.rst hr.docutils {
width:75%;
}
#readme.rst img.align-left, #readme.rst .figure.align-left, #readme.rst object.align-left {
clear:left;
float:left;
margin-right:1em;
}
#readme.rst img.align-right, #readme.rst .figure.align-right, #readme.rst object.align-right {
clear:right;
float:right;
margin-left:1em;
}
#readme.rst img.align-center, #readme.rst .figure.align-center, #readme.rst object.align-center {
display:block;
margin-left:auto;
margin-right:auto;
}
#readme.rst .align-left {
text-align:left;
}
#readme.rst .align-center {
clear:both;
text-align:center;
}
#readme.rst .align-right {
text-align:right;
}
#readme.rst div.align-right {
text-align:left;
}
#readme.rst ol.simple, #readme.rst ul.simple {
margin-bottom:1em;
}
#readme.rst ol.arabic {
list-style:decimal outside none;
}
#readme.rst ol.loweralpha {
list-style:lower-alpha outside none;
}
#readme.rst ol.upperalpha {
list-style:upper-alpha outside none;
}
#readme.rst ol.lowerroman {
list-style:lower-roman outside none;
}
#readme.rst ol.upperroman {
list-style:upper-roman outside none;
}
#readme.rst p.attribution {
margin-left:50%;
text-align:right;
}
#readme.rst p.caption {
font-style:italic;
}
#readme.rst p.credits {
font-size:smaller;
font-style:italic;
}
#readme.rst p.label {
white-space:nowrap;
}
#readme.rst p.rubric {
color:maroon;
font-size:larger;
font-weight:bold;
text-align:center;
}
#readme.rst p.sidebar-title {
font-family:sans-serif;
font-size:larger;
font-weight:bold;
}
#readme.rst p.sidebar-subtitle {
font-family:sans-serif;
font-weight:bold;
}
#readme.rst p.topic-title {
font-weight:bold;
}
#readme.rst pre.address {
font:inherit;
margin-bottom:0;
margin-top:0;
}
#readme.rst pre.literal-block, #readme.rst pre.doctest-block {
margin-left:2em;
margin-right:2em;
}
#readme.rst span.classifier {
font-family:sans-serif;
font-style:oblique;
}
#readme.rst span.classifier-delimiter {
font-family:sans-serif;
font-weight:bold;
}
#readme.rst span.interpreted {
font-family:sans-serif;
}
#readme.rst span.option {
white-space:nowrap;
}
#readme.rst span.pre {
white-space:pre;
}
#readme.rst span.problematic {
color:red;
}
#readme.rst span.section-subtitle {
font-size:80%;
}
#readme.rst table.citation {
border-left:1px solid gray;
margin-left:1px;
}
#readme.rst table.docinfo {
margin:2em 4em;
}
#readme.rst table.docutils {
margin-bottom:0.5em;
margin-top:0.5em;
}
#readme.rst table.footnote {
border-left:1px solid black;
margin-left:1px;
}
#readme.rst table.docutils td, #readme.rst table.docutils th, #readme.rst table.docinfo td, #readme.rst table.docinfo th {
padding-left:0.5em;
padding-right:0.5em;
vertical-align:top;
}
#readme.rst table.docutils th.field-name, #readme.rst table.docinfo th.docinfo-name {
font-weight:bold;
padding-left:0;
text-align:left;
white-space:nowrap;
}
#readme.rst h1 tt.docutils, #readme.rst h2 tt.docutils, #readme.rst h3 tt.docutils, #readme.rst h4 tt.docutils, #readme.rst h5 tt.docutils, #readme.rst h6 tt.docutils {
font-size:100%;
}
#readme.rst ul.auto-toc {
list-style-type:none;
}
.wikistyle h1,.wikistyle h2,.wikistyle h3,.wikistyle h4,.wikistyle h5,.wikistyle h6{border:0!important;}
.wikistyle h1{font-size:170%!important;border-top:4px solid #aaa!important;padding-top:.5em!important;margin-top:1.5em!important;}
.wikistyle h1:first-child{margin-top:0!important;padding-top:.25em!important;border-top:none!important;}
.wikistyle h2{font-size:150%!important;margin-top:1.5em!important;border-top:4px solid #e0e0e0!important;padding-top:.5em!important;}
.wikistyle h3{margin-top:1em!important;}
.wikistyle p{margin:1em 0!important;line-height:1.5em!important;}
.wikistyle a.absent{color:#a00;}
.wikistyle ul,#wiki-form .content-body ul{margin:1em 0 1em 2em!important;}
.wikistyle ol,#wiki-form .content-body ol{margin:1em 0 1em 2em!important;}
.wikistyle ul li,#wiki-form .content-body ul li,.wikistyle ol li,#wiki-form .content-body ol li{margin-top:.5em;margin-bottom:.5em;}
.wikistyle ul ul,.wikistyle ul ol,.wikistyle ol ol,.wikistyle ol ul,#wiki-form .content-body ul ul,#wiki-form .content-body ul ol,#wiki-form .content-body ol ol,#wiki-form .content-body ol ul{margin-top:0!important;margin-bottom:0!important;}
.wikistyle blockquote{margin:1em 0!important;border-left:5px solid #ddd!important;padding-left:.6em!important;color:#555!important;}
.wikistyle dt{font-weight:bold!important;margin-left:1em!important;}
.wikistyle dd{margin-left:2em!important;margin-bottom:1em!important;}
.wikistyle table{margin:1em 0!important;}
.wikistyle table th{border-bottom:1px solid #bbb!important;padding:.2em 1em!important;}
.wikistyle table td{border-bottom:1px solid #ddd!important;padding:.2em 1em!important;}
.wikistyle pre{margin:1em 0!important;font-size:12px!important;background-color:#f8f8ff!important;border:1px solid #dedede!important;padding:.5em!important;line-height:1.5em!important;color:#444!important;overflow:auto!important;}
.wikistyle pre code{padding:0!important;font-size:12px!important;background-color:#f8f8ff!important;border:none!important;}
.wikistyle code{font-size:12px!important;background-color:#f8f8ff!important;color:#444!important;padding:0 .2em!important;border:1px solid #dedede!important;}
.wikistyle a code,.wikistyle a:link code,.wikistyle a:visited code{color:#4183c4!important;}
.wikistyle img{max-width:100%;}
.wikistyle pre.console{margin:1em 0!important;font-size:12px!important;background-color:black!important;padding:.5em!important;line-height:1.5em!important;color:white!important;}
.wikistyle pre.console code{padding:0!important;font-size:12px!important;background-color:black!important;border:none!important;color:white!important;}
.wikistyle pre.console span{color:#888!important;}
.wikistyle pre.console span.command{color:yellow!important;}
.wikistyle .frame{margin:0;display:inline-block;}
.wikistyle .frame img{display:block;}
.wikistyle .frame>span{display:block;border:1px solid #aaa;padding:4px;}
.wikistyle .frame span span{display:block;font-size:10pt;margin:0;padding:4px 0 2px 0;text-align:center;line-height:10pt;font-family:'Helvetica Neue',Helvetica,Arial,sans-serif;}
.wikistyle .float-left{float:left;padding:.5em 1em .25em 0;}
.wikistyle .float-right{float:right;padding:.5em 0 .25em 1em;}
.wikistyle .align-left{display:block;text-align:left;}
.wikistyle .align-center{display:block;text-align:center;}
.wikistyle .align-right{display:block;text-align:right;}
.wikistyle.gollum.footer{border-top:4px solid #f0f0f0;margin-top:2em;}
.wikistyle.gollum>h1:first-child{display:none;}
.wikistyle.gollum.asciidoc>div#header>h1:first-child{display:none;}
.wikistyle.gollum.asciidoc .ulist p,.wikistyle.gollum.asciidoc .olist p{margin:0!important;}
.wikistyle.gollum.asciidoc .loweralpha{list-style-type:lower-alpha;}
.wikistyle.gollum.asciidoc .lowerroman{list-style-type:lower-roman;}
.wikistyle.gollum.asciidoc .upperalpha{list-style-type:upper-alpha;}
.wikistyle.gollum.asciidoc .upperroman{list-style-type:upper-roman;}
.wikistyle.gollum.org>p.title:first-child{display:none;}
.wikistyle.gollum.org p:first-child+h1{border-top:none!important;}
.wikistyle.gollum.pod>a.dummyTopAnchor:first-child+h1{display:none;}
.wikistyle.gollum.pod h1 a{text-decoration:none;color:inherit;}

</style>
</head>
<body>
<div class="wikistyle">
eos