# frozen_string_literal: true

require 'rails/generators/base'
require 'active_support/core_ext/string'

module BoostStyles
  module Generators
    class InstallGenerator < Rails::Generators::Base
      desc "Creates a .rubocop.yml config file that inherits from boost-style's .rubocop_default.yml"

      def create_config_file
        file_method = config_file_exists? ? :prepend : :create
        send :"#{file_method}_file", config_file_path, config_file_content
      end

      def create_stylelint_file
        return unless yes?('Do you want stylelint?')
        return if stylelint_file_exists?

        run('yarn add stylelint stylelint-config-standard')
        create_file(stylelint_file_path, stylelint_file_content)
      end

      def create_haml_lint_file
        return unless yes?('Do you want HAML lint?')
        return if haml_lint_file_exists?

        create_file(haml_lint_file_path, haml_lint_file_content)
      end

      def create_eslint_file
        return unless yes?('Do you want ESLint?')
        return if eslint_file_exists?

        run('yarn add eslint')
        create_file(eslint_file_path, eslint_file_content)
      end

      def print_instructions
        say <<-TXT.strip_heredoc
          -----------------------------------------
          🎉 All done! 🎉

          Run rubocop in parallel to check the offenses:
            -> rubocop -P
          To fix the offenses, run:
            -> rubocop -a
          To generate todo, run:
            -> rubocop --auto-gen-config

          Run stylelint to check the offenses:
            -> stylelint --color app/assets/stylesheets/
          To fix the offenses, run:
            -> stylelint --color --fix app/assets/stylesheets/

          Run haml_lint to check the offenses:
            -> bundle exec haml-lint app/**/*.html.haml
          To fix the offenses, you need to diy
          -----------------------------------------
        TXT
      end

      private

        def haml_lint_file_exists?
          File.exist?(haml_lint_file_path)
        end

        def stylelint_file_exists?
          File.exist?(stylelint_file_path)
        end

        def config_file_exists?
          File.exist?(config_file_path)
        end

        def eslint_file_exists?
          File.exist?(eslint_file_path)
        end

        def haml_lint_file_path
          '.haml-lint.yml'
        end

        def stylelint_file_path
          '.stylelintrc.yml'
        end

        def config_file_path
          '.rubocop.yml'
        end

        def eslint_file_path
          '.eslintrc.yml'
        end

        def haml_lint_file_content
          <<-YAML.strip_heredoc
          linters:
            ImplicitDiv:
              enabled: false
              severity: error

            LineLength:
              max: 100

            RuboCop:
              enabled: false
          YAML
        end

        def stylelint_file_content
          <<-YAML.strip_heredoc
          extends: stylelint-config-standard

          rules:
            # Complains about FontAwesome
            font-family-no-missing-generic-family-keyword: null

            at-rule-no-unknown:
              - true
              - ignoreAtRules:
                - extend
                - if
                - each
                - include
                - mixin
                - at-root
          YAML
        end

        def config_file_content
          <<-YAML.strip_heredoc
          inherit_gem:
            boost-styles:
              - rubocop_default.yml
          YAML
        end

        def eslint_file_content
          <<-YAML.strip_heredoc
          ---
          env:
            browser: true
            es6: true
            jquery: true
            node: true
          extends:
          - standard
          overrides:
            files:
            - '*.js''
            excludedFiles:
            - '*.config.js'
          parserOptions:
            sourceType: module
          plugins: []
          globals:
            _: true
            '$': true
            ga: true
            Foundation: true
          rules:
            no-unused-vars:
            - error
            - varsIgnorePattern: '_.*'
              argsIgnorePattern: '_.*'
          YAML
        end
    end
  end
end
