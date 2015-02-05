var gulp = require('gulp');
var config       = require('../config').karma;
var karma = require('karma').server;

console.log(config.conf);

/**
 * Run test once and exit
 */
gulp.task('test', function (done) {
  karma.start({
    // configFile: __dirname + '/karma.conf.js',
    configFile: config.conf
    // singleRun: true
  }, done);
});

/**
 * Watch for file changes and re-run tests on each change
 */
gulp.task('tdd', function (done) {
  karma.start({
    configFile: config.conf
  }, done);
});
