require 'sqlite3'
require 'singleton'
require "byebug"

class QuestionsDatabase < SQLite3::Database
    include Singleton

    def initialize
        super('questions.db')
        self.type_translation = true
        self.results_as_hash = true
    end
end

class User
    attr_accessor :fname, :lname

    def self.find_by_id(id)
        user = QuestionsDatabase.instance.execute(<<-SQL, id)
        SELECT *
        FROM users
        WHERE id = ?
        SQL
        # debugger
        return nil unless user.length > 0
        User.new(user.first) #returning one user object
    end

    def self.find_by_name(fname, lname)
        user = QuestionsDatabase.instance.execute(<<-SQL, fname, lname)
        SELECT *
        FROM users
        WHERE fname = ? AND lname = ?
        SQL

        user.map { |use| Users.new(use) } 
    end

    def initialize(options)
        @id = options['id']
        @fname = options['fname']
        @lname = options['lname']
    end
#Easy
    def authored_questions
        execute(<<-SQL)
        SELECT title
        FROM questions
        WHERE Questions.find_by_author_id = user.id
        SQL
    end

    def authored_replies
        SELECT body
        FROM replies
        WHERE Reply.find_by_user_id = self.id
    end
#Medium
    def followed_questions
    end
#Hard
    def liked_questions
    end
#Super Hard
    def average_karma
    end

    
end

a= Users.find_by_id(1)


class Question

    def self.find_by_id(id)
        question = QuestionsDatabase.instance.execute(<<-SQL, id)
        SELECT *
        FROM questions
        WHERE id = ?
        SQL

        Questions.new(question.first)
    end

    def self.find_by_author_id(author_id)
    end

    def initialize
    end
#Easy
    def author
    end

    def replies 
    end
#Medium
    def followers
    end
#Hard
    def self.most_followed(n)
    end

    def likers
    end

    def num_likes
    end

    def most_liked(n)
    end
end


    
    


    