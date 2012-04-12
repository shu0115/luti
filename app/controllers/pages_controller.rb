# coding: utf-8
class PagesController < ApplicationController

  #-------#
  # index #
  #-------#
  def index
    @talk_id = params[:talk_id]
    @pages = Page.where( user_id: session[:user_id], talk_id: @talk_id ).order( "number ASC" ).all
    @page = Page.new
  end

  #---------#
  # display #
  #---------#
  def display
    @page = Page.where( id: params[:id], user_id: session[:user_id] ).first
    
    render layout: false
  end

  #------#
  # show #
  #------#
  def show
    @page = Page.where( id: params[:id], user_id: session[:user_id] ).first
  end
  
  #-----#
  # new #
  #-----#
  def new
    @page = Page.new
    
    @submit = "create"
  end

  #------#
  # edit #
  #------#
  def edit
    @page = Page.where( id: params[:id], user_id: session[:user_id] ).first
    
    @submit = "update"
  end

  #--------#
  # create #
  #--------#
  def create
    @talk_id = params[:talk_id]
    @page = Page.new( params[:page] )
    @page.user_id = session[:user_id]
    @page.talk_id = @talk_id
    @page.number = (Page.where( talk_id: @talk_id ).maximum( :number ).to_i + 1)
    
    if @page.save
      redirect_to( { action: "index", talk_id: @talk_id } )
    else
      redirect_to( { action: "index", talk_id: @talk_id }, alert: "ページ作成に失敗しました。" )
    end
  end

  #--------#
  # update #
  #--------#
  def update
    @page = Page.where( id: params[:id], user_id: session[:user_id] ).first

    if @page.update_attributes( params[:page] )
#      redirect_to( { action: "show", id: params[:id] }, notice: "Page was successfully updated." )
      redirect_to( action: "index", talk_id: @page.talk_id )
    else
      render( action: "edit", id: params[:id] )
    end
  end

  #---------#
  # destroy #
  #---------#
  def destroy
    @page = Page.where( id: params[:id], user_id: session[:user_id] ).first
    @page.destroy

    redirect_to( action: "index", talk_id: @page.talk_id )
  end

end
