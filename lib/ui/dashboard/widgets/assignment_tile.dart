import 'package:flutter/material.dart';
import '../../../domain/models/dashboard_model.dart';

class AssignmentTile extends StatelessWidget {
  final AssignmentModel assignment;
  final String Function(DateTime) formatDate;

  const AssignmentTile({
    super.key,
    required this.assignment,
    required this.formatDate,
  });

  IconData _getStatusIcon(AssignmentStatus status) {
    switch (status) {
      case AssignmentStatus.pending:
        return Icons.pending_actions;
      case AssignmentStatus.submitted:
        return Icons.check_circle_outline;
      case AssignmentStatus.graded:
        return Icons.grade;
    }
  }

  Color _getStatusColor(AssignmentStatus status) {
    switch (status) {
      case AssignmentStatus.pending:
        return Colors.orange;
      case AssignmentStatus.submitted:
        return Colors.blue;
      case AssignmentStatus.graded:
        return Colors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _getStatusColor(assignment.status).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              _getStatusIcon(assignment.status),
              color: _getStatusColor(assignment.status),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  assignment.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  '${assignment.courseName} • ${formatDate(assignment.deadline)}',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: Colors.grey),
        ],
      ),
    );
  }
}