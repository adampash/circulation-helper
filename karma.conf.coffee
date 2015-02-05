module.exports = (config) ->
  config.set
    browsers: ['ChromeCanary']
    frameworks: ['browserify', 'jasmine']
    files: [
      'src/**/*.coffee',
      'specs/**/*spec.coffee'
    ]
    preprocessors:
      '**/*.coffee': ['browserify']
      # 'src/**/*.coffee': ['coverage']
    reporters: ['dots', 'coverage']


    # browserify:
      # debug: true
      # transform: ['coffeeify']
      # extensions: ['.coffee']
