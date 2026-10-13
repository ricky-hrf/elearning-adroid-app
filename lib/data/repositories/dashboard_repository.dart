import '../../domain/models/dashboard_model.dart';

class DashboardRepository {
  Future<DashboardModel> getDashboardData() async {
    // Simulasi delay network
    await Future.delayed(const Duration(milliseconds: 500));

    return DashboardModel(
      studentName: 'Ahmad Rizky Pratama',
      className: 'XII IPA 2',
      schoolName: 'SMA Negeri 1 Jakarta',
      stats: DashboardStats(
        totalCourses: 8,
        pendingAssignments: 3,
        averageGrade: 87.5,
        completedAssignments: 24,
      ),
      courses: [
        CourseModel(
          id: '1',
          name: 'Matematika',
          teacher: 'Pak Budi Santoso',
          icon: '📐',
          color: '#4A90D9',
          progress: 75.0,
        ),
        CourseModel(
          id: '2',
          name: 'Bahasa Inggris',
          teacher: 'Ms. Sarah Johnson',
          icon: '📚',
          color: '#50C878',
          progress: 60.0,
        ),
        CourseModel(
          id: '3',
          name: 'Fisika',
          teacher: 'Pak Hendra Wijaya',
          icon: '⚛️',
          color: '#FF6B6B',
          progress: 45.0,
        ),
        CourseModel(
          id: '4',
          name: 'Kimia',
          teacher: 'Bu Ratna Dewi',
          icon: '🧪',
          color: '#9B59B6',
          progress: 80.0,
        ),
        CourseModel(
          id: '5',
          name: 'Biologi',
          teacher: 'Pak Agus Setiawan',
          icon: '🧬',
          color: '#1ABC9C',
          progress: 55.0,
        ),
        CourseModel(
          id: '6',
          name: 'Sejarah',
          teacher: 'Bu Siti Nurhaliza',
          icon: '📜',
          color: '#F39C12',
          progress: 90.0,
        ),
      ],
      upcomingAssignments: [
        AssignmentModel(
          id: '1',
          title: 'Latihan Soal Integral Bab 5',
          courseName: 'Matematika',
          deadline: DateTime.now().add(const Duration(days: 2)),
          status: AssignmentStatus.pending,
        ),
        AssignmentModel(
          id: '2',
          title: 'Essay: The Impact of Technology',
          courseName: 'Bahasa Inggris',
          deadline: DateTime.now().add(const Duration(days: 4)),
          status: AssignmentStatus.pending,
        ),
        AssignmentModel(
          id: '3',
          title: 'Laporan Praktikum Hukum Newton',
          courseName: 'Fisika',
          deadline: DateTime.now().add(const Duration(days: 1)),
          status: AssignmentStatus.submitted,
        ),
      ],
      announcements: [
        AnnouncementModel(
          id: '1',
          title: 'Ujian Tengah Semester',
          content:
          'UTS akan dilaksanakan pada tanggal 20 Oktober 2026. Persiapkan diri dengan baik.',
          date: DateTime.now().subtract(const Duration(days: 1)),
          author: 'Wali Kelas XII IPA 2',
        ),
        AnnouncementModel(
          id: '2',
          title: 'Karya Wisata ke Bandung',
          content:
          'Karya wisata akan dilaksanakan pada akhir bulan Oktober. Silakan daftar melalui portal.',
          date: DateTime.now().subtract(const Duration(days: 3)),
          author: 'Kesiswaan',
        ),
      ],
    );
  }
}