class BlogsController < ApplicationController
  before_action :set_blog, only: [:show, :edit, :update, :destroy, :cropper]

  # GET /blogs
  # GET /blogs.json
  def index
    @blogs = Blog.all
  end

  # GET /blogs/1
  # GET /blogs/1.json
  def show
  end

  # GET /blogs/new
  def new
    @blog = Blog.new
  end

  # GET /blogs/1/edit
  def edit

  end

  # POST /blogs
  # POST /blogs.json
  def create
    @blog = Blog.new(blog_params)
       if @blog.save
        render "cropper"
      else
        render :new 
      end  
  end

  # PATCH/PUT /blogs/1
  # PATCH/PUT /blogs/1.json
  def update
    respond_to do |format|
      if @blog.update(blog_params)
          format.html { redirect_to cropper_path(@blog.id), notice: 'Blog was successfully updated.' }
          format.json { render :show, status: :ok, location: @blog }
      else
        format.html { render :edit }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def cropper
    if request.post?
      if @blog.update(blog_params)
        @blog.reprocess_avatar
        redirect_to @blog
      end
    end
  end

  # DELETE /blogs/1
  # DELETE /blogs/1.json
  def destroy
    @blog.destroy
    respond_to do |format|
      format.html { redirect_to blogs_url, notice: 'Blog was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_blog
      @blog = Blog.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def blog_params
      params.require(:blog).permit(:name, :description, :image, :crop_x, :crop_y, :crop_w, :crop_h)
    end
end
