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
        return if stylelint_file_exists?

        run('yarn add stylelint stylelint-config-standard')
        create_file(stylelint_file_path, stylelint_file_content)
      end

      def create_haml_lint_file
        return if haml_lint_file_exists?

        create_file(haml_lint_file_path, haml_lint_file_content)
      end

      def print_instructions
        say '-----------------------------------------'
        say '🎉 All done! 🎉'
        say ''
        say 'Run rubocop in parallel to check the offenses:', :green
        say '  rubocop -P', :yellow
        say 'To fix the offenses, run:', :green
        say '  rubocop -a', :yellow
        say 'To generate todo, run:', :green
        say '  rubocop --auto-gen-config', :yellow
        say ''
        say 'Run stylelint to check the offenses:', :green
        say '  stylelint --color app/assets/stylesheets/', :yellow
        say 'To fix the offenses, run:', :green
        say '  stylelint --color --fix app/assets/stylesheets/', :yellow
        say ''
        say 'Run haml_lint to check the offenses:', :green
        say '  bundle exec haml-lint app/**/*.html.haml', :yellow
        say 'To fix the offenses, you need to diy:', :green
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

        def haml_lint_file_path
          '.haml-lint.yml'
        end
        
        def stylelint_file_path
          '.stylelintrc.yml'
        end

        def config_file_path
          '.rubocop.yml'
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
    end
  end
end
