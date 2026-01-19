//AI aiisiated ใช้ช่วยดัดแปลงไฟล์จากงาน lab เก่าๆ

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class Task {
  String id;
  String title;
  String priority;
  DateTime dueDate;
  bool isCompleted;

  Task({
    required this.id,
    required this.title,
    required this.priority,
    required this.dueDate,
    this.isCompleted = false,
  });
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void toggleTheme(bool isDark) {
    setState(() {
      _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student Planner',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(brightness: Brightness.dark, useMaterial3: true),
      themeMode: _themeMode,
      home: const OnboardingScreen(),
      routes: {
        '/home': (context) => HomeScreen(
          toggleTheme: toggleTheme,
          isDark: _themeMode == ThemeMode.dark,
        ),
      },
    );
  }
}

// --- ONBOARDING SCREEN (PC Navigable) ---
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (int page) => setState(() => _currentPage = page),
            children: const [
              OnboardingPage(
                title: "Welcome",
                description: "Manage your exam tasks easily.",
                color: Colors.blue,
              ),
              OnboardingPage(
                title: "Prioritize",
                description: "Drag and drop to sort your tasks.",
                color: Colors.green,
              ),
              OnboardingPage(
                title: "Get Started",
                description: "Click Next to finish.",
                color: Colors.purple,
              ),
            ],
          ),
          Positioned(
            bottom: 50,
            left: 20,
            right: 20,
            child: _currentPage == 2
                ? Center(
                    child: AnimatedButton(
                      onPressed: () =>
                          Navigator.pushReplacementNamed(context, '/home'),
                      text: "Start Planning",
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Back Button
                      _currentPage > 0
                          ? TextButton(
                              onPressed: () {
                                _controller.previousPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                );
                              },
                              child: const Text(
                                "Back",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            )
                          : const SizedBox(width: 60),
                      // Next Button
                      ElevatedButton.icon(
                        onPressed: () {
                          _controller.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                        ),
                        icon: const Icon(Icons.arrow_forward),
                        label: const Text("Next"),
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final String title;
  final String description;
  final Color color;

  const OnboardingPage({
    super.key,
    required this.title,
    required this.description,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            description,
            style: const TextStyle(fontSize: 18, color: Colors.white70),
          ),
        ],
      ),
    );
  }
}

// --- NEW SETTINGS SCREEN ---
class SettingsScreen extends StatelessWidget {
  final Function(bool) toggleTheme;
  final bool isDark;

  const SettingsScreen({
    super.key,
    required this.toggleTheme,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Settings")),
      body: ListView(
        children: [
          ListTile(
            title: const Text("Dark Mode"),
            subtitle: const Text("Enable dark theme for the app"),
            trailing: Switch(value: isDark, onChanged: toggleTheme),
          ),
          const Divider(),
          ListTile(
            title: const Text("About"),
            subtitle: const Text("Student Planner v1.0"),
            leading: const Icon(Icons.info_outline),
            onTap: () {
              // Info logic could go here
            },
          ),
        ],
      ),
    );
  }
}

// --- HOME SCREEN ---
class HomeScreen extends StatefulWidget {
  final Function(bool) toggleTheme;
  final bool isDark;

  const HomeScreen({
    super.key,
    required this.toggleTheme,
    required this.isDark,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Task> tasks = [
    Task(
      id: '1',
      title: 'Flutter Exam',
      priority: 'High',
      dueDate: DateTime.now().add(const Duration(days: 1)),
    ),
    Task(
      id: '2',
      title: 'Math Homework',
      priority: 'Medium',
      dueDate: DateTime.now().add(const Duration(days: 2)),
    ),
    Task(
      id: '3',
      title: 'Buy Coffee',
      priority: 'Low',
      dueDate: DateTime.now(),
    ),
  ];

  String _searchQuery = "";

  List<Task> get filteredTasks {
    if (_searchQuery.isEmpty) return tasks;
    return tasks
        .where(
          (t) => t.title.toLowerCase().contains(_searchQuery.toLowerCase()),
        )
        .toList();
  }

  void _addTask(Task task) {
    setState(() {
      tasks.add(task);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Tasks"),
        actions: [
          // Cog Wheel Icon for Settings
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SettingsScreen(
                    toggleTheme: widget.toggleTheme,
                    isDark: widget.isDark,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                labelText: "Search Tasks...",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (val) => setState(() => _searchQuery = val),
            ),
          ),
          Expanded(
            child: ReorderableListView(
              onReorder: (oldIndex, newIndex) {
                setState(() {
                  if (newIndex > oldIndex) newIndex -= 1;
                  final Task item = tasks.removeAt(oldIndex);
                  tasks.insert(newIndex, item);
                });
              },
              children: [
                for (int index = 0; index < filteredTasks.length; index++)
                  _buildTaskItem(filteredTasks[index], index),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const TaskFormScreen()),
          );
          if (result != null && result is Task) {
            _addTask(result);
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildTaskItem(Task task, int index) {
    return Dismissible(
      key: ValueKey(task.id),
      background: Container(
        color: Colors.green,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(left: 20),
        child: const Icon(Icons.check, color: Colors.white),
      ),
      secondaryBackground: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.endToStart) {
          return true;
        } else {
          setState(() {
            task.isCompleted = !task.isCompleted;
          });
          return false;
        }
      },
      onDismissed: (direction) {
        setState(() {
          tasks.remove(task);
        });
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("${task.title} deleted")));
      },
      child: Card(
        key: ValueKey(task.id),
        child: ListTile(
          title: Text(
            task.title,
            style: TextStyle(
              decoration: task.isCompleted ? TextDecoration.lineThrough : null,
            ),
          ),
          subtitle: Text(
            "Priority: ${task.priority} | Due: ${task.dueDate.toString().split(' ')[0]}",
          ),
          trailing: const Icon(Icons.drag_handle),
        ),
      ),
    );
  }
}

class TaskFormScreen extends StatefulWidget {
  const TaskFormScreen({super.key});

  @override
  State<TaskFormScreen> createState() => _TaskFormScreenState();
}

class _TaskFormScreenState extends State<TaskFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  String _priority = 'Medium';
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("New Task")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: "Task Title"),
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return 'Please enter a title';
                  return null;
                },
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: _priority,
                items: ['High', 'Medium', 'Low']
                    .map((p) => DropdownMenuItem(value: p, child: Text(p)))
                    .toList(),
                onChanged: (val) => setState(() => _priority = val!),
                decoration: const InputDecoration(labelText: "Priority"),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Text("Due Date: ${_selectedDate.toString().split(' ')[0]}"),
                  const Spacer(),
                  TextButton(
                    onPressed: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: _selectedDate,
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2100),
                      );
                      if (picked != null)
                        setState(() => _selectedDate = picked);
                    },
                    child: const Text("Select Date"),
                  ),
                ],
              ),
              const Spacer(),
              AnimatedButton(
                text: "Save Task",
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final newTask = Task(
                      id: DateTime.now().toString(),
                      title: _titleController.text,
                      priority: _priority,
                      dueDate: _selectedDate,
                    );
                    Navigator.pop(context, newTask);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AnimatedButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;

  const AnimatedButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  State<AnimatedButton> createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) {
        _controller.reverse();
        widget.onPressed();
      },
      onTapCancel: () => _controller.reverse(),
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
          decoration: BoxDecoration(
            color: Colors.blueAccent,
            borderRadius: BorderRadius.circular(30),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Text(
            widget.text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
