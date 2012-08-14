# -*- coding: utf-8 -*-
# ツイートをブログとかに埋め込むときのショートコードをクリップボードに投げつけるだけの簡単なおしごとをします。
# [tweet http://twitter.com/{screen_name}/status/{message_id} lang='ja'] みたいな感じでコピーされます。
# はてなダイアリーやはてなブログで使えます。他にも使えるサービスはあるかもしれないけれど…

Plugin.create(:copy_as_short_code) do

  filter_command do |menu|
    menu[:copy_as_short_code] = {
      :slug => :copy_as_short_code,
      :name => 'ショートコード形式でコピー',
      :condition => lambda{ |opt|
        true
      },
      :exec => lambda{ |opt|
        message = opt.message
        screen_name = message.user[:idname]
        Gtk::Clipboard.copy("[tweet http://twitter.com/#!/#{screen_name}/status/#{message.id} align='#{UserConfig[:copy_as_short_code_align]}' lang='ja']")
      },
      :visible => true,
      :role => :message }
    [menu]
  end

  settings("ショートコードでコピペ") do
    select('配置', :copy_as_short_code_align) do
      option "left", "左" 
      option "right", "右" 
      option "center", "中央" 
    end
  end
end

