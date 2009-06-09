# This file is autogenerated. Instead of editing this file, please use the
# migrations feature of ActiveRecord to incrementally modify your database, and
# then regenerate this schema definition.

ActiveRecord::Schema.define(:version => 3) do

  create_table "countries", :force => true do |t|
    t.column "name", :string
  end

  create_table "enterprises", :force => true do |t|
    t.column "short_name",       :string,                                      :null => false
    t.column "account_owner_id", :integer
    t.column "is_active",        :boolean,                  :default => false, :null => false
    t.column "is_blocked",       :boolean,                  :default => false, :null => false
    t.column "name",             :string,                                      :null => false
    t.column "address",          :string,   :limit => 1024
    t.column "city",             :string
    t.column "province",         :string
    t.column "postal_code",      :string
    t.column "country_id",       :integer
    t.column "cif",              :string,                                      :null => false
    t.column "theme",            :string,                                      :null => false
    t.column "extensions",       :integer
    t.column "logo",             :string
    t.column "created_at",       :datetime
    t.column "updated_at",       :datetime
  end

  add_index "enterprises", ["account_owner_id"], :name => "account_owner_id"
  add_index "enterprises", ["country_id"], :name => "country_id"

  create_table "expense_types", :force => true do |t|
    t.column "description",   :string
    t.column "parent_id",     :integer
    t.column "enterprise_id", :integer, :null => false
  end

  add_index "expense_types", ["parent_id"], :name => "parent_id"
  add_index "expense_types", ["enterprise_id"], :name => "enterprise_id"

  create_table "expenses", :force => true do |t|
    t.column "user_id",                 :integer
    t.column "project_id",              :integer
    t.column "description",             :string,                 :null => false
    t.column "description_for_sorting", :string
    t.column "date",                    :date
    t.column "amount",                  :integer
    t.column "justification_doc",       :binary
    t.column "justification_docname",   :string
    t.column "justification_doctype",   :string
    t.column "status",                  :string
    t.column "revised_by",              :integer
    t.column "revised_at",              :date
    t.column "revision_note",           :string
    t.column "expense_type_id",         :integer
    t.column "comments",                :string
    t.column "envelope",                :string
    t.column "created_at",              :date
    t.column "updated_at",              :date
    t.column "payment_type",            :integer, :default => 1, :null => false
  end

  add_index "expenses", ["user_id"], :name => "user_id"
  add_index "expenses", ["project_id"], :name => "project_id"
  add_index "expenses", ["revised_by"], :name => "revised_by"
  add_index "expenses", ["expense_type_id"], :name => "expense_type_id"
  add_index "expenses", ["status"], :name => "index_expenses_on_status"

  create_table "payments", :force => true do |t|
    t.column "user_id",             :integer
    t.column "date",                :date
    t.column "amount",              :integer, :default => 0, :null => false
    t.column "ordered_by",          :integer
    t.column "concept",             :string
    t.column "concept_for_sorting", :string
    t.column "description",         :string
  end

  add_index "payments", ["user_id"], :name => "user_id"
  add_index "payments", ["ordered_by"], :name => "ordered_by"

  create_table "projects", :force => true do |t|
    t.column "name",                    :string,  :null => false
    t.column "name_for_sorting",        :string
    t.column "description",             :string
    t.column "description_for_sorting", :string
    t.column "supervisor_id",           :integer
    t.column "enterprise_id",           :integer, :null => false
  end

  add_index "projects", ["supervisor_id"], :name => "supervisor_id"
  add_index "projects", ["enterprise_id"], :name => "enterprise_id"

  create_table "reports", :force => true do |t|
    t.column "created_at", :datetime
  end

  create_table "users", :force => true do |t|
    t.column "is_supervisor",             :boolean,                :default => false, :null => false
    t.column "is_administrator",          :boolean,                :default => false, :null => false
    t.column "first_name",                :string
    t.column "first_name_for_sorting",    :string
    t.column "last_name",                 :string
    t.column "last_name_for_sorting",     :string
    t.column "is_payer",                  :boolean,                :default => false
    t.column "supervisor_id",             :integer
    t.column "email",                     :string,                 :default => ""
    t.column "crypted_password",          :string,   :limit => 40
    t.column "salt",                      :string,   :limit => 40
    t.column "created_at",                :datetime
    t.column "updated_at",                :datetime
    t.column "remember_token",            :string
    t.column "remember_token_expires_at", :datetime
    t.column "activation_code",           :string,   :limit => 40
    t.column "activated_at",              :datetime
    t.column "is_gestor",                 :boolean,                :default => false
    t.column "is_blocked",                :boolean,                :default => false
    t.column "enterprise_id",             :integer,                                   :null => false
  end

  add_index "users", ["supervisor_id"], :name => "supervisor_id"
  add_index "users", ["enterprise_id"], :name => "enterprise_id"

  add_foreign_key "enterprises", ["account_owner_id"], "users", ["id"]
  add_foreign_key "enterprises", ["country_id"], "countries", ["id"]

  add_foreign_key "expense_types", ["parent_id"], "expense_types", ["id"]
  add_foreign_key "expense_types", ["enterprise_id"], "enterprises", ["id"]

  add_foreign_key "expenses", ["user_id"], "users", ["id"]
  add_foreign_key "expenses", ["project_id"], "projects", ["id"]
  add_foreign_key "expenses", ["revised_by"], "users", ["id"]
  add_foreign_key "expenses", ["expense_type_id"], "expense_types", ["id"]

  add_foreign_key "payments", ["user_id"], "users", ["id"]
  add_foreign_key "payments", ["ordered_by"], "users", ["id"]

  add_foreign_key "projects", ["supervisor_id"], "users", ["id"]
  add_foreign_key "projects", ["enterprise_id"], "enterprises", ["id"]

  add_foreign_key "users", ["supervisor_id"], "users", ["id"]
  add_foreign_key "users", ["enterprise_id"], "enterprises", ["id"]

end
