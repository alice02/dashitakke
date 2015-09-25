require 'kconv'

class Source < ActiveRecord::Base
  belongs_to :answer

  mount_uploader :source, SourceUploader

  # ファイルタイプでバリデーション
  validate :image_valid?, :if => Proc.new{ |user| user.image_changed? && user.errors[:image].blank? }

  def source_valid?
    if source.file.content_type != "image/jpeg"
      errors.add(:source, "不正なファイルが添付されています")
    end
  end

  def getSourcefile path
    f = open(path, "r")
    # 文字コードをUTF-8に変換する。それでも不正なバイト文字が含まれていたら'?'で置換
    srcFile = f.read.toutf8.scrub('?')
    f.close
    return srcFile
  end

  def filename_check original_filename = self.avatar.original_filename
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
