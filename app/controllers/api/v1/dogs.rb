# create two endpointes for API; a basic GET for an index and 
# a GET for singular resource


module API
  module V1
    class Dogs < Grape::API
      include API::V1::Defaults

      resource :users do 
        segment '/:user_id' do
          resource '/dogs' do
            desc "Return all dogs"
            get "", root: :dogs do
              Dog.all
            end

            desc "Return a dog"
            params do
              requires :id, type: String, desc: "ID of the dog"
            end
            get ":id", root: "dog" do
              Dog.where(id: permitted_params[:id]).first
            end
          end
        end
      end
    end
  end
end

