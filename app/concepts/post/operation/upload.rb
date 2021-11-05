module Post::Operation
  class Upload < Trailblazer::Operation
    class FilterList < Trailblazer::Operation
      step :filetype

      def filetype(options, params:, **)
        csvfile = params[:csvfile]
        postList = []
        if csvfile.content_type == "text/csv" || csvfile.content_type == "application/vnd.ms-excel"
          CSV.foreach(csvfile.path, headers: true) do |row|
            if row.count == 3
              if row.headers[0]!="title" || row.headers[1] != "description" || row.headers[2] != "status"
                options[:err]="Wrong CSV File header.." 
              else
                post = row.to_hash.slice(*updatable_attributes)
                post[:create_user_id] = params[:create_user_id]
                post[:updated_user_id] = params[:updated_user_id]
                postList << post
              end
              options[:postList] = postList
            else
              options[:err] = "Post Upload CSV File must have 3 columns"
            end
          end
        else
          options[:err] = "Please Choose CSV File Format"
        end
      end

      def updatable_attributes
        ["title", "description", "status"]
      end
    end

    # step Nested(Present)
    # step Contract::Persist()
    step :notify!

    def notify!(options, **)
      options["notify"] = "Creation is OK"
    end
  end
end