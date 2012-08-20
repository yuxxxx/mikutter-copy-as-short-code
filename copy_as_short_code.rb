# -*- coding: utf-8 -*-
# ツイートをブログとかに埋め込むときのショートコードをクリップボードに投げつけるだけの簡単なおしごとをします。
# [tweet http://twitter.com/{screen_name}/status/{message_id} lang='ja'] みたいな感じでコピーされます。
# はてなダイアリーやはてなブログで使えます。他にも使えるサービスはあるかもしれないけれど…

Plugin.create(:copy_as_short_code) do

 command(:copy_as_short_code,
         name: 'ショートコード形式でコピー',
         condition: lambda{ |opt| true },
         visible: true,
         role: :timeline) do |opt|
    message = opt.messages.first
    screen_name = message.user[:idname]
    Gtk::Clipboard.copy("[tweet http://twitter.com/#{screen_name}/status/#{message.id} #{UserConfig[:copy_as_short_code_align]}lang='ja']") end
  
  settings("ショートコード") do
    select('配置', :copy_as_short_code_align) do
      option "", "なし"
      option "align='left' ", "左" 
      option "align='right' ", "右" 
      option "align='center' ", "中央" 
    end
  end
end

