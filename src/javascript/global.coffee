$ = require './jquery.js'
moment = require './moment.js'
# Parse = require './parse.js'
Parse.initialize("2D2A51Wu2XBilXK0ChikupaOjRgKEpr2krXZ5SU3", "ymu7i43IuWILrI5YQGj3JA1u0q2cQEWL1a2kOFKK")

$('.link_input, .stuff, .result').on 'click', (e) ->
  $(@).select()

$('.link_input').on 'keyup', (e) ->
  $(@).blur()
$('.link_input').on 'change', (e) ->
  link = $(@).val().split('#')[0].split('+')[0]
  if LinkGetter.isLink(link)
    LinkGetter.getPost link

module.exports = LinkGetter =
  # api: "http://kinja.com/api/core/post"
  api: "http://localhost:4567/post"
  isLink: (link) ->
    link.match(/-(\d+)\/?$/)
  postId: (link) ->
    link.match(/-(\d+)\/?$/)[1]
  apiURL: (link) ->
    "#{@api}/#{@postId(link)}"

  getPost: (link, complete) ->
    url = @apiURL(link)
    console.log "getting #{url}"
    $.ajax
      url: url
      dataType: "jsonp"
      success: (data) =>
        post = JSON.parse data
        text = @linkify(post)
        $('.stuff').val("#{$('.stuff').val()}#{text}")
        $('.result').html("#{$('.stuff').val()}")

  getDayOfWeek: ->
    moment().format('dddd').toLowerCase()

  getMerdian: ->
    moment().format('A')

  get_blog_name: (post) ->
    id = post.data.defaultBlogId
    for blog in post.data.blogs
      if blog.id is id
        name = blog.displayName
    name

  linkify: (post) ->
    blog_name = @get_blog_name(post)
    post_link = "<strong>#{blog_name}</strong> <a href=\"#{post.data.permalink}?utm_source=recirculation&utm_medium=recirculation&utm_campaign=#{@getDayOfWeek()}#{@getMerdian()}\">#{post.data.headline}</a> | "

# link = "http://gawker.com/transasia-plane-crashes-over-highway-into-taipei-harbor-1683654957"
# LinkGetter.getPost link, (post) ->
#   debugger
$('.link_input').focus()
