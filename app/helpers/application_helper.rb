# frozen_string_literal: true

# Service to download ftp files from the server
module ApplicationHelper
  # Returns the full title on a per-page basis.
  def full_title(page_title = '')
    base_title = 'Ruby on Rails Tutorial Sample App'
    if page_title.empty?
      base_title
    else
      "#{page_title} | #{base_title}"
    end
  end

  # google_oauth2

  #Bạn có thể thêm các phương thức trợ giúp vào ApplicationHelper.
  # Đảm bảo sử dụng tên mô hình thích hợp (trong trường hợp của tôi, nó :userđại diện cho Usermô hình).
   def devise_mapping
      Devise.mappings[:user]
    end

    def resource_name
      devise_mapping.name
    end

    def resource_class
      devise_mapping.to
    end
  #
end
