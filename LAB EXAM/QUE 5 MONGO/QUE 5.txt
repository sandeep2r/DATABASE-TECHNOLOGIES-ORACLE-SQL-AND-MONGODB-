db.createCollection('my_col');

db.my_col.insert([{"title":"MongoDB Overview",
                    "description":"MongoDB is no SQL database",
                    "by":"tutorials point",
                    "url":"http://www.tutorialspoint.com",
                    "tags":["mongodb","database","NoSQL"],
                    "likes": 100
                    
                    },
                    {"title":"NoSQL Database",
                    "description":"NoSQL database doesn't have tables",
                    "by":"tutorials point",
                    "url":"http://www.tutorialspoint.com",
                    "tags":["mongodb","database","NoSQL"],
                    "likes": 20,
                    "comments":[
                                {
                                "user":"user1",
                                "message":"My first comment",
                                "dateCreated": new Date(2013,11,10,2,35),
                                "likes": 0
                                }]
                    
                    
                    }]);
                    
 db.my_col.find();
 
 --1ST ANSWER
 
 db.my_col.find({"likes":{$gt : 10}});
 
 --2ND ANSWER
 db.my_col.find({"comments.user":"user1"});