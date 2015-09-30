require 'kconv'

class Source < ActiveRecord::Base
  belongs_to :answer

  mount_uploader :src, SourceUploader

  # ファイルタイプ(mime)でバリデーション
  validate :source_mime_valid?, :if => Proc.new{ |source| source.src_changed? && source.errors[:src].blank? }
  # ファイル名でバリデーション
  validate :source_filename_valid?, :if => Proc.new{ |source| source.src_changed? && source.errors[:src].blank? }

  def source_mime_valid?
    if src.file.content_type != "text/x-c"
      errors.add(:source, "不正なファイルが添付されています。")
    end
  end

  def source_filename_valid?
    original_filename = src.file.filename
    number = answer.question.index
    date = answer.question.paper.given_date.to_s
    filename = "No" + date.split("-")[1] + date.split("-")[2] + "_" + number.to_s + "." + answer.question.extension
    if original_filename != filename
      errors.add(:source, "不正なファイル名[" + original_filename + "]です。指定したファイル名[" + filename + "]で提出してください。")
    end
  end


  def getSourcefile
    f = open(self.src.path, "r")
    # 文字コードをUTF-8に変換する。それでも不正なバイト文字が含まれていたら'?'で置換
    srcFile = f.read.toutf8.scrub('?')
    f.close
    return srcFile
  end

end
