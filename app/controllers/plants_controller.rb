class PlantsController < ApplicationController

    get '/plants' do  #by convention, index route
        @plants = Plant.all  #@passes to view 
        erb :'plants/index' 
    end 

    get '/plants/new' do 
        erb :'plants/new' 
    end 

    post '/plants' do 
        @plant = Plant.new(water: params[:water], light: params[:light], price: params[:price])
        @greenhouse = Greenhouse.find_by(name: params[:greenhouse])
        if @greenhouse 
            @plant.greenhouse = @greenhouse 
        else 
            @plant.build_greenhouse(name: params[:greenhouse])
        end

        if @plant.save
            redirect '/plants'
        else 
            redirect '/plants/new'
        end 
        
    end 

    get '/plants/:id' do 
        @plant = Plant.find_by(id: params[:id])
        if @plant 
            erb :'plants/show'
        else 
            redirect "/plants"
        end 
    end 

end