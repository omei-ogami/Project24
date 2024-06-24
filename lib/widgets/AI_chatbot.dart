import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:project_24/view_models/all_messages_vm.dart';
import 'package:provider/provider.dart';

final ValueNotifier<String> valueNotifier = ValueNotifier<String>('');

class SuggestionGenerationService extends StatefulWidget {
  const SuggestionGenerationService({super.key});

  static const String _apiKey =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiYWJiOTRjZTEtMGVjMy00OGE4LWIxOWUtOThjYjhiNjUwMGQyIiwidHlwZSI6ImFwaV90b2tlbiJ9.8hyoRFnHBr7jrElWpfk-ENNaCCKYc47tpEvkoeH-nqM'; // FIXME: Replace with your API key
  static const String _url = 'https://api.edenai.run/v2/text/generation';

  Future<String> generateSuggestion(String prompt) async {
    var url = Uri.parse(_url);
    var response = await http.post(url,
        headers: {
          "Authorization": "Bearer $_apiKey",
          'accept': 'application/json',
          'content-type': 'application/json'
        },
        body: json.encode({
          "providers": "openai",
          "text": prompt,
          "temperature": 0.2,
          "max_tokens": 250,
        }));
    String reply = response.body;
    Map<String, dynamic> valueMap = json.decode(reply);

    // print(valueMap['openai']['generated_text']);

    return valueMap['openai']['generated_text'];
  }

  @override
  State<SuggestionGenerationService> createState() {
    return _SuggestionGenerationState();
  }
}

class _SuggestionGenerationState extends State<SuggestionGenerationService> {
  //final GlobalKey<TagsState> _tagStateKey = GlobalKey<TagsState>();
  bool _suggestionIsReady = true;
  String? _generatedSuggestion;

  @override
  Widget build(BuildContext context) {
    final allMessagesViewModel = Provider.of<AllMessagesViewModel>(context);
    final messages = allMessagesViewModel.messages;

    return Column(children: [
      const SizedBox(height: 10),
      Row(
        children: [
          const SizedBox(width: 10),
          TextButton(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Colors.blue[200]),
              ),
              child: _suggestionIsReady
                  ? const Text("Press to generate chat suggestion",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontStyle: FontStyle.italic))
                  : const Text("Generating suggestion ... ...",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontStyle: FontStyle.italic)),
              onPressed: () async {
                String prompt =
                    "You are in an activity group chat, please give out a ice-breaking or engaging message to the group as if you are one of the group members. The following are the recent sent messages: ";
                // print(messages.length);
                // print(messages[0].text);
                // print(messages[1].text);
                // print(messages[2].text);
                // messages.forEach(print);
                for (int i = 0;
                    i < (messages.length > 6 ? 6 : messages.length);
                    i++) {
                  // var messageIterrator = messages.iterator;
                  // prompt = prompt + "\"" + messageIterrator.current.text + "\"" + " , ";
                  // messageIterrator.moveNext();
                  prompt = prompt + "\"" + messages[i].text + "\"" + " , ";
                }
                print("prompt : $prompt");
                setState(() {
                  _suggestionIsReady = false;
                  _generatedSuggestion = null;
                });
                var generatedSuggestion =
                    await const SuggestionGenerationService()
                        .generateSuggestion(prompt);
                generatedSuggestion =
                    generatedSuggestion.replaceAll(RegExp(r'[\t\n]'), '');

                // Remove non-English symbols
                generatedSuggestion = generatedSuggestion.replaceAll(
                    RegExp(r'[^a-zA-Z0-9\s!?.,-]'), '');

                valueNotifier.value = generatedSuggestion;
                print("----value : ${valueNotifier.value} ----");
                setState(() {
                  _suggestionIsReady = true;
                  _generatedSuggestion = generatedSuggestion;
                });
              }),
          const SizedBox(width: 10),
          _suggestionIsReady
              ? const SizedBox.shrink()
              : const CircularProgressIndicator(),
        ],
      ),
      const SizedBox(height: 10),
    ]);
  }
}
