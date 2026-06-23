import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/expense.dart';

class AIService {
  // 🔑 Use Gemini API instead of OpenAI (recommended)
  const String apiKey = "YOUR_API_KEY";

  Future<String> analyzeExpenses(List<Expense> expenses) async {
    try {
      if (expenses.isEmpty) {
        return "No spending data available yet. Add expenses to get insights.";
      }

      final summary = expenses
          .map((e) => "- ${e.title} (${e.category}) : KES ${e.amount}")
          .join("\n");

      final prompt = """
You are a world-class financial AI assistant.

Analyze the user's spending and return:
1. Spending summary
2. Bad spending habits (if any)
3. Savings advice
4. One motivational tip

Keep it short, clear, and practical.

EXPENSE DATA:
$summary
""";

      final response = await http.post(
        Uri.parse(
          "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=$apiKey",
        ),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "contents": [
            {
              "parts": [
                {"text": prompt}
              ]
            }
          ]
        }),
      );

      if (response.statusCode != 200) {
        return "AI Error: ${response.body}";
      }

      final data = jsonDecode(response.body);

      final text = data["candidates"]?[0]?["content"]?["parts"]?[0]?["text"];

      return text ?? "No AI response generated.";
    } catch (e) {
      return "AI Exception: $e";
    }
  }
}