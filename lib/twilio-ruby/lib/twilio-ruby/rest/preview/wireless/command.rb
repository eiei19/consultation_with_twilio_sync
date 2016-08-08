##
# This code was generated by
# \ / _    _  _|   _  _
#  | (_)\/(_)(_|\/| |(/_  v1.0.0
#       /       /       

module Twilio
  module REST
    class Preview < Domain
      class Wireless < Version
        class CommandList < ListResource
          ##
          # Initialize the CommandList
          # @param [Version] version Version that contains the resource
          
          # @return [CommandList] CommandList
          def initialize(version)
            super(version)
            
            # Path Solution
            @solution = {}
            @uri = "/Commands"
          end
          
          ##
          # Lists CommandInstance records from the API as a list.
          # Unlike stream(), this operation is eager and will load `limit` records into
          # memory before returning.
          # @param [String] device The device
          # @param [String] status The status
          # @param [String] direction The direction
          # @param [Integer] limit Upper limit for the number of records to return. stream()
          #                   guarantees to never return more than limit.  Default is no limit
          # @param [Integer] page_size Number of records to fetch per request, when not set will                      use
          #  the default value of 50 records.  If no page_size is                      defined
          #  but a limit is defined, stream() will attempt to read                      the
          #  limit with the most efficient page size,                      i.e. min(limit, 1000)
          
          # @return [Array] Array of up to limit results
          def list(device: nil, status: nil, direction: nil, limit: nil, page_size: nil)
            self.stream(
                device: device,
                status: status,
                direction: direction,
                limit: limit,
                page_size: page_size
            ).entries
          end
          
          ##
          # Streams CommandInstance records from the API as an Enumerable.
          # This operation lazily loads records as efficiently as possible until the limit
          # is reached.
          # @param [String] device The device
          # @param [String] status The status
          # @param [String] direction The direction
          # @param [Integer] limit Upper limit for the number of records to return.                  stream()
          #  guarantees to never return more than limit.                  Default is no limit
          # @param [Integer] page_size Number of records to fetch per request, when                      not set will use
          #  the default value of 50 records.                      If no page_size is defined
          #                       but a limit is defined, stream() will attempt to                      read the
          #  limit with the most efficient page size,                       i.e. min(limit, 1000)
          
          # @return [Enumerable] Enumerable that will yield up to limit results
          def stream(device: nil, status: nil, direction: nil, limit: nil, page_size: nil)
            limits = @version.read_limits(limit, page_size)
            
            page = self.page(
                device: device,
                status: status,
                direction: direction,
                page_size: limits['page_size'],
            )
            
            @version.stream(page, limit: limits['limit'], page_limit: limits['page_limit'])
          end
          
          ##
          # When passed a block, yields CommandInstance records from the API.
          # This operation lazily loads records as efficiently as possible until the limit
          # is reached.
          # @param [String] device The device
          # @param [String] status The status
          # @param [String] direction The direction
          # @param [Integer] limit Upper limit for the number of records to return.                  stream()
          #  guarantees to never return more than limit.                  Default is no limit
          # @param [Integer] page_size Number of records to fetch per request, when                       not set will use
          #  the default value of 50 records.                      If no page_size is defined
          #                       but a limit is defined, stream() will attempt to read the
          #                       limit with the most efficient page size, i.e. min(limit, 1000)
          def each
            limits = @version.read_limits
            
            page = self.page(
                page_size: limits['page_size'],
            )
            
            @version.stream(page,
                            limit: limits['limit'],
                            page_limit: limits['page_limit']).each {|x| yield x}
          end
          
          ##
          # Retrieve a single page of CommandInstance records from the API.
          # Request is executed immediately.
          # @param [String] device The device
          # @param [String] status The status
          # @param [String] direction The direction
          # @param [String] page_token PageToken provided by the API
          # @param [Integer] page_number Page Number, this value is simply for client state
          # @param [Integer] page_size Number of records to return, defaults to 50
          
          # @return [Page] Page of CommandInstance
          def page(device: nil, status: nil, direction: nil, page_token: nil, page_number: nil, page_size: nil)
            params = {
                'Device' => device,
                'Status' => status,
                'Direction' => direction,
                'PageToken' => page_token,
                'Page' => page_number,
                'PageSize' => page_size,
            }
            response = @version.page(
                'GET',
                @uri,
                params
            )
            return CommandPage.new(@version, response, @solution)
          end
          
          ##
          # Retrieve a single page of CommandInstance records from the API.
          # Request is executed immediately.
          # @param [String] device The device
          # @param [String] command The command
          # @param [String] callback_method The callback_method
          # @param [String] callback_url The callback_url
          
          # @return [CommandInstance] Newly created CommandInstance
          def create(device: nil, command: nil, callback_method: nil, callback_url: nil)
            data = {
                'Device' => device,
                'Command' => command,
                'CallbackMethod' => callback_method,
                'CallbackUrl' => callback_url,
            }
            
            payload = @version.create(
                'POST',
                @uri,
                data: data
            )
            
            return CommandInstance.new(
                @version,
                payload,
            )
          end
          
          ##
          # Provide a user friendly representation
          def to_s
            '#<Twilio.Preview.Wireless.CommandList>'
          end
        end
      
        class CommandPage < Page
          ##
          # Initialize the CommandPage
          # @param [Version] version Version that contains the resource
          # @param [Response] response Response from the API
          # @param [Hash] solution Path solution for the resource
          
          # @return [CommandPage] CommandPage
          def initialize(version, response, solution)
            super(version, response)
            
            # Path Solution
            @solution = solution
          end
          
          ##
          # Build an instance of CommandInstance
          # @param [Hash] payload Payload response from the API
          
          # @return [CommandInstance] CommandInstance
          def get_instance(payload)
            return CommandInstance.new(
                @version,
                payload,
            )
          end
          
          ##
          # Provide a user friendly representation
          def to_s
            '<Twilio.Preview.Wireless.CommandPage>'
          end
        end
      
        class CommandContext < InstanceContext
          ##
          # Initialize the CommandContext
          # @param [Version] version Version that contains the resource
          # @param [String] sid The sid
          
          # @return [CommandContext] CommandContext
          def initialize(version, sid)
            super(version)
            
            # Path Solution
            @solution = {
                sid: sid,
            }
            @uri = "/Commands/#{@solution[:sid]}"
          end
          
          ##
          # Fetch a CommandInstance
          # @return [CommandInstance] Fetched CommandInstance
          def fetch
            params = {}
            
            payload = @version.fetch(
                'GET',
                @uri,
                params,
            )
            
            return CommandInstance.new(
                @version,
                payload,
                sid: @solution['sid'],
            )
          end
          
          ##
          # Provide a user friendly representation
          def to_s
            context = @solution.map {|k, v| "#{k}: #{v}"}.join(',')
            "#<Twilio.Preview.Wireless.CommandContext #{context}>"
          end
        end
      
        class CommandInstance < InstanceResource
          ##
          # Initialize the CommandInstance
          # @param [Version] version Version that contains the resource
          # @param [Hash] payload payload that contains response from Twilio
          # @param [String] sid The sid
          
          # @return [CommandInstance] CommandInstance
          def initialize(version, payload, sid: nil)
            super(version)
            
            # Marshaled Properties
            @properties = {
                'sid' => payload['sid'],
                'account_sid' => payload['account_sid'],
                'device_sid' => payload['device_sid'],
                'command' => payload['command'],
                'status' => payload['status'],
                'direction' => payload['direction'],
                'date_created' => Twilio.deserialize_iso8601(payload['date_created']),
                'date_updated' => Twilio.deserialize_iso8601(payload['date_updated']),
                'url' => payload['url'],
            }
            
            # Context
            @instance_context = nil
            @params = {
                'sid' => sid || @properties['sid'],
            }
          end
          
          ##
          # Generate an instance context for the instance, the context is capable of
          # performing various actions.  All instance actions are proxied to the context
          # @param [Version] version Version that contains the resource
          
          # @return [CommandContext] CommandContext for this CommandInstance
          def context
            unless @instance_context
              @instance_context = CommandContext.new(
                  @version,
                  @params['sid'],
              )
            end
            @instance_context
          end
          
          def sid
            @properties['sid']
          end
          
          def account_sid
            @properties['account_sid']
          end
          
          def device_sid
            @properties['device_sid']
          end
          
          def command
            @properties['command']
          end
          
          def status
            @properties['status']
          end
          
          def direction
            @properties['direction']
          end
          
          def date_created
            @properties['date_created']
          end
          
          def date_updated
            @properties['date_updated']
          end
          
          def url
            @properties['url']
          end
          
          ##
          # Fetch a CommandInstance
          # @return [CommandInstance] Fetched CommandInstance
          def fetch
            @context.fetch()
          end
          
          ##
          # Provide a user friendly representation
          def to_s
            context = @params.map{|k, v| "#{k}: #{v}"}.join(" ")
            "<Twilio.Preview.Wireless.CommandInstance #{context}>"
          end
        end
      end
    end
  end
end