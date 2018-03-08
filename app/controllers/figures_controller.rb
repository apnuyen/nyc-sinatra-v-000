class FiguresController < ApplicationController

  get "/figures" do
    @figures = Figure.all
    erb :"figures/index"
  end

  get "/figures/new" do
    erb :"figures/new"
  end

  post "/figures" do
    figure = Figure.new(params[:figure])
    figure.landmarks.find_or_initialize_by(params[:landmark])
    figure.titles.find_or_initialize_by(params[:title])
    figure.save
    redirect to "/figures/#{figure.id}"
  end

  get "/figures/:id" do
    @figure = Figure.find(params[:id])
    erb :"figures/show"
  end

  get "/figures/:id/edit" do
    @figure = Figure.find(params[:id])
    erb :"figures/edit"
  end

  patch "/figures/:id" do
    figure = Figure.find(params[:id])
    figure.update(params[:figure])
    figure.landmarks.find_or_create_by(params[:landmark])
    figure.titles.find_or_create_by(params[:title])

    redirect to "/figures/#{figure.id}"
  end
end
