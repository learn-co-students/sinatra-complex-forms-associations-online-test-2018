class OwnersController < ApplicationController
  get '/owners' do
    @owners = Owner.all
    erb :'/owners/index'
  end

  get '/owners/new' do
    @pets = Pet.all
    erb :'/owners/new'
  end

  post '/owners' do
    @owner = Owner.create(params['owner'])
    if !params[:pet][:name].empty?
      @owner.pets << Pet.create(name: params[:pet][:name])
    end
    redirect "/owners/#{@owner.id}"
  end

  get '/owners/:id/edit' do
    @pets = Pet.all
    @owner = Owner.find(params[:id])
    erb :'/owners/edit'
  end

  get '/owners/:id' do
    @owner = Owner.find(params[:id])
    erb :'/owners/show'
  end

  patch '/owners/:id' do
    #if no boxes were checked, add the pet_id key to the owner hash and set it = []
    # active record will then properly update the association, removing any previous pets
    params[:owner]['pet_ids'] = [] if !params[:owner].keys.include?('pet_ids')
    @owner = Owner.find(params[:id])
    @owner.update(params['owner'])
    if !params['pet']['name'].empty?
      @owner.pets << Pet.create(name: params['pet']['name'])
    end
    redirect "owners/#{@owner.id}"
  end
end
