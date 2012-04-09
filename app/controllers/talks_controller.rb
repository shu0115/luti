# coding: utf-8
class TalksController < ApplicationController

  #-------#
  # index #
  #-------#
  def index
    @talks = Talk.where( user_id: session[:user_id] ).all
  end

  #------#
  # show #
  #------#
  def show
    @talk = Talk.where( id: params[:id], user_id: session[:user_id] ).first
  end

  #-----#
  # new #
  #-----#
  def new
    @talk = Talk.new
    
    @submit = "create"
  end

  #------#
  # edit #
  #------#
  def edit
    @talk = Talk.where( id: params[:id], user_id: session[:user_id] ).first
    
    @submit = "update"
  end

  #--------#
  # create #
  #--------#
  def create
    @talk = Talk.new( params[:talk] )
    @talk.user_id = session[:user_id]

    if @talk.save
      redirect_to( { action: "index" }, notice: "Talk was successfully created." )
    else
      render action: "new"
    end
  end

  #--------#
  # update #
  #--------#
  def update
    @talk = Talk.where( id: params[:id], user_id: session[:user_id] ).first

    if @talk.update_attributes( params[:talk] )
      redirect_to( { action: "show", id: params[:id] }, notice: "Talk was successfully updated." )
    else
      render action: "edit", id: params[:id]
    end
  end

  #---------#
  # destroy #
  #---------#
  def destroy
    @talk = Talk.where( id: params[:id], user_id: session[:user_id] ).first
    @talk.destroy

    redirect_to action: "index"
  end

end
