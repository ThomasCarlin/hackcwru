class EntitiesController < ApplicationController
	before_filter :find_entity
	def index
		@entities = Entity.all
	end
	def new
		@entity = Entity.new
	end
	def create
		@entity = Entity.new(entity_params)
		@entity.save
		redirect_to @entity
	end

	def show
		@entity = Entity.find(params[:id])
	end

	private
	def find_entity
		@entity = Entity.find(params[:id]) if params[:id]
	end
	def entity_params
		params.require(:entity).permit(:name, :description,:degree,:major,:position,:website,:pic)
	end
end