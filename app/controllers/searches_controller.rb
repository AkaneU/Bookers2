class SearchesController < ApplicationController

  def search
    @model = params["model"]
    @content = params["content"]
    @method = params["method"]
    @records = search_for(@model, @content, @method)
  end

  private
  def search_for(model, content, method)
    if model == 'user'
      if method == 'perfect'
        User.where(name: content)
      elseif method == 'partial'
        User.where('name LIKE ?', '%'+content+'%')
      elseif method == 'forward'
        User.where('name LIKE ?', '#{content}%')
      else
        User.where('name LIKE ?', '%#{content}')
      end
    elseif model == 'book'
      if method == 'perfect'
        Bookr.where(title: content)
      elseif method == 'partial'
        Book.where('title LIKE ?', '%'+content+'%')
      elseif method == 'forward'
        Book.where('title LIKE ?', '#{content}%')
      else
        Book.where('title LIKE ?', '%#{content}')
      end
    end
  end
end