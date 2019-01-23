require 'spec_helper'
require 'dry/templates/generators/transactions/transactions_generator'

RSpec.describe Dry::Templates::Generators::TransactionsGenerator, type: :generator do
  destination File.expand_path('../tmp', __FILE__)
  before { prepare_destination }

  describe 'tasks' do
    it 'runs initializer and generate transactions tasks' do
      gen = generator
      expect(gen).to receive(:initializer)
      expect(gen).to receive(:generate_transactions)
      gen.invoke_all
    end
  end

  describe 'generated files' do
    context 'when no arguments are passed' do
      subject { file('app/transactions/application_transaction.rb') }
      before { run_generator }

      it 'generates only application transaction file' do
        is_expected.to exist
      end

      it 'includes Dry::Transaction module' do
        is_expected.to contain /include Dry::Transaction/
      end

      it 'is called ApplicationTransaction' do
        is_expected.to contain /class ApplicationTransaction/
      end

      it 'does not generate transaction files' do
        expect(file('app/transactions/posts/create.rb')).not_to exist
        expect(file('app/transactions/posts/update.rb')).not_to exist
        expect(file('app/transactions/posts/index.rb')).not_to exist
        expect(file('app/transactions/posts/fetch.rb')).not_to exist
        expect(file('app/transactions/posts/destroy.rb')).not_to exist
      end
    end

    context 'when only one model name and one action is passed' do
      before { run_generator %w(post create) }

      it 'generates only application transaction file' do
        expect(file('app/transactions/application_transaction.rb')).to exist
      end

      it 'generates create file' do
        expect(file('app/transactions/posts/create.rb')).to exist
      end

      it 'does not generate the rest of the actions' do
        expect(file('app/transactions/posts/update.rb')).not_to exist
        expect(file('app/transactions/posts/index.rb')).not_to exist
        expect(file('app/transactions/posts/fetch.rb')).not_to exist
        expect(file('app/transactions/posts/destroy.rb')).not_to exist
      end
    end

    describe 'create' do
      subject { file('app/transactions/posts/create.rb') }
      before { run_generator %w(posts create) }

      it 'generates create file' do
        is_expected.to exist
      end

      it 'is placed in proper module' do
        is_expected.to contain /module Posts/
      end

      it 'is called propely' do
        is_expected.to contain /class Create/
      end

      it 'inherits from ApplicationTransaction' do
        is_expected.to contain /< ApplicationTransaction/
      end

      it 'has valid syntax' do
        is_expected.to have_correct_syntax
      end

      it 'implements proper methods' do
        is_expected.to have_method :build
        is_expected.to have_method :validate
        is_expected.to have_method :save
      end

      describe '#build' do
        it 'calls new on proper model' do
          is_expected.to contain /Post.new/
        end
      end
    end

    describe 'update' do
      subject { file('app/transactions/posts/update.rb') }
      before { run_generator %w(posts update) }

      it 'generates update file' do
        is_expected.to exist
      end

      it 'is placed in proper module' do
        is_expected.to contain /module Posts/
      end

      it 'is called propely' do
        is_expected.to contain /class Update/
      end

      it 'inherits from ApplicationTransaction' do
        is_expected.to contain /< ApplicationTransaction/
      end

      it 'has valid syntax' do
        is_expected.to have_correct_syntax
      end

      it 'implements proper methods' do
        is_expected.to have_method :find
        is_expected.to have_method :update_attributes
        is_expected.to have_method :save
      end

      describe '#find' do
        it 'calls find on proper model' do
          is_expected.to contain /Post.find/
        end
      end
    end

    describe 'index' do
      subject { file('app/transactions/posts/index.rb') }
      before { run_generator %w(posts index) }

      it 'generates index file' do
        is_expected.to exist
      end

      it 'is placed in proper module' do
        is_expected.to contain /module Posts/
      end

      it 'is called propely' do
        is_expected.to contain /class Index/
      end

      it 'inherits from ApplicationTransaction' do
        is_expected.to contain /< ApplicationTransaction/
      end

      it 'has valid syntax' do
        is_expected.to have_correct_syntax
      end

      it 'implements proper methods' do
        is_expected.to have_method :fetch_all_posts
      end

      describe '#fetch_all_<model_name>' do
        it 'calls all on proper model' do
          is_expected.to contain /Post.all/
        end
      end
    end

    describe 'fetch' do
      subject { file('app/transactions/posts/fetch.rb') }
      before { run_generator %w(posts fetch) }

      it 'generates fetch file' do
        is_expected.to exist
      end

      it 'is placed in proper module' do
        is_expected.to contain /module Posts/
      end

      it 'is called propely' do
        is_expected.to contain /class Fetch/
      end

      it 'inherits from ApplicationTransaction' do
        is_expected.to contain /< ApplicationTransaction/
      end

      it 'has valid syntax' do
        is_expected.to have_correct_syntax
      end

      it 'implements proper methods' do
        is_expected.to have_method :find
      end

      describe '#find' do
        it 'calls find on proper model' do
          is_expected.to contain /Post.find/
        end
      end
    end

    describe 'destroy' do
      subject { file('app/transactions/posts/destroy.rb') }
      before { run_generator %w(posts destroy) }

      it 'generates destroy file' do
        is_expected.to exist
      end

      it 'is placed in proper module' do
        is_expected.to contain /module Posts/
      end

      it 'is called propely' do
        is_expected.to contain /class Destroy/
      end

      it 'inherits from ApplicationTransaction' do
        is_expected.to contain /< ApplicationTransaction/
      end

      it 'has valid syntax' do
        is_expected.to have_correct_syntax
      end

      it 'implements proper methods' do
        is_expected.to have_method :find
        is_expected.to have_method :delete
      end

      describe '#find' do
        it 'calls find on proper model' do
          is_expected.to contain /Post.find/
        end
      end
    end

    context 'when only model name is passed' do
      describe 'destroy' do
        subject { file('app/transactions/posts/destroy.rb') }

        it 'generates destroy file' do
          run_generator %w(posts)
          is_expected.to exist
        end
      end

      describe 'index' do
        subject { file('app/transactions/posts/index.rb') }

        it 'generates index file' do
          run_generator %w(posts)
          is_expected.to exist
        end
      end

      describe 'fetch' do
        subject { file('app/transactions/posts/fetch.rb') }

        it 'generates fetch file' do
          run_generator %w(posts)
          is_expected.to exist
        end
      end

      describe 'update' do
        subject { file('app/transactions/posts/update.rb') }

        it 'generates update file' do
          run_generator %w(posts)
          is_expected.to exist
        end
      end

      describe 'create' do
        subject { file('app/transactions/posts/create.rb') }

        it 'generates create file' do
          run_generator %w(posts)
          is_expected.to exist
        end
      end

      describe 'application transaction' do
        subject { file('app/transactions/application_transaction.rb') }

        it 'generates application transaction file' do
          run_generator %w(posts)
          is_expected.to exist
        end
      end
    end
  end
end
