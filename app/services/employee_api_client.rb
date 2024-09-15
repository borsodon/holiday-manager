# frozen_string_literal: true

class EmployeeApiClient
  include HTTParty

  base_uri 'https://gist.githubusercontent.com/alhafoudh/e46f708609366c762b7314e98aa213b9/raw/08e34a18eba801791c0b2557e1705e917a4b79bb'

  def fetch_employees(last_synced_at = nil)
    options = {}
    options[:query] = { since: last_synced_at.iso8601 } if last_synced_at
    response = self.class.get('/freevision_employees.json', options)

    raise "API request failed with response: #{response.body}" unless response.success?

    JSON.parse(response.parsed_response)['employees']
  end
end
