##
# This code was generated by
# \ / _    _  _|   _  _
#  | (_)\/(_)(_|\/| |(/_  v1.0.0
#       /       /       

module Twilio
  module REST
    class Api < Domain
      class V2010 < Version
        class AccountContext < InstanceContext
          class CallContext < InstanceContext
            class RecordingList < ListResource
              ##
              # Initialize the RecordingList
              # @param [Version] version Version that contains the resource
              # @param [String] account_sid The account_sid
              # @param [String] call_sid The call_sid
              
              # @return [RecordingList] RecordingList
              def initialize(version, account_sid: nil, call_sid: nil)
                super(version)
                
                # Path Solution
                @solution = {
                    account_sid: account_sid,
                    call_sid: call_sid
                }
                @uri = "/Accounts/#{@solution[:account_sid]}/Calls/#{@solution[:call_sid]}/Recordings.json"
              end
              
              ##
              # Lists RecordingInstance records from the API as a list.
              # Unlike stream(), this operation is eager and will load `limit` records into
              # memory before returning.
              # @param [Time] date_created_before The date_created
              # @param [Time] date_created The date_created
              # @param [Time] date_created_after: The date_created
              # @param [Integer] limit Upper limit for the number of records to return. stream()
              #                   guarantees to never return more than limit.  Default is no limit
              # @param [Integer] page_size Number of records to fetch per request, when not set will                      use
              #  the default value of 50 records.  If no page_size is                      defined
              #  but a limit is defined, stream() will attempt to read                      the
              #  limit with the most efficient page size,                      i.e. min(limit, 1000)
              
              # @return [Array] Array of up to limit results
              def list(date_created_before: nil, date_created: nil, date_created_after: nil, limit: nil, page_size: nil)
                self.stream(
                    date_created_before: date_created_before,
                    date_created: date_created,
                    date_created_after: date_created_after,
                    limit: limit,
                    page_size: page_size
                ).entries
              end
              
              ##
              # Streams RecordingInstance records from the API as an Enumerable.
              # This operation lazily loads records as efficiently as possible until the limit
              # is reached.
              # @param [Time] date_created_before The date_created
              # @param [Time] date_created The date_created
              # @param [Time] date_created_after: The date_created
              # @param [Integer] limit Upper limit for the number of records to return.                  stream()
              #  guarantees to never return more than limit.                  Default is no limit
              # @param [Integer] page_size Number of records to fetch per request, when                      not set will use
              #  the default value of 50 records.                      If no page_size is defined
              #                       but a limit is defined, stream() will attempt to                      read the
              #  limit with the most efficient page size,                       i.e. min(limit, 1000)
              
              # @return [Enumerable] Enumerable that will yield up to limit results
              def stream(date_created_before: nil, date_created: nil, date_created_after: nil, limit: nil, page_size: nil)
                limits = @version.read_limits(limit, page_size)
                
                page = self.page(
                    date_created_before: date_created_before,
                    date_created: date_created,
                    date_created_after: date_created_after,
                    page_size: limits['page_size'],
                )
                
                @version.stream(page, limit: limits['limit'], page_limit: limits['page_limit'])
              end
              
              ##
              # When passed a block, yields RecordingInstance records from the API.
              # This operation lazily loads records as efficiently as possible until the limit
              # is reached.
              # @param [Time] date_created_before The date_created
              # @param [Time] date_created The date_created
              # @param [Time] date_created_after: The date_created
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
              # Retrieve a single page of RecordingInstance records from the API.
              # Request is executed immediately.
              # @param [Time] date_created_before The date_created
              # @param [Time] date_created The date_created
              # @param [Time] date_created_after: The date_created
              # @param [String] page_token PageToken provided by the API
              # @param [Integer] page_number Page Number, this value is simply for client state
              # @param [Integer] page_size Number of records to return, defaults to 50
              
              # @return [Page] Page of RecordingInstance
              def page(date_created_before: nil, date_created: nil, date_created_after: nil, page_token: nil, page_number: nil, page_size: nil)
                params = {
                    'DateCreated<' => Twilio.serialize_iso8601(date_created_before),
                    'DateCreated' => Twilio.serialize_iso8601(date_created),
                    'DateCreated>' => Twilio.serialize_iso8601(date_created_after),
                    'PageToken' => page_token,
                    'Page' => page_number,
                    'PageSize' => page_size,
                }
                response = @version.page(
                    'GET',
                    @uri,
                    params
                )
                return RecordingPage.new(@version, response, @solution)
              end
              
              ##
              # Provide a user friendly representation
              def to_s
                '#<Twilio.Api.V2010.RecordingList>'
              end
            end
          
            class RecordingPage < Page
              ##
              # Initialize the RecordingPage
              # @param [Version] version Version that contains the resource
              # @param [Response] response Response from the API
              # @param [Hash] solution Path solution for the resource
              # @param [String] account_sid The account_sid
              # @param [String] call_sid The call_sid
              
              # @return [RecordingPage] RecordingPage
              def initialize(version, response, solution)
                super(version, response)
                
                # Path Solution
                @solution = solution
              end
              
              ##
              # Build an instance of RecordingInstance
              # @param [Hash] payload Payload response from the API
              
              # @return [RecordingInstance] RecordingInstance
              def get_instance(payload)
                return RecordingInstance.new(
                    @version,
                    payload,
                    account_sid: @solution['account_sid'],
                    call_sid: @solution['call_sid'],
                )
              end
              
              ##
              # Provide a user friendly representation
              def to_s
                '<Twilio.Api.V2010.RecordingPage>'
              end
            end
          
            class RecordingContext < InstanceContext
              ##
              # Initialize the RecordingContext
              # @param [Version] version Version that contains the resource
              # @param [String] account_sid The account_sid
              # @param [String] call_sid The call_sid
              # @param [String] sid The sid
              
              # @return [RecordingContext] RecordingContext
              def initialize(version, account_sid, call_sid, sid)
                super(version)
                
                # Path Solution
                @solution = {
                    account_sid: account_sid,
                    call_sid: call_sid,
                    sid: sid,
                }
                @uri = "/Accounts/#{@solution[:account_sid]}/Calls/#{@solution[:call_sid]}/Recordings/#{@solution[:sid]}.json"
              end
              
              ##
              # Fetch a RecordingInstance
              # @return [RecordingInstance] Fetched RecordingInstance
              def fetch
                params = {}
                
                payload = @version.fetch(
                    'GET',
                    @uri,
                    params,
                )
                
                return RecordingInstance.new(
                    @version,
                    payload,
                    account_sid: @solution['account_sid'],
                    call_sid: @solution['call_sid'],
                    sid: @solution['sid'],
                )
              end
              
              ##
              # Deletes the RecordingInstance
              # @return [Boolean] true if delete succeeds, true otherwise
              def delete
                return @version.delete('delete', @uri)
              end
              
              ##
              # Provide a user friendly representation
              def to_s
                context = @solution.map {|k, v| "#{k}: #{v}"}.join(',')
                "#<Twilio.Api.V2010.RecordingContext #{context}>"
              end
            end
          
            class RecordingInstance < InstanceResource
              ##
              # Initialize the RecordingInstance
              # @param [Version] version Version that contains the resource
              # @param [Hash] payload payload that contains response from Twilio
              # @param [String] account_sid The account_sid
              # @param [String] call_sid The call_sid
              # @param [String] sid The sid
              
              # @return [RecordingInstance] RecordingInstance
              def initialize(version, payload, account_sid: nil, call_sid: nil, sid: nil)
                super(version)
                
                # Marshaled Properties
                @properties = {
                    'account_sid' => payload['account_sid'],
                    'api_version' => payload['api_version'],
                    'call_sid' => payload['call_sid'],
                    'date_created' => Twilio.deserialize_rfc2822(payload['date_created']),
                    'date_updated' => Twilio.deserialize_rfc2822(payload['date_updated']),
                    'duration' => payload['duration'],
                    'sid' => payload['sid'],
                    'uri' => payload['uri'],
                }
                
                # Context
                @instance_context = nil
                @params = {
                    'account_sid' => account_sid,
                    'call_sid' => call_sid,
                    'sid' => sid || @properties['sid'],
                }
              end
              
              ##
              # Generate an instance context for the instance, the context is capable of
              # performing various actions.  All instance actions are proxied to the context
              # @param [Version] version Version that contains the resource
              
              # @return [RecordingContext] RecordingContext for this RecordingInstance
              def context
                unless @instance_context
                  @instance_context = RecordingContext.new(
                      @version,
                      @params['account_sid'],
                      @params['call_sid'],
                      @params['sid'],
                  )
                end
                @instance_context
              end
              
              def account_sid
                @properties['account_sid']
              end
              
              def api_version
                @properties['api_version']
              end
              
              def call_sid
                @properties['call_sid']
              end
              
              def date_created
                @properties['date_created']
              end
              
              def date_updated
                @properties['date_updated']
              end
              
              def duration
                @properties['duration']
              end
              
              def sid
                @properties['sid']
              end
              
              def uri
                @properties['uri']
              end
              
              ##
              # Fetch a RecordingInstance
              # @return [RecordingInstance] Fetched RecordingInstance
              def fetch
                @context.fetch()
              end
              
              ##
              # Deletes the RecordingInstance
              # @return [Boolean] true if delete succeeds, true otherwise
              def delete
                @context.delete()
              end
              
              ##
              # Provide a user friendly representation
              def to_s
                context = @params.map{|k, v| "#{k}: #{v}"}.join(" ")
                "<Twilio.Api.V2010.RecordingInstance #{context}>"
              end
            end
          end
        end
      end
    end
  end
end