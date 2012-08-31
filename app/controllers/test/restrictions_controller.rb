# @private
# This controller is only used for testing purposes, it does not actually get used outside of test.
class Challah::Test::RestrictionsController < ApplicationController
  signin_required :only => [ :blah ]
  before_filter :signin_required, :only => [ :edit ]
  restrict_to_authenticated :only => [ :show ]
  restrict_to_permission :special, :only => [ :new ]

  def index
    current_user

    head :ok
  end

  def show
    head :ok
  end

  def new
    head :ok
  end

  def edit
    head :ok
  end

  def blah
    head :ok
  end
end