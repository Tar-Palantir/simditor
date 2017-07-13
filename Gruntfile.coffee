module.exports = (grunt) ->

  grunt.initConfig

    pkg: grunt.file.readJSON 'package.json'

    coffee:
      simuploaditor:
        options:
          join: true
          bare: true
        files:
          'lib/simuploaditor.js': [
            'src/selection.coffee'
            'src/formatter.coffee'
            'src/inputManager.coffee'
            'src/keystroke.coffee'
            'src/undoManager.coffee'
            'src/util.coffee'
            'src/toolbar.coffee'
            'src/indentation.coffee'
            'src/clipboard.coffee'
            'src/core.coffee'
            'src/i18n.coffee'
            'src/buttons/button.coffee'
            'src/buttons/popover.coffee'
            'src/buttons/title.coffee'
            'src/buttons/font-scale.coffee'
            'src/buttons/bold.coffee'
            'src/buttons/italic.coffee'
            'src/buttons/underline.coffee'
            'src/buttons/color.coffee'
            'src/buttons/list.coffee'
            'src/buttons/blockquote.coffee'
            'src/buttons/code.coffee'
            'src/buttons/link.coffee'
            'src/buttons/image.coffee'
            'src/buttons/indent.coffee'
            'src/buttons/outdent.coffee'
            'src/buttons/hr.coffee'
            'src/buttons/table.coffee'
            'src/buttons/strikethrough.coffee'
            'src/buttons/alignment.coffee'
          ]
      simuploader:
        options:
          bare: true
        files:
          'lib/simuploader.js':'src/simple-uploader.coffee'

    sass:
      simuploaditor:
        options:
          style: 'expanded'
          sourcemap: 'none'
        files:
          'styles/simuploaditor.css': 'styles/simuploaditor.scss'

    umd:
      editor:
        src: 'lib/simuploaditor.js'
        template: 'umd.hbs'
        amdModuleId: 'simuploaditor'
        objectToExport: 'Simuploaditor'
        globalAlias: 'Simuploaditor'
        deps:
          'default': ['$', 'SimpleModule', 'simpleHotkeys', 'simuploader']
          amd: ['jquery', 'simple-module', 'simple-hotkeys', 'Simuploader']
          cjs: ['jquery', 'simple-module', 'simple-hotkeys', 'Simuploader']
          global:
            items: ['jQuery', 'SimpleModule', 'simple"]["hotkeys', 'Simuploader']
            prefix: ''
      uploader:
        src: 'lib/simuploader.js'
        template: 'umd.hbs'
        amdModuleId: 'simuploader'
        objectToExport: 'simuploader'
        globalAlias: 'Simuploader'
        deps:
          'default': ['$', 'SimpleModule']
          amd: ['jquery', 'simple-module']
          cjs: ['jquery', 'simple-module']
          global:
            items: ['jQuery', 'SimpleModule']
            prefix: ''


    copy:
      package:
        files: [{
          expand: true,
          flatten: true
          src: 'lib/*',
          dest: 'package/scripts/'
        }, {
          src: 'vendor/bower/jquery/dist/jquery.min.js',
          dest: 'package/scripts/jquery.min.js'
        }, {
          src: 'vendor/bower/simple-module/lib/module.js',
          dest: 'package/scripts/module.js'
        }, {
          src: 'vendor/bower/simple-hotkeys/lib/hotkeys.js',
          dest: 'package/scripts/hotkeys.js'
        }, {
          src: 'styles/simuploaditor.css',
          dest: 'package/styles/simuploaditor.css'
        }, {
          src: 'styles/image.png',
          dest: 'package/images/image.png'
        }]

    uglify:
      simuploaditor:
        options:
          preserveComments: 'some'
        files:
          'package/scripts/module.min.js': 'package/scripts/module.js'
          'package/scripts/simuploader.min.js': 'package/scripts/simuploader.js'
          'package/scripts/hotkeys.min.js': 'package/scripts/hotkeys.js'
          'package/scripts/simuploaditor.min.js': 'package/scripts/simuploaditor.js'

    usebanner:
      simuploaditor:
        options:
          banner: '''/*!
 * Simuploaditor v<%= pkg.version %>
 * <%= grunt.template.today("yyyy-mm-dd") %>
 */'''
        files:
          src: ['lib/simuploaditor.js', 'styles/simuploaditor.css']
      simuploader:
        options:
          banner: '''/*!
 * Simuploaditor v<%= pkg.version %>
 * <%= grunt.template.today("yyyy-mm-dd") %>
 */'''
        files:
          src: 'lib/simuploader.js'

    compress:
      package:
        options:
          archive: 'package/simuploaditor-<%= pkg.version %>.zip'
        files: [{
          expand: true,
          cwd: 'package/'
          src: '**',
          dest: 'simuploaditor-<%= pkg.version %>/'
        }]

    clean:
      package:
        src: ['package/']

    curl:
      fonticons:
        src: "http://use.fonticons.com/kits/d7611efe/d7611efe.css"
        dest: "styles/fonticon.scss"


  grunt.loadNpmTasks 'grunt-contrib-sass'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-contrib-uglify'
  grunt.loadNpmTasks 'grunt-contrib-compress'
  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-umd'
  grunt.loadNpmTasks 'grunt-contrib-jasmine'
  grunt.loadNpmTasks 'grunt-banner'
  grunt.loadNpmTasks 'grunt-curl'

  grunt.registerTask 'default', ['sass', 'coffee', 'umd', 'usebanner']
  grunt.registerTask 'package', ['clean:package', 'copy:package', 'uglify:simuploaditor', 'compress']
  grunt.registerTask 'build', ['default', 'package']

  grunt.registerTask 'fonticons', ['curl']
