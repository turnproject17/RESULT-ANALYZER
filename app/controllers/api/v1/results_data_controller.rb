module Api
  module V1
    class ResultsDataController < Api::V1::ApplicationController

      def create
        @result = Result.new(result_data_params)

        if @result.save
          render json: {
            message: "success"
          }, status: 200
        else
          render json: {
            message: "failed"
          }, status: :unprocessible_entity
        end
      end

      def result_data_params
        params.require(:result_data).permit(:subject, :timestamp, :marks)
      end
    end
  end
end
