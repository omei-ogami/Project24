import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:textfield_tags/textfield_tags.dart';
import 'package:project_24/services/navigation.dart';
import 'package:provider/provider.dart';
import 'package:flutter_tags_x/flutter_tags_x.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:project_24/view_models/activity_vm.dart';
import 'package:project_24/models/activity.dart';
// import 'package:location_picker_flutter_map/location_picker_flutter_map.dart';

class CreateActivity extends StatefulWidget {
  const CreateActivity({super.key});

  @override
  State<CreateActivity> createState() => _CreateActivityState();
}

class _CreateActivityState extends State<CreateActivity> {
  final _formKey = GlobalKey<FormState>();
  String _enteredTitle = '';
  String _enteredCategory = '';
  String _enteredIntro = '';
  String _enteredTime = '';
  String _enteredLocation = '';
  int _enteredCapacity = 0;
  List<String> _tags = [];

  // final _stringTagController = StringTagController();
  final GlobalKey<TagsState> _tagStateKey = GlobalKey<TagsState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: AppBar(
        title: const Text('Create activity', style: TextStyle(fontSize: 30),),
        actions: [
          IconButton(
            icon: const Icon(Icons.keyboard_return),
            onPressed: () =>
              Provider.of<NavigationService>(context, listen: false)
                .backActivitiesOnInfo(),
              // const SizedBox.shrink()
          ),
        ],
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          //controller: scrollController,
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 400),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFormField(
                        key: const ValueKey('title'),
                        decoration: const InputDecoration(
                          hintText: 'Give it an attracting activity title',
                          hintStyle: TextStyle(fontSize: 20),
                        ),
                        keyboardType: TextInputType.text,
                        maxLines: null,
                        autocorrect: false,
                        style: const TextStyle(fontSize: 24),
                        textCapitalization: TextCapitalization.none,
                        maxLength: 30,
                        validator: (value) {
                          if (value == null ||
                              value.trim().isEmpty) {
                            return 'Please enter a valid title.';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _enteredTitle = value!;
                        },
                      ),
                      const SizedBox(height: 10,),
                      DropdownMenu(
                        label: const Text('Categories'),
                        width: 160,
                        onSelected: (categories){
                          if(categories != null){
                            setState((){
                              _enteredCategory = categories;
                            });
                          }
                        },
                        dropdownMenuEntries: const <DropdownMenuEntry<String>>[
                          DropdownMenuEntry(value: 'c1', label: 'Music'),
                          DropdownMenuEntry(value: 'c2', label: 'Game'),
                          DropdownMenuEntry(value: 'c3', label: 'Sport'),
                          DropdownMenuEntry(value: 'c4', label: 'Food'),
                          DropdownMenuEntry(value: 'c5', label: 'Movie'),
                          DropdownMenuEntry(value: 'c6', label: 'Travel'),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Tags(
                        key:_tagStateKey,
                        textField: TagsTextField(
                          textStyle: const TextStyle(fontSize: 16),
                          constraintSuggestion: false,
                          //width: double.infinity, padding: EdgeInsets.symmetric(horizontal: 10),
                          onSubmitted: (String str) {
                            setState(() {                     
                              _tags.add(str);
                            });
                          },
                        ),
                        itemCount: _tags.length,
                        itemBuilder: (int index){          
                          final item = _tags[index];
                          return ItemTags(
                            key: Key(index.toString()),
                            index: index,
                            title: item,
                            //active: item.active,
                            //customData: item.customData,
                            textStyle: const TextStyle( fontSize: 16),
                            combine: ItemTagsCombine.withTextBefore,
                            removeButton: ItemTagsRemoveButton(
                              onRemoved: (){
                                  setState(() {
                                      _tags.removeAt(index);
                                  });
                                  return true;
                              },
                            ),
                            // onPressed: (item) => print(item),
                            // onLongPressed: (item) => print(item),
                          );
                        },
                      ),
                      // TextField(
                      //   decoration: InputDecoration(
                      //     labelText: 'Add a tag',
                      //     border: OutlineInputBorder(),
                      //   ),
                      //   onSubmitted: (String value) {
                      //     if (value.isNotEmpty) {
                      //       _addTag(value);
                      //     }
                      //   },
                      // ),
                      // SizedBox(height: 20),
                      // Tags(
                      //   key: _tagStateKey,
                      //   itemCount: _tags.length,
                      //   itemBuilder: (int index) {
                      //     final String tag = _tags[index];
                      //     return ItemTags(
                      //       index: index,
                      //       title: tag,
                      //       customData: tag,
                      //       combine: ItemTagsCombine.withTextBefore,
                      //       onPressed: (Item item) => print(item),
                      //       onLongPressed: (Item item) => print(item),
                      //       removeButton: ItemTagsRemoveButton(
                      //         onRemoved: () {
                      //           _removeTag(tag);
                      //           return true;
                      //         },
                      //       ),
                      //     );
                      //   },
                      // ),
                      const SizedBox(height: 20),
                      TextFormField(
                        key: const ValueKey('intro'),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          hintText: 'Write an interesting intro',
                          // labelStyle: ,
                          // labelText: 'Activity introduction'
                        ),
                        minLines: 5,
                        maxLength: 500,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        validator: (value) {
                          if (value == null ||
                              value.trim().isEmpty) {
                            return 'Please enter a valid intro.';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _enteredIntro = value!;
                        },
                      ),
                      DateTimePicker(
                        type: DateTimePickerType.dateTimeSeparate,
                        dateMask: 'd MMM, yyyy',
                        initialValue: DateTime.now().toString(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                        icon: const Icon(Icons.event),
                        dateLabelText: 'Date',
                        timeLabelText: "Time",
                        selectableDayPredicate: (date) => date.isAfter(DateTime.now().subtract(Duration(days: 1))),
                        onSaved: (value) {
                          _enteredTime = value!;
                        },
                      ),
                      // FlutterLocationPicker(
                      //   initPosition: LatLong(23, 89),
                      //   selectLocationButtonStyle: ButtonStyle(
                      //     backgroundColor: WidgetStateProperty.all(Colors.blue[400]),
                      //   ),
                      //   //selectedLocationButtonTextstyle: const TextStyle(fontSize: 18),
                      //   selectLocationButtonText: 'Set Current Location',
                      //   //selectLocationButtonLeadingIcon: const Icon(Icons.check),
                      //   initZoom: 11,
                      //   minZoomLevel: 5,
                      //   maxZoomLevel: 16,
                      //   trackMyPosition: true,
                      //   onError: (e) => print(e),
                      //   onPicked: (pickedData) {
                      //     print(pickedData.latLong.latitude);
                      //     print(pickedData.latLong.longitude);
                      //     print(pickedData.address);
                      //     //print(pickedData.addressData['country']);
                      //   },
                      // ),
                      // FlutterLocationPicker(
                      //   initZoom: 11,
                      //   minZoomLevel: 5,
                      //   maxZoomLevel: 16,
                      //   trackMyPosition: true,
                      //   onPicked: (pickedData) {
                      //   }
                      // ),
                      const SizedBox(height: 10),
                      TextFormField(
                        key: const ValueKey('location'),
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.location_on),
                          hintText: 'Enter the location'
                        ),
                        validator: (value) {
                          if (value == null ||
                              value.trim().isEmpty) {
                            return 'Please enter a valid location.';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _enteredLocation = value!;
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        key: const ValueKey('capacity'),
                        decoration: const InputDecoration(
                          hintText: 'Enter the desired number of people to join',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                        maxLines: null,
                        autocorrect: false,
                        //style: const TextStyle(fontSize: 24),
                        textCapitalization: TextCapitalization.none,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        validator: (value) {
                          if (value == null ||
                              value.trim().isEmpty) {
                            return 'Please enter a valid number.';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _enteredCapacity = int.parse(value!);
                        },
                      ),
                      const SizedBox(height: 30),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          TextButton(
                            style: ButtonStyle(backgroundColor: WidgetStateProperty.all(Colors.green[400])),
                            onPressed: () =>
                              setState(() {
                                if(_tags.isEmpty) _tags = ['No tags'];
                                if(_enteredCategory.isEmpty){
                                  showDialog( 
                                    context: context,
                                    builder: (BuildContext context) => AlertDialog(
                                      title: const Text("You missed something!"),
                                      content: const Text("Catagory is not yet selected."),
                                      actions: [
                                        TextButton(child: const Text("Confirm"), onPressed: () {Navigator.of(context).pop();},),
                                      ],
                                      elevation: 24,
                                    ),
                                  );
                                }
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();
                                  final viewModel = Provider.of<ActivityViewModel>(context, listen: false);
                                  final newActivity = Activity(
                                    category: _enteredCategory, 
                                    title: _enteredTitle, 
                                    location: _enteredLocation, 
                                    tags: _tags, 
                                    intro: _enteredIntro, 
                                    time: _enteredTime, 
                                    capacity: _enteredCapacity, 
                                    people: 1, 
                                    organizer: 'organizer', 
                                    attendance: ['attendance']
                                  );
                                  viewModel.addActivity(newActivity);
                                  Provider.of<NavigationService>(context, listen: false)
                                    .goActivitieOnCreatePage();
                                  /*
                                  Send these to firebase:
                                  String _enteredTitle
                                  String _enteredCategory
                                  String _enteredIntro
                                  String _enteredTime
                                  String _enteredLocation
                                  int _enteredCapacity
                                  List<String> _tags
                                  */
                                }
                              }
                            ),
                            child: const Text('Create activity',
                                              style: TextStyle(fontSize: 24, color: Colors.white))
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                    ]
                  )
                )
              )
            ]
          )
        )
      )
    );
  }
}
