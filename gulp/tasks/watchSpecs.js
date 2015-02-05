var gulp     = require('gulp');
var config   = require('../config');

gulp.task('watch_specs', function(callback) {
  gulp.watch(config.jasmine.src, ['jasmine']);
});
