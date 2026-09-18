# frozen_string_literal: true

namespace :fts do
  desc "Create FTS5 virtual tables for Ruby schema format"
  task create: :environment do
    puts "Creating FTS5 virtual tables..."

    # `table_exists?` never reports virtual tables, so the statements carry their
    # own IF NOT EXISTS guard instead of being wrapped in one.
    connection = ActiveRecord::Base.connection

    connection.execute(<<-SQL)
      CREATE VIRTUAL TABLE IF NOT EXISTS entries_fts USING fts5(
        entry_id UNINDEXED,
        title,
        description,
        tags,
        tokenize='porter ascii'
      );
    SQL

    connection.execute(<<-SQL)
      CREATE VIRTUAL TABLE IF NOT EXISTS authors_fts USING fts5(
        author_id UNINDEXED,
        name,
        tokenize='porter ascii'
      );
    SQL

    puts "FTS5 tables ready!"
  end

  desc "Reindex all FTS5 tables (entries and authors)"
  task reindex_all: :environment do
    puts "Reindexing all FTS5 tables..."
    FtsReindexer.new.reindex_all
    puts "Reindexing completed successfully!"
  end

  desc "Reindex entries FTS5 table"
  task reindex_entries: :environment do
    puts "Reindexing entries FTS5 table..."
    FtsReindexer.new.reindex_entries
    puts "Entries reindexing completed!"
  end

  desc "Reindex authors FTS5 table"
  task reindex_authors: :environment do
    puts "Reindexing authors FTS5 table..."
    FtsReindexer.new.reindex_authors
    puts "Authors reindexing completed!"
  end
end

# Enhance db:test:prepare to automatically create FTS5 tables
Rake::Task["db:test:prepare"].enhance do
  Rake::Task["fts:create"].invoke
end
