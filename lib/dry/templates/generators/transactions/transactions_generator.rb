require 'rails/generators'

module Dry
  module Templates
    module Generators
      class TransactionsGenerator < Rails::Generators::Base
        source_root File.expand_path('templates', __dir__)
        argument :model, type: :string, optional: true
        argument :operations, type: :array, optional: true, default: ['create', 'update', 'destroy', 'fetch', 'index']

        def initializer
          generate_application_transaction_file
        end

        def generate_transactions
          return unless model.present? && model != 'init'

          generate_create_transaction if operations.include?('create')
          generate_update_transaction if operations.include?('update')
          generate_destroy_transaction if operations.include?('destroy')
          generate_fetch_transaction if operations.include?('fetch')
          generate_index_transaction if operations.include?('index')
        end

        private

        def generate_application_transaction_file
          copy_file 'exec/application_transaction.template', 'app/transactions/application_transaction.rb'
        end

        def generate_create_transaction
          template 'exec/create_transaction.template', "#{construct_relative_path_to_exec}create.rb"
        end

        def generate_update_transaction
          template 'exec/update_transaction.template', "#{construct_relative_path_to_exec}update.rb"
        end

        def generate_destroy_transaction
          template 'exec/destroy_transaction.template', "#{construct_relative_path_to_exec}destroy.rb"
        end

        def generate_fetch_transaction
          template 'exec/fetch_transaction.template', "#{construct_relative_path_to_exec}fetch.rb"
        end

        def generate_index_transaction
          template 'exec/index_transaction.template', "#{construct_relative_path_to_exec}index.rb"
        end

        def construct_relative_path_to_exec
          "app/transactions/#{model.pluralize.underscore}/"
        end

        def construct_relative_path_to_spec
          "spec/transactions/#{model.pluralize.underscore}/"
        end
      end
    end
  end
end
