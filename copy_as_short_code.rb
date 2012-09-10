# -*- coding: utf-8 -*-
# ツイートをブログとかに埋め込むときのショートコードをクリップボードに投げつけるだけの簡単なおしごとをします。
# [tweet http://twitter.com/{screen_name}/status/{message_id} lang='ja'] みたいな感じでコピーされます。
# はてなダイアリーやはてなブログで使えます。他にも使えるサービスはあるかもしれないけれど…

Plugin.create(:copy_as_short_code) do

  filter_command do |menu|
    menu[:copy_as_short_code] = {
      :slug => :copy_as_short_code,
      :name => 'ショートコード形式でコピー',
      :condition => lambda{ |opt| true },
      :exec => lambda{ |messages|
        short_code = messages.map{|opt|
          message = opt.message
          screen_name = message.user[:idname]
          "[tweet http://twitter.com/#!/#{screen_name}/status/#{message.id} lang='ja']"
        }.join ' '
        Gtk::Clipboard.copy(short_code)
      },
      :visible => true,
      :role => :messages }
    [menu]
  end
end

