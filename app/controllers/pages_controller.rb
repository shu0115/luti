# coding: utf-8
class PagesController < ApplicationController

  #-------#
  # index #
  #-------#
  def index
    @talk_id = params[:talk_id]
    # @talk = Talk.where( user_id: session[:user_id], id: @talk_id ).first
    # @pages = Page.where( user_id: session[:user_id], talk_id: @talk_id ).order( "number ASC" ).all
    @talk = Talk.where( id: @talk_id ).first
    @pages = Page.where( talk_id: @talk_id ).order( "number ASC" ).all
    @page = Page.new
  end

  #---------#
  # display #
  #---------#
  def display
    # 自ユーザ以外も閲覧可能
#    @page = Page.where( id: params[:id], user_id: session[:user_id] ).first
    @page = Page.where( id: params[:id] ).first
    
    if @page.template == "Redirect" and !@page.contents.blank?
      redirect_to @page.contents and return
    end
    
    render layout: false
  end

  #-------#
  # slide #
  #-------#
  def slide
    talk_id = params[:talk_id]
    
    # 自ユーザ以外も閲覧可能
#    pages = Page.where( user_id: session[:user_id], talk_id: talk_id ).order( "number ASC" ).page( params[:page] ).per( 1 )
    pages = Page.where( talk_id: talk_id ).order( "number ASC" ).page( params[:page] ).per( 1 )
    
    @pages = pages
    @page = pages.first
    
    render layout: 'slide'
  end

  #------#
  # show #
  #------#
  def show
    @page = Page.where( id: params[:id], user_id: session[:user_id] ).first
    
    redirect_to( { controller: "talks" }, alert: "該当するデータがありません。" ) and return if @page.blank?
  end

  #------#
  # edit #
  #------#
  def edit
    @page = Page.where( id: params[:id], user_id: session[:user_id] ).first
    
    redirect_to( { controller: "talks" }, alert: "該当するデータがありません。" ) and return if @page.blank?
    
    @submit = "update"
  end

  #--------#
  # create #
  #--------#
  def create
    @talk_id = params[:talk_id]
    @talk = Talk.where( id: @talk_id ).first

    redirect_to( { controller: "talks" }, alert: "該当するデータがありません。" ) and return if @talk.blank?
    
    @page = Page.new( params[:page] )
    @page.user_id = session[:user_id]
    @page.talk_id = @talk.id
    @page.number = ( Page.where( talk_id: @talk.id ).maximum( :number ).to_i + 1 )
    
    if @page.save
      redirect_to( { action: "index", talk_id: @talk.id } )
    else
      redirect_to( { action: "index", talk_id: @talk.id }, alert: "ページ作成に失敗しました。" )
    end
  end

  #--------#
  # update #
  #--------#
  def update
    @page = Page.where( id: params[:id], user_id: session[:user_id] ).first

    redirect_to( { controller: "talks" }, alert: "該当するデータがありません。" ) and return if @page.blank?

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
    
    redirect_to( { controller: "talks" }, alert: "該当するデータがありません。" ) and return if @page.blank?
    
    @page.destroy

    redirect_to( action: "index", talk_id: @page.talk_id )
  end

end
