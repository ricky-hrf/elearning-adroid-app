class DashboardModel {
  final String studentName;
  final String className;
  final String schoolName;
  final List<CourseModel> courses;
  final List<AssignmentModel> upcomingAssignments;
  final List<AnnouncementModel> announcements;
  final DashboardStats stats;

  DashboardModel({
    required this.studentName,
    required this.className,
    required this.schoolName,
    required this.courses,
    required this.upcomingAssignments,
    required this.announcements,
    required this.stats,
  });
}

class CourseModel {
  final String id;
  final String name;
  final String teacher;
  final String icon;
  final String color;
  final double progress;

  CourseModel({
    required this.id,
    required this.name,
    required this.teacher,
    required this.icon,
    required this.color,
    required this.progress,
  });
}

class AssignmentModel {
  final String id;
  final String title;
  final String courseName;
  final DateTime deadline;
  final AssignmentStatus status;

  AssignmentModel({
    required this.id,
    required this.title,
    required this.courseName,
    required this.deadline,
    required this.status,
  });
}

enum AssignmentStatus { pending, submitted, graded }

class AnnouncementModel {
  final String id;
  final String title;
  final String content;
  final DateTime date;
  final String author;

  AnnouncementModel({
    required this.id,
    required this.title,
    required this.content,
    required this.date,
    required this.author,
  });
}

class DashboardStats {
  final int totalCourses;
  final int pendingAssignments;
  final double averageGrade;
  final int completedAssignments;

  DashboardStats({
    required this.totalCourses,
    required this.pendingAssignments,
    required this.averageGrade,
    required this.completedAssignments,
  });
}