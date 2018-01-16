# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20161217125919) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "changes", force: :cascade do |t|
    t.integer  "tool_id"
    t.text     "version"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cluster_methods", force: :cascade do |t|
    t.text     "name"
    t.text     "label"
    t.text     "description"
    t.text     "program"
    t.text     "attrs_json"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "speed_id",    limit: 2
    t.text     "link"
    t.text     "warning"
  end

  create_table "clusters", force: :cascade do |t|
    t.integer  "project_id"
    t.integer  "cluster_method_id"
    t.text     "attrs_json"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "label"
    t.integer  "status_id"
    t.integer  "duration"
    t.integer  "num"
    t.integer  "dim_reduction_id"
    t.integer  "pid"
    t.integer  "step_id"
  end

  create_table "courses", force: :cascade do |t|
    t.integer  "project_id"
    t.integer  "upload_type"
    t.text     "name"
    t.text     "status"
    t.text     "upload_file_name"
    t.text     "upload_content_type"
    t.integer  "upload_file_size"
    t.datetime "upload_updated_at"
    t.boolean  "visible"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree
  end

  create_table "diff_expr_methods", force: :cascade do |t|
    t.text     "name"
    t.text     "label"
    t.text     "description"
    t.text     "program"
    t.text     "link"
    t.integer  "speed_id",    limit: 2
    t.text     "attrs_json"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "diff_exprs", force: :cascade do |t|
    t.integer  "project_id"
    t.integer  "diff_expr_method_id"
    t.integer  "selection1_id"
    t.integer  "selection2_id"
    t.text     "attrs_json"
    t.integer  "status_id"
    t.integer  "duration"
    t.datetime "created_at"
    t.integer  "pid"
    t.integer  "num"
    t.text     "label"
    t.integer  "nber_up_genes"
    t.integer  "nber_down_genes"
    t.text     "md5_sel1"
    t.text     "md5_sel2"
    t.integer  "nb_cells_sel1"
    t.integer  "nb_cells_sel2"
  end

  create_table "dim_reductions", force: :cascade do |t|
    t.text     "name"
    t.text     "label"
    t.text     "description"
    t.text     "program"
    t.text     "attrs_json"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "speed_id",    limit: 2
    t.text     "link"
  end

  create_table "filter_methods", id: :integer, default: -> { "nextval('filters_id_seq'::regclass)" }, force: :cascade do |t|
    t.text     "name"
    t.text     "description"
    t.text     "program"
    t.text     "attrs_json"
    t.text     "label"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "speed_id",    limit: 2
    t.text     "link"
  end

  create_table "gene_enrichments", force: :cascade do |t|
    t.integer  "num"
    t.text     "label"
    t.integer  "project_id"
    t.integer  "diff_expr_id"
    t.text     "attrs_json"
    t.integer  "status_id"
    t.integer  "duration"
    t.integer  "pid"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "nber_pathways"
  end

  create_table "genes", force: :cascade do |t|
    t.text     "ensembl_id"
    t.text     "name"
    t.integer  "organism_id"
    t.datetime "created_at"
    t.index ["ensembl_id"], name: "genes_ensembl_id_idx", using: :btree
    t.index ["name"], name: "genes_name_idx", using: :btree
  end

  create_table "jobs", force: :cascade do |t|
    t.integer  "project_id"
    t.integer  "step_id"
    t.integer  "status_id"
    t.text     "command_line"
    t.integer  "duration"
    t.integer  "pid"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "norms", force: :cascade do |t|
    t.text     "name"
    t.text     "description"
    t.text     "program"
    t.text     "attrs_json"
    t.text     "label"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "speed_id",      limit: 2
    t.text     "link"
    t.boolean  "output_is_log",           default: true
    t.boolean  "hidden",                  default: false
  end

  create_table "organisms", force: :cascade do |t|
    t.text     "name"
    t.integer  "tax_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "genrep_key"
    t.text     "short_name"
  end

  create_table "project_diff_exprs", force: :cascade do |t|
    t.integer  "project_id"
    t.integer  "diff_expr_method_id"
    t.text     "attrs_json"
    t.integer  "status_id"
    t.integer  "duration"
    t.datetime "created_at"
  end

  create_table "project_dim_reductions", force: :cascade do |t|
    t.integer  "project_id"
    t.integer  "dim_reduction_id"
    t.integer  "status_id"
    t.integer  "duration"
    t.datetime "created_at"
    t.text     "attrs_json"
    t.integer  "pid"
  end

  create_table "project_steps", force: :cascade do |t|
    t.integer  "project_id"
    t.integer  "step_id"
    t.integer  "status_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "job_id"
    t.text     "error_message"
  end

  create_table "projects", force: :cascade do |t|
    t.text     "name"
    t.string   "key",                      limit: 6
    t.text     "input_filename"
    t.text     "group_filename"
    t.integer  "organism_id",                        default: 1
    t.integer  "norm_id"
    t.text     "norm_attrs_json"
    t.integer  "filter_id"
    t.text     "filter_attrs_json"
    t.integer  "step",                     limit: 2
    t.integer  "status_id",                          default: 1
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "step_id",                            default: 1
    t.text     "parsing_attrs_json"
    t.integer  "duration"
    t.integer  "delayed_job_id"
    t.text     "error_message"
    t.integer  "pid"
    t.boolean  "public",                             default: false
    t.integer  "filter_method_id"
    t.text     "filter_method_attrs_json"
  end

  create_table "selections", force: :cascade do |t|
    t.text     "label"
    t.integer  "manual_num"
    t.integer  "cluster_id"
    t.integer  "cluster_num"
    t.integer  "nb_cells"
    t.integer  "project_id"
    t.boolean  "edited",      default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "md5"
  end

  create_table "sessions", force: :cascade do |t|
    t.string   "session_id", null: false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["session_id"], name: "index_sessions_on_session_id", unique: true, using: :btree
    t.index ["updated_at"], name: "index_sessions_on_updated_at", using: :btree
  end

  create_table "speeds", force: :cascade do |t|
    t.text "name"
    t.text "logo"
  end

  create_table "statuses", force: :cascade do |t|
    t.text "name"
    t.text "label"
    t.text "color"
    t.text "img_extension"
  end

  create_table "steps", force: :cascade do |t|
    t.text "name"
    t.text "label"
    t.text "obj_name"
  end

  create_table "tool_types", force: :cascade do |t|
    t.text "name"
  end

  create_table "tools", force: :cascade do |t|
    t.text     "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "label"
    t.text     "step_ids"
    t.integer  "tool_type_id"
  end

  create_table "uploads", force: :cascade do |t|
    t.integer  "project_id"
    t.integer  "upload_type"
    t.text     "name"
    t.text     "status"
    t.text     "upload_file_name"
    t.text     "upload_content_type"
    t.integer  "upload_file_size"
    t.datetime "upload_updated_at"
    t.boolean  "visible"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  create_table "versions", force: :cascade do |t|
    t.datetime "release_date"
    t.text     "description"
    t.text     "tools_json"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "tool_type_id"
    t.integer  "step_id"
  end

  add_foreign_key "changes", "tools", name: "changes_tool_id_fkey"
  add_foreign_key "cluster_methods", "speeds", name: "cluster_methods_speed_id_fkey"
  add_foreign_key "clusters", "cluster_methods", name: "clusters_cluster_method_id_fkey"
  add_foreign_key "clusters", "dim_reductions", name: "clusters_dim_reduction_id_fkey"
  add_foreign_key "clusters", "projects", name: "clusters_project_id_fkey"
  add_foreign_key "clusters", "statuses", name: "clusters_status_id_fkey"
  add_foreign_key "clusters", "steps", name: "clusters_step_id_fkey"
  add_foreign_key "courses", "projects", name: "courses_project_id_fkey"
  add_foreign_key "diff_expr_methods", "speeds", name: "diff_expr_methods_speed_id_fkey"
  add_foreign_key "diff_exprs", "diff_expr_methods", name: "diff_exprs_diff_expr_method_id_fkey"
  add_foreign_key "diff_exprs", "projects", name: "diff_exprs_project_id_fkey"
  add_foreign_key "diff_exprs", "statuses", name: "diff_exprs_status_id_fkey"
  add_foreign_key "dim_reductions", "speeds", name: "dim_reductions_speed_id_fkey"
  add_foreign_key "filter_methods", "speeds", name: "filters_speed_id_fkey"
  add_foreign_key "gene_enrichments", "diff_exprs", name: "gene_enrichments_diff_expr_id_fkey"
  add_foreign_key "gene_enrichments", "projects", name: "gene_enrichments_project_id_fkey"
  add_foreign_key "gene_enrichments", "statuses", name: "gene_enrichments_status_id_fkey"
  add_foreign_key "genes", "organisms", name: "genes_organism_id_fkey"
  add_foreign_key "jobs", "statuses", name: "jobs_status_id_fkey"
  add_foreign_key "jobs", "steps", name: "jobs_step_id_fkey"
  add_foreign_key "jobs", "users", name: "jobs_user_id_fkey"
  add_foreign_key "norms", "speeds", name: "norms_speed_id_fkey"
  add_foreign_key "project_diff_exprs", "diff_expr_methods", name: "project_diff_exprs_diff_expr_method_id_fkey"
  add_foreign_key "project_diff_exprs", "projects", name: "project_diff_exprs_project_id_fkey"
  add_foreign_key "project_diff_exprs", "statuses", name: "project_diff_exprs_status_id_fkey"
  add_foreign_key "project_dim_reductions", "dim_reductions", name: "project_dim_reductions_dim_reduction_id_fkey"
  add_foreign_key "project_dim_reductions", "projects", name: "project_dim_reductions_project_id_fkey"
  add_foreign_key "project_dim_reductions", "statuses", name: "project_dim_reductions_status_id_fkey"
  add_foreign_key "project_steps", "jobs", name: "project_steps_job_id_fkey"
  add_foreign_key "project_steps", "projects", name: "project_steps_project_id_fkey"
  add_foreign_key "project_steps", "statuses", name: "project_steps_status_id_fkey"
  add_foreign_key "project_steps", "steps", name: "project_steps_step_id_fkey"
  add_foreign_key "projects", "filter_methods", column: "filter_id", name: "projects_filter_id_fkey"
  add_foreign_key "projects", "filter_methods", name: "projects_filter_method_id_fkey"
  add_foreign_key "projects", "norms", name: "projects_norm_id_fkey"
  add_foreign_key "projects", "organisms", name: "projects_organism_id_fkey"
  add_foreign_key "projects", "statuses", name: "projects_status_id_fkey"
  add_foreign_key "projects", "steps", name: "projects_step_id_fkey"
  add_foreign_key "projects", "users", name: "projects_user_id_fkey"
  add_foreign_key "selections", "projects", name: "selections_project_id_fkey"
  add_foreign_key "tools", "tool_types", name: "tools_tool_type_id_fkey"
  add_foreign_key "uploads", "projects", name: "uploads_project_id_fkey"
  add_foreign_key "versions", "steps", name: "versions_step_id_fkey"
  add_foreign_key "versions", "tool_types", name: "versions_tool_type_id_fkey"
end
