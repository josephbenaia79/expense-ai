import 'package:flutter/material.dart';

class AIChatScreen extends StatefulWidget {
  const AIChatScreen({super.key});

  @override
  State<AIChatScreen> createState() => _AIChatScreenState();
}

class _AIChatScreenState extends State<AIChatScreen> {
  final TextEditingController controller = TextEditingController();
  final List<Map<String, String>> messages = [];

  bool loading = false;

  Future<void> sendMessage() async {
    final text = controller.text.trim();
    if (text.isEmpty || loading) return;

    controller.clear();

    setState(() {
      messages.add({"role": "user", "text": text});
      loading = true;
    });

    try {
      // 🔥 SIMULATED SMART FINANCE AI (upgrade point)
      await Future.delayed(const Duration(seconds: 1));

      String reply = _generateSmartReply(text, messages);

      setState(() {
        messages.add({"role": "ai", "text": reply});
      });
    } catch (e) {
      setState(() {
        messages.add({"role": "ai", "text": "Error: $e"});
      });
    }

    setState(() {
      loading = false;
    });
  }

  String _generateSmartReply(String input, List<Map<String, String>> history) {
    input = input.toLowerCase();

    if (input.contains("save")) {
      return "Try setting a 20% monthly savings goal. Automate it if possible.";
    }

    if (input.contains("spend") || input.contains("money")) {
      return "Track daily expenses under categories. Your biggest leak is usually food or transport.";
    }

    if (input.contains("budget")) {
      return "A good budget rule: 50% needs, 30% wants, 20% savings.";
    }

    return "As your finance assistant, I recommend tracking expenses daily and reviewing weekly spending trends.";
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Finance AI Chat"),
        backgroundColor: Colors.deepPurple,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final msg = messages[index];
                final isUser = msg["role"] == "user";

                return Align(
                  alignment:
                      isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color:
                          isUser ? Colors.deepPurple : Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(msg["text"] ?? ""),
                  ),
                );
              },
            ),
          ),

          if (loading)
            const Padding(
              padding: EdgeInsets.all(8),
              child: LinearProgressIndicator(),
            ),

          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: TextField(
                    controller: controller,
                    decoration: const InputDecoration(
                      hintText: "Ask about savings, budgeting, spending...",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.send),
                onPressed: loading ? null : sendMessage,
              )
            ],
          )
        ],
      ),
    );
  }
}