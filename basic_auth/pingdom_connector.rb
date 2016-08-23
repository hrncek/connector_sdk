{
  title: 'Pingdom',
    connection: {
    fields: [
      
      {
        name: 'app_key',
        optional: false,
        label: 'Application key'
      },
    
      {
        name: 'username',
        optional: true,
        hint: 'Your username'
      },
      {
        name: 'password',
        control_type: 'password',
        label: 'Password'
      }
    ],

  authorization: {
      type: 'basic_auth',
      credentials: ->(connection) {    
          user(connection['username'])
          password(connection['password'])
          headers('App-Key': connection['app_key'])
      }
    }
  },
  
   test: ->(connection) {
    get("https://api.pingdom.com/api/2.0/actions")
  },
  
  object_definitions: {
    
<<<<<<< HEAD
    checks:{
      fields: ->(){
        [
          { name: 'check',type: :object,properties:[
           { name: 'id',type: :integer },
           { name: 'name' },
           { name: 'resolution',type: :integer },
           { name: 'hostname' },
           { name: 'status' },
           { name: 'sendtoemail' , type: :boolean },
           { name: 'sendtosms' , type: :boolean },
           { name: 'sendtotwitter' , type: :boolean },
           { name: 'sendtoiphone' , type: :boolean },
           { name: 'sendtoandroid' , type: :boolean },
           { name: 'sendnotificationwhendown' , type: :integer },
           { name: 'notifyagainevery' , type: :integer },
           { name: 'notifywhenbackup' , type: :boolean },
           { name: 'contactids' , type: :integer }]}
          ]}
=======
    check:{
      fields: ->(){
        [
           {name: 'id',type: :integer},
           {name: 'name'},
           {name: 'hostname'},
           {name: 'status'},
           {name: 'resolution',type: :integer},
           {name: 'sendtoemail',type: :boolean},
           {name: 'sendtosms',type: :boolean},
           {name: 'sendnotificationwhendown',type: :integer},
           {name: 'notifyagainevery',type: :integer},
           {name: 'notifywhenbackup',type: :boolean},
           {name: 'contactids',type: :integer}]
        }
>>>>>>> 9532c2f203ddc820710605cf088cad3ed48af2cf
      },
    
    alert:{
      fields: ->(){
        [
<<<<<<< HEAD
           { name: 'contactname' },
           { name: 'contactid' , type: :integer },
           { name: 'time' , type: :integer },
           { name: 'via' },
           { name: 'status' },
           { name: 'messageshort' },
           { name: 'messagefull' },
           { name: 'sentto' }
=======
           {name: 'contactname'},
           {name: 'contactid',type: :integer},
           {name: 'time',type: :integer},
           {name: 'via'},
           {name: 'status'},
           {name: 'messageshort'},
           {name: 'messagefull'},
           {name: 'sentto'}
>>>>>>> 9532c2f203ddc820710605cf088cad3ed48af2cf
          ]
        }
      }
    },
  
 actions: {
   
  get_detailed_check_information: {
      
    description: 'Get <span class="provider">Check Information</span> in <span class="provider">Pingdom</span>',
      
    input_fields: ->() {[
        { name: 'checkid' , type: :integer , label: 'Enter your Check ID' , hint: 'Go to Monitering->Uptime->select the check you will get your CheckId in the url at the end ' , optional: false}
      ]
      },

    execute: ->(connection, input) {
        get("https://api.pingdom.com/api/2.0/checks/#{input['checkid']}") 
      },

    output_fields: ->(object_definitions) {
<<<<<<< HEAD
         object_definitions['checks']
      },
    
    sample_output: ->(connection) {
      check = get("https://api.pingdom.com/api/2.0/checks")['checks'].first
      if check.present? && check['id'].present?	  
      	get("https://api.pingdom.com/api/2.0/checks/#{check['id']}")
      else
        {}
      end
=======
        [ 
          {name: 'check',type: :object,properties: object_definitions['check']}
          ]
>>>>>>> 9532c2f203ddc820710605cf088cad3ed48af2cf
      }
    }
   },
  
 triggers: {

    new_alert: {
      
       description: 'New <span class="provider">alert</span> in <span class="provider">Pingdom</span>',
      
       type: :paging_desc,

       input_fields: ->() {
        [
          {
            name: 'since',
            type: :timestamp,
            optional: false
          }
        ]
      },

        poll: ->(connection, input, page) {
          limit = 100
          page ||= 0
        	created_since = (input['since'] || Time.now).to_i
					offset = (limit * page)
        	response = get("https://api.pingdom.com/api/2.0/actions?from=#{created_since}&limit=100&offset=#{offset}")                
          page = page + 1
        {
          events: response['actions']['alerts'],
          next_page: (response['actions']['alerts']).present? && (response['actions']['alerts']).length == limit ? page + 1 : nil

        }
      },
      
        sort_by: ->(response) {
         response['time']
      },
<<<<<<< HEAD
      
        output_fields: ->(object_definitions) {
          object_definitions['alert']
        },
      
        sample_output: ->(connection) {
        get("https://api.pingdom.com/api/2.0/actions")['actions']['alerts'].first || {}
       }
      }
    },
  }

=======

        output_fields: ->(object_definitions) {
          object_definitions['alert']
        }
      }
  },
}
>>>>>>> 9532c2f203ddc820710605cf088cad3ed48af2cf
