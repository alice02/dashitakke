require 'kconv'

class Source < ActiveRecord::Base
  belongs_to :answer

  mount_uploader :src, SourceUploader

  # ファイルタイプでバリデーション
  validate :source_valid?, :if => Proc.new{ |source| source.src_changed? && source.errors[:src].blank? }

  def source_valid?
    if src.file.content_type != "text/x-c"
      errors.add(:source, "不正なファイルが添付されています")
    end
  end

  def getSourcefile
    f = open(self.src.path, "r")
    # 文字コードをUTF-8に変換する。それでも不正なバイト文字が含まれていたら'?'で置換
    srcFile = f.read.toutf8.scrub('?')
    f.close
    return srcFile
  end

  def filename_check original_filename = self.src.path.split("/")[-1]
    no = self.answer.question.index
    date = self.answer.question.paper.given_date.to_s
    filename = "No" + date.split("-")[1] + date.split("-")[2] + "_" + no.to_s + ".c"
    puts no, date, filename
    if original_filename == filename
      return true
    else
      self.errors[:base] << "指定したファイル名でアップロードしてください。"
      puts self.errors.messages
      return false
    end
  end

end
