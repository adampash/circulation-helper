$ = require './jquery.js'
moment = require './moment.js'

$('.link_input, .result').on 'click', (e) ->
  $(@).select()
$('.link_input').on 'keyup', (e) ->
  $(@).blur()
  $(@).focus()
$('.link_input').on 'change', (e) ->
  link = $(@).val().split('#')[0].split('+')[0]
  if LinkGetter.isLink(link)
    LinkGetter.getPost link

module.exports = LinkGetter =
  api: "http://kinja.com/api/core/post"

  isLink: (link) ->
    @newLink(link) or @oldLink(link)
  newLink: (link) ->
    link.match(/-(\d+)\/?$/)
  oldLink: (link) ->
    link.match(/\.com\/\d+\//)
  postId: (link) ->
    if @newLink(link)
      link.match(/-(\d+)\/?$/)[1]
    else
      link.match(/\.com\/(\d+)\//)[1]
  apiURL: (link) ->
    "#{@api}/#{@postId(link)}"

  getPost: (link, complete) ->
    url = @apiURL(link)
    console.log "getting #{url}"
    $.ajax
      url: url
      dataType: "jsonp"
      jsonp: 'jsonp'
      success: (post) =>
        type = $('input[name=roundup-type]:checked', '.radios').val()
        if post.data.starterId is post.data.id
          if $('.jane').prop('checked')
            @circ(post)
          else
            @link(post)
        else
          @comment(post)

  link: (post) ->
    @updateBox @linkify(post, false)

  circ: (post) ->
    @updateBox @linkify(post, true)

  comment: (post) ->
    @updateBox """
        &#8203;
        <blockquote>
          &#8203;
          #{post.data.original}
          <p>– <a class="inset-skip" href="#{post.data.permalink}">#{post.data.author.displayName}</a></p>
        </blockquote>
        &#8203;
        <p class="end_of_roundup">End of roundup</p>
      """
    , false

  updateBox: (text, clear=false) ->
    $('.end_of_roundup').remove()
    if clear
      $('.result').html(text)
    else
      $('.result').html("#{$('.result').html()}#{text}")
    $('.link_input').select()

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

  linkify: (post, circ=true) ->
    campaign = ""
    if circ
      campaign = "?utm_source=recirculation&utm_medium=recirculation&utm_campaign=#{@getDayOfWeek()}#{@getMerdian()}"
    if $('.big_round').prop('checked')
      post_link = "<h2><a href=\"#{post.data.permalink}\">#{post.data.headline}</a></h2>"
      post_link += "<p><img src=\"#{post.data.sharingMainImage?.src or post.data.parsedBody.sharingMainImage?.src}\" /></p>"
      post_link += post.data.excerpt or post.data.parsedBody.excerpt
    else
      blog_name = @get_blog_name(post)
      post_link = "<strong>#{blog_name}</strong> <a class=\"inset-skip\" href=\"#{post.data.permalink}#{campaign}\">#{post.data.headline}</a> | "
    post_link

$('.link_input').focus()
