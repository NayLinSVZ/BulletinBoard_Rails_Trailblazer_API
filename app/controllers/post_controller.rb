class PostController < ApplicationController
  before_action :authorized, except: [:index ]

  def index
    posts = Post::Operation::Index.(params: params)  
    render json: posts
  end

  def create
    post = Post::Operation::Create.(params: params)
    render json: post
  end

  def validate
    post = Post::Operation::Create::Present.(params: params)
    
    if post[:fail]
      return render json: post[:'contract.default'].errors , status: 422
    end
    render json: post
  end

  def show
    post = Post::Operation::Show.(params: params)
    if post[:fail]
      return render json: {error: post[:fail]} , status: 422
    end
    render json: post
  end

  def remove
    post = Post::Operation::Remove.(params: params)
    if post[:fail]
      return render json: {error: post[:fail]} , status: 422
    end
    render json: post
  end
  
  def validateEdit
    @post = Post.find_by(id: params[:id])
    @post.title = params[:post][:title]
    if !@post.valid?        
      render json: @post.errors , status: 400
    else 
      render  json: @post, status: 200 
    end
  end

  def update
    post = Post::Operation::Update.(params: params)
    render json: post
  end

  def download
   posts = Post::Operation::Download.(params: params) 
   render json: posts
  end

  def upload
    posts = Post::Operation::Upload::FilterList.(params: params)
    postList = []

    if posts[:err]
      render json: posts[:err] , status: 422
    else
      postList = posts[:postList]
      postList.each do |value|
        post = Post::Operation::Create::Present.(params: value)
        if post[:fail]
         return render json: post[:'contract.default'].errors , status: 422
        end
      end
      ccc =[]
      postList.each do |value|
        ccc = Post::Operation::Create.(params: value)
      end
      render json: ccc 
    end
  end
end
