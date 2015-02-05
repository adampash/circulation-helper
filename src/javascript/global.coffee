$ = require './jquery.js'

$('.link_input').on 'keyup', (e) ->
  link = $(@).val()

module.exports = LinkGetter =
  api: "http://kinja.com/ajax/post"
  apiURL: (link) ->
    "#{@api}/#{link.match(/-(\d+)$/)[1]}"

  callback: (data) ->
    debugger
  getPost: (link, complete) ->
    url = @apiURL(link)
    console.log "getting #{url}"
    thing = $.ajax
      url: url
      dataType: 'json'
      success: (post) ->
        debugger
        # debugger
        # complete(post)
      error: (ajax, status, error) ->
        console.log status, error
        debugger

link = "http://gawker.com/transasia-plane-crashes-over-highway-into-taipei-harbor-1683654957"
LinkGetter.getPost link, (post) ->
  debugger
