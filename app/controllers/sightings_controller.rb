class SightingsController < ApplicationController
    def index
        sightings = Sighting.all
        render json: sightings, include: [:bird, :location]
    end

    def show
        sighting = Sighting.find_by(id: params[:id])
        if sighting
            # option 1: explicit with no rails magic
            # render json: sighting.to_json(include: [:bird, :location])

            # option 2: implicit with rails magic
            # render json: sighting, include: [:bird, :location], except: [:updated_at]

            # option 3: include with only and except
            # render json: sighting.to_json(include: {
            #     bird: {only: [:name, :species]},
            #     location: {only: [:latitude, :longitude]}},
            #     except: [:updated_at]
            # )

            render json: sighting, include: {
                bird: {only: [:name, :species]},
                location: {only: [:latitude, :longitude]}},
                except: [:updated_at]
        else
            render json: { message: 'No sighting found with that id' }
        end
    end
end
