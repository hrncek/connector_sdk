{
  title: 'Wachete',

  connection: {
    authorization: {
      type: 'oauth2',

      authorization_url: ->() {
        'https://www.wachete.com/login'
      },

      token_url: ->() {
        'https://api.wachete.com/v1/oauth/token'
      },

      client_id: 'zapier.aba8d501-9542-4ccc-8317-5c0d7b22a2c8',

      client_secret: 'c90f6ab9-1fea-47bd-a732-2930f30cec02',

      credentials: ->(connection, access_token) {
        headers('Authorization': "bearer #{access_token}")
      }
    }
  },

  object_definitions: {

   notification: {
     
     preview: ->(connection) {
     	get("https://api.wachete.com/v1/alert/range?from=2006-01-25T10%3A37%3A23.574Z&to=2020-01-23T10%3A37%3A23.574Z&count=1")['results'].first
     },

      fields: ->() {
        [
          {
            name: 'id',
          },
          {
            name: 'task',
            type: :object,
            properties: [
              {
                name: 'definition',
              	type: :object,
              	properties: [
                  {
                		name: 'name',
                    hint: 'Name of wachet you received notification for'
                  }
                ]
              }
            ]
          },
          {
            name: 'timestampUtc',
            type: :timestamp,
            hint: 'Time when notification happened'
          },
          {
            name: 'current',
            hint: 'Current value of wachet'
          },
          {
            name: 'comparand',
            hint: 'Previous value of wachet'
          },
          {
            name: 'type',
            hint: 'Type of notification'
          }
        ]
      }
    }
  },

  test: ->(connection) {
    get("https://api.wachete.com/v1/task/get")
  },

  
  triggers: {

    new_notification: {
      input_fields: ->() {
      
      },

      poll: ->(connection, input, last_updated_since) {

        notifications = get("https://api.wachete.com/v1/alert/range?from=2006-01-25T10%3A37%3A23.574Z&to=2020-01-23T10%3A37%3A23.574Z&count=2")

        {
         	events: notifications['data']
        }
      },

      dedup: ->(notification) {
        notification['id']
      },

      output_fields: ->(object_definitions) {
        object_definitions['notification']
      }
    }
  }
}