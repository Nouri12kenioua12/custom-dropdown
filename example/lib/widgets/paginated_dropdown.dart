import 'dart:developer';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:animated_custom_dropdown_example/models/job.dart';
import 'package:flutter/material.dart';

class PaginatedDropdown extends StatefulWidget {
  const PaginatedDropdown({Key? key}) : super(key: key);

  @override
  State<PaginatedDropdown> createState() => _PaginatedDropdownState();
}

class _PaginatedDropdownState extends State<PaginatedDropdown> {
  // Simulate fetching paginated data
  Future<List<Job>> _fetchPaginatedJobs(String query, int page) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 10000));
    
    // Create a list of jobs based on the page number
    // In a real app, this would be an API call
    final List<Job> allJobs = List.generate(
      50,
      (index) => Job('Job ${index + 1} ${query.isNotEmpty ? "(matched: $query)" : ""}', Icons.work),
    );
    
    // Filter by query if provided
    final filteredJobs = query.isEmpty
        ? allJobs
        : allJobs.where((job) => job.name.contains(query.toLowerCase())).toList();
    
    // Calculate pagination
    final pageSize = 10;
    final startIndex = page * pageSize;
    final endIndex = startIndex + pageSize > filteredJobs.length
        ? filteredJobs.length
        : startIndex + pageSize;
    
    // Return paginated results
    if (startIndex >= filteredJobs.length) {
      return [];
    }
    
    return filteredJobs.sublist(startIndex, endIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Paginated Dropdown',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        ),
        const SizedBox(height: 16),
        CustomDropdown<Job>.paginated(
          hintText: 'Select job role',
          fetchItems: _fetchPaginatedJobs,
          pageSize: 10,
          onChanged: (value) {
            log('changing value to: $value');
          },
        ),
      ],
    );
  }
}