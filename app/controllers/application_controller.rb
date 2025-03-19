class ApplicationController < ActionController::Base
  after_action -> { flash.clear }, if: -> { request.xhr? }
end
