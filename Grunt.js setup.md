# Grunt setup

	$ cd wp-content/themes/themefolder
	$ npm init

	$ npm install grunt --save-dev
	$ npm install grunt-contrib-compass --save-dev
	$ npm install grunt-contrib-watch --save-dev
	$ npm install grunt-contrib-uglify --save-dev
	$ npm install grunt-contrib-cssmin --save-dev

Create gruntfile.js

	module.exports = function(grunt) {
		grunt.initConfig({
			pkg: grunt.file.readJSON('package.json'),
			compass: {
				dev: {
					options: {
						sassDir: 'sass',
						cssDir: './',
						environment: 'development'
					}
				},
				prod: {
					options: {              
						sassDir: ['sass'],
						cssDir: ['css'],
						environment: 'production'
					}
				},
	
			},
			cssmin: {
				target: {
					files: [{
						expand: true,
						cwd: 'css',
						src: ['*.css', '!*.min.css'],
						dest: './',
						ext: '.css'
					}]
				}
			},
			watch: {
				dev: {
					files: '**/*.scss',
					tasks: ['compass:dev']
				},
				prod: {
					files: '**/*.scss',
					tasks: ['compass:prod','cssmin']
				}
			}
		});
		grunt.loadNpmTasks('grunt-contrib-compass');
		grunt.loadNpmTasks('grunt-contrib-watch');
		grunt.loadNpmTasks('grunt-contrib-cssmin');
		grunt.registerTask('default',['watch:prod']);
	}

Check that Ruby is installed

	$ ruby -v

Check that SASS is installed 

	$ which sass

Install Sass if necessary

First switch to root

	$ su -

Then

	$ gem install sass

## Tell Grunt to watch for changes

	$ grunt

### Production and Development

The Gruntfile.js example above includes options for production and development environments within Compass. Essentially production compiles the CSS without comments. Just change `compass:dev` to `compass:prod` and vice versa. 
