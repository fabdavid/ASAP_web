Rails.application.routes.draw do

  resources :shares
  resources :gene_names
  resources :gene_set_names
  resources :db_sets
  resources :gene_sets do
    collection do
      get :autocomplete
    end
  end

  resources :courses do
    member do
      get 'upload', to: 'courses#upload'
      patch 'upload', to: 'courses#do_upload'
      get 'resume_upload', to: 'courses#resume_upload'
      patch 'update_status', to: 'courses#update_status'
      get 'reset_upload', to: 'courses#reset_upload'
    end
  end

  resources :uploads do
    member do
      get 'upload', to: 'uploads#upload'
      patch 'upload', to: 'uploads#do_upload'
      get 'resume_upload', to: 'uploads#resume_upload'
      patch 'update_status', to: 'uploads#update_status'
      get 'reset_upload', to: 'uploads#reset_upload'
    end
  end

  resources :tool_types
  resources :project_steps
  resources :gene_enrichments do
    member do
      get :get_list
    end
    collection do
      post :filter_results
    end
  end
  resources :versions do
    collection do
      get :last_version
    end
  end
  resources :filter_methods
  resources :jobs
  resources :diff_exprs do
    member do 
      get :list_genes
      get :get_selection
    end
    collection do
      post :filter_results
    end
  end

  resources :home do
    collection do 
      get :about
      get :file_format
      get :tutorial
      get :faq
    end
  end

  resources :changes
  resources :tools
  resources :diff_expr_methods
  resources :selections
  resources :project_dim_reductions
  resources :speeds
  resources :norms
  resources :filters
  resources :dim_reductions
  resources :clusters do
    member do
      get :to_tab
    end
  end
  resources :cluster_methods
  resources :genes do
    collection do
      get :autocomplete
    end
  end
  resources :statuses
  resources :steps
  devise_for :users

  resources :projects, param: :key do
    collection do
      post :upload_file
      get :get_cart
    end
    member do
      get :get_cells
      get :upload_form
      get :get_step
      get :get_file
      get :edit_name
      get :get_pipeline
      get :get_attributes
      get :get_visualization
      get :clone
      post :replot
      get :get_clusters
      get :get_selections
      get :set_viz_session
      post :delete_batch_file
      post :direct_download
#      post :post_visualization
    end
  end
  resources :organisms
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html                                                                                          



  root to: 'projects#index'

end
