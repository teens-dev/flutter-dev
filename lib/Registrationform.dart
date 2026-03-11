import 'package:flutter/material.dart';

class Registrationform extends StatefulWidget {
  const Registrationform({super.key});

  @override
  State<Registrationform> createState() => _RegistrationformState();
}

class _RegistrationformState extends State<Registrationform> {
  final _formkey=GlobalKey<FormState>();
  final namecontroller = TextEditingController();
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final phonecontroller=TextEditingController();
  String Countrycode = '+91';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.lightBlue,centerTitle:true,title: Text('Registration Form',style: TextStyle(fontWeight: FontWeight.w800),),
      ),
      body:Center(
        child:SizedBox(
          child: Card(
            elevation: 8,
          shadowColor: Colors.yellow,
          margin: EdgeInsets.all(20),
          child: Padding(padding: EdgeInsetsGeometry.all(20),
            child:Form(
              key: _formkey,
              child:Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Registration Form",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    controller: namecontroller,
                    decoration:InputDecoration(
                      labelText: 'Name',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value){
                      if(value == null || value.isEmpty){
                        return "please enter your name";
                      }
                      return null;
                      },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: emailcontroller,
                    decoration: InputDecoration(
                      labelText: 'email',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value){
                      if(value==null || value.isEmpty){
                        return 'Enter your email Id';
                      }
                      if(!value.contains("@")){
                        return 'Entter valid email Id';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  Row(
                    children: [

                      DropdownButton<String>(
                        value: Countrycode,
                        items: ["+91","+1","+44"]
                            .map((code) => DropdownMenuItem(
                          value: code,
                          child: Text(code),
                        ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            Countrycode = value!;
                          });
                        },
                      ),
                      SizedBox(width: 10),
                      Expanded(child: TextFormField(
                        controller: phonecontroller,
                        decoration: InputDecoration(
                          labelText: 'phone',
                          border: OutlineInputBorder(),
                        ),
                        validator:(value){
                          if(value==null||value.isEmpty){
                            return "Enter valid Phonenumber";
                          }
                          if(value.length!=10){
                            return 'phone number must be 10 digits';
                          }
                          return null;
                      },
                      ))
                    ],
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: passwordcontroller,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'password',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value){
                      if(value==null||value.isEmpty){
                        return 'Enter the password';
                      }
                      String patterns=r'^[A-Z](?=.*[0-9])(?=.*[!@#$%^&*()_\-+]).{5,}$';
                      RegExp regex= RegExp(patterns);
                      if(!regex.hasMatch(value)){
                        return "password must be 6 characters";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 25),
                  ElevatedButton(onPressed: (){
                    if(_formkey.currentState!.validate()){
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(backgroundColor: Colors.green,content: Text("Form Submitted",style: TextStyle(color: Colors.black),)),);
                    }else{
                      showDialog(context: context, builder: (context){
                        return AlertDialog(
                          title:Text('Error'),
                          content: Text("please fill the credientals correctly"),
                          actions: [
                            TextButton(onPressed: (){
                              Navigator.pop(context);
                            }, child: Text('ok'))
                          ],
                        );

                      });
                    }
                  }, child: const Text('Submit',style: TextStyle(color: Colors.black),),)
                ],
              )
            )
          ),
                ),
        ),)
    );
  }
}
