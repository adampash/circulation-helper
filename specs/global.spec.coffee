LinkGetter = require './../src/javascript/global.coffee'

describe LinkGetter, ->
  post_url = "http://gawker.com/transasia-plane-crashes-over-highway-into-taipei-harbor-1683654957"
  api_url = 'http://kinja.com/ajax/post/1683654957'
  post_id = '1683654957'

  it "gets the post id", ->
    expect(LinkGetter.apiURL(post_url)).toEqual api_url

  it "grabs fetches the post via ajax", (done) ->
    LinkGetter.getPost post_url, (post) ->
      expect(post.id).to eq post_id
      done()
