# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
ready = ->
  $('#source_src').fileinput
    showPreview: true
    maxFileCount: 1
    browseClass: 'btn btn-info fileinput-browse-button'
    browseIcon: '<i class="glyphicon glyphicon-folder-open"></i>'
    browseLabel: ' ファイル選択'
    removeClass: 'btn btn-warning'
    removeIcon: ''
    removeLabel: ' キャンセル'
    uploadClass: 'btn btn-success fileinput-upload-button'
    uploadIcon: '<i class="glyphicon glyphicon-upload"></i>'
    uploadLabel: ' アップロード'
    allowedFileExtensions: ['c']
    msgValidationError: '''
      <span class="text-danger">
        <i class="glyphicon glyphicon-exclamation-sign"></i> 拡張子が C のファイルのみ有効です。
      </span>
    '''

$(document).ready(ready)
$(document).on('page:load', ready)