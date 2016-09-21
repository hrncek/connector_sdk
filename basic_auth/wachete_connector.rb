{
	title: 'Wachete',
	connection: {
		authorization: {
			type: 'oauth2',
			authorization_url: ->(){
				'https: //www.wachete.com/login'
			},
			token_url: ->(){
				'https: //api.wachete.com/v1/oauth/token'
			},
			client_id: 'workato.e35b7ccc-8d33-4303-8faa-6355f66dc8af',
			client_secret: 'willsendyouviaemail',
			credentials: ->(connection,
			access_token){
				headers('Authorization': "bearer #{access_token}")
			}
		}
	},
	object_definitions: {
		notification: {
			preview: ->(connection){
				get("https://api.wachete.com/v1/alert/range").params(
					from: '2006-01-25T10: 37: 23.574Z',
					to: '2030-01-23T10: 37: 23.574Z',
					count: 1)['results'].first
			},
			fields: ->(){
				[{
					name: 'id',
					
				},
				{
					name: 'task',
					type: : object,
					properties: [{
						name: 'definition',
						type: : object,
						properties: [{
							name: 'name',
							hint: 'Nameofwachetyoureceivednotificationfor'
						}]
					}]
				},
				{
					name: 'timestampUtc',
					type: : timestamp,
					hint: 'Timewhennotificationhappened'
				},
				{
					name: 'current',
					hint: 'Currentvalueofwachet'
				},
				{
					name: 'comparand',
					hint: 'Previousvalueofwachet'
				},
				{
					name: 'type',
					hint: 'Typeofnotification'
				}]
			}
		}
	},
	test: ->(connection){
		get("https://api.wachete.com/v1/task/get")
	},
	triggers: {
		new_notification: {
			input_fields: ->(){
				
			},
			poll: ->(connection,
			input,
			last_updated_since){
				notifications=get("https://api.wachete.com/v1/alert/range").params(
					from: '2006-01-25T10: 37: 23.574Z',
					to: '2030-01-23T10: 37: 23.574Z',
					count: 1)
				{
					events: notifications['data']
				}
			},
			dedup: ->(notification){
				notification['id']
			},
			output_fields: ->(object_definitions){
				object_definitions['notification']
			}
		}
	}
}
