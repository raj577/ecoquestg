import '../models/quiz_question.dart';

class QuizData {
  static List<QuizQuestion> getAllQuestions() {
    return [
      // Recycling Questions
      QuizQuestion(
        id: 'recycle_1',
        question: 'Which of these items can be recycled?',
        options: ['Plastic bottle', 'Banana peel', 'Broken glass', 'All of the above'],
        correctAnswerIndex: 0,
        explanation: 'Plastic bottles can be recycled! Banana peels should be composted, and broken glass needs special handling.',
        imagePath: 'assets/images/recycling_items.png',
        category: 'Recycling',
        difficulty: 1,
      ),
      QuizQuestion(
        id: 'recycle_2',
        question: 'What are the 3 Rs of environmental protection?',
        options: ['Read, Run, Rest', 'Reduce, Reuse, Recycle', 'Red, Green, Blue', 'Rain, River, Rock'],
        correctAnswerIndex: 1,
        explanation: 'The 3 Rs are Reduce (use less), Reuse (use again), and Recycle (make into something new)!',
        imagePath: 'assets/images/three_rs.png',
        category: 'Recycling',
        difficulty: 1,
      ),
      
      // Water Conservation Questions
      QuizQuestion(
        id: 'water_1',
        question: 'How can you save water at home?',
        options: ['Take shorter showers', 'Leave the tap running', 'Use more water bottles', 'Wash dishes with hot water only'],
        correctAnswerIndex: 0,
        explanation: 'Taking shorter showers saves lots of water! Every minute counts.',
        imagePath: 'assets/images/water_conservation.png',
        category: 'Water Conservation',
        difficulty: 1,
      ),
      QuizQuestion(
        id: 'water_2',
        question: 'What percentage of Earth is covered by water?',
        options: ['50%', '60%', '70%', '80%'],
        correctAnswerIndex: 2,
        explanation: 'About 70% of Earth is covered by water, but only 3% is fresh water that we can drink!',
        imagePath: 'assets/images/earth_water.png',
        category: 'Water Conservation',
        difficulty: 2,
      ),
      
      // Energy Conservation Questions
      QuizQuestion(
        id: 'energy_1',
        question: 'Which is a renewable energy source?',
        options: ['Coal', 'Solar power', 'Oil', 'Natural gas'],
        correctAnswerIndex: 1,
        explanation: 'Solar power comes from the sun and will never run out! It\'s clean and renewable.',
        imagePath: 'assets/images/solar_panels.png',
        category: 'Energy',
        difficulty: 1,
      ),
      QuizQuestion(
        id: 'energy_2',
        question: 'What should you do when leaving a room?',
        options: ['Leave lights on', 'Turn off the lights', 'Open all windows', 'Turn up the heat'],
        correctAnswerIndex: 1,
        explanation: 'Always turn off lights when leaving a room to save energy and help the environment!',
        imagePath: 'assets/images/light_switch.png',
        category: 'Energy',
        difficulty: 1,
      ),
      
      // Wildlife and Biodiversity Questions
      QuizQuestion(
        id: 'wildlife_1',
        question: 'Which animal is most affected by melting ice caps?',
        options: ['Elephant', 'Polar bear', 'Lion', 'Monkey'],
        correctAnswerIndex: 1,
        explanation: 'Polar bears need ice to hunt for food. When ice melts, they have trouble finding food.',
        imagePath: 'assets/images/polar_bear.png',
        category: 'Wildlife',
        difficulty: 1,
      ),
      QuizQuestion(
        id: 'wildlife_2',
        question: 'What do bees help plants do?',
        options: ['Grow taller', 'Change colors', 'Make seeds (pollination)', 'Drink water'],
        correctAnswerIndex: 2,
        explanation: 'Bees help plants make seeds by carrying pollen from flower to flower. This is called pollination!',
        imagePath: 'assets/images/bee_pollination.png',
        category: 'Wildlife',
        difficulty: 2,
      ),
      
      // Pollution Questions
      QuizQuestion(
        id: 'pollution_1',
        question: 'What causes air pollution?',
        options: ['Car exhaust', 'Factory smoke', 'Burning trash', 'All of the above'],
        correctAnswerIndex: 3,
        explanation: 'All of these things release harmful gases into the air, making it dirty and hard to breathe.',
        imagePath: 'assets/images/air_pollution.png',
        category: 'Pollution',
        difficulty: 2,
      ),
      QuizQuestion(
        id: 'pollution_2',
        question: 'Where should you put your trash?',
        options: ['On the ground', 'In the ocean', 'In a trash bin', 'In the forest'],
        correctAnswerIndex: 2,
        explanation: 'Always put trash in proper bins! Litter hurts animals and makes our world dirty.',
        imagePath: 'assets/images/trash_bin.png',
        category: 'Pollution',
        difficulty: 1,
      ),
      
      // Trees and Plants Questions
      QuizQuestion(
        id: 'trees_1',
        question: 'What do trees give us that we need to breathe?',
        options: ['Carbon dioxide', 'Oxygen', 'Nitrogen', 'Helium'],
        correctAnswerIndex: 1,
        explanation: 'Trees make oxygen that we breathe! They also clean the air by taking in carbon dioxide.',
        imagePath: 'assets/images/tree_oxygen.png',
        category: 'Trees & Plants',
        difficulty: 1,
      ),
      QuizQuestion(
        id: 'trees_2',
        question: 'How can planting trees help the environment?',
        options: ['Clean the air', 'Provide homes for animals', 'Prevent soil erosion', 'All of the above'],
        correctAnswerIndex: 3,
        explanation: 'Trees are amazing! They clean air, give animals homes, and their roots hold soil in place.',
        imagePath: 'assets/images/tree_benefits.png',
        category: 'Trees & Plants',
        difficulty: 2,
      ),
    ];
  }

  static List<QuizQuestion> getQuestionsByCategory(String category) {
    return getAllQuestions().where((q) => q.category == category).toList();
  }

  static List<QuizQuestion> getQuestionsByDifficulty(int difficulty) {
    return getAllQuestions().where((q) => q.difficulty == difficulty).toList();
  }

  static List<String> getCategories() {
    return [
      'Recycling',
      'Water Conservation',
      'Energy',
      'Wildlife',
      'Pollution',
      'Trees & Plants',
    ];
  }
}

