Test = require './../src/javascript/test.coffee'

describe "A thing", ->
  it "is true or false", ->
    expect(true).toBe true

  it "works with requires", ->
    expect(Test.init()).toEqual 'okay'

  it "tests something else", ->
    expect(Test.foo()).toEqual true
