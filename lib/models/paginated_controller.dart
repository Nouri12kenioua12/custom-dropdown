part of '../custom_dropdown.dart';

class PaginatedDropdownController<T> extends ValueNotifier<PaginatedDropdownState<T>> {
  final int pageSize;
  final Future<List<T>> Function(String query, int page) fetchItems;
  
  PaginatedDropdownController({
    required this.pageSize,
    required this.fetchItems,
    List<T> initialItems = const [],
  }) : super(PaginatedDropdownState<T>(
          items: initialItems,
          hasMoreItems: true,
          isLoading: false,
          currentPage: 0,
          error: null,
          query: '',
        ));

  Future<void> loadFirstPage([String query = '']) async {
    value = value.copyWith(
      isLoading: true,
      currentPage: 0,
      query: query,
      error: null,
      items: [],
    );
    
    try {
      final items = await fetchItems(query, 0);
      value = value.copyWith(
        items: items,
        isLoading: false,
        hasMoreItems: items.length >= pageSize,
        currentPage: 0,
      );
    } catch (e) {
      value = value.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<void> loadNextPage() async {
    if (value.isLoading || !value.hasMoreItems) return;
    
    final nextPage = value.currentPage + 1;
    
    value = value.copyWith(isLoading: true);
    
    try {
      final newItems = await fetchItems(value.query, nextPage);
      value = value.copyWith(
        items: [...value.items, ...newItems],
        isLoading: false,
        hasMoreItems: newItems.length >= pageSize,
        currentPage: nextPage,
      );
    } catch (e) {
      value = value.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  void reset() {
    value = PaginatedDropdownState<T>(
      items: [],
      hasMoreItems: true,
      isLoading: false,
      currentPage: 0,
      error: null,
      query: '',
    );
  }
  
  Future<void> search(String query) async {
    if (query == value.query) return;
    await loadFirstPage(query);
  }
}

class PaginatedDropdownState<T> {
  final List<T> items;
  final bool hasMoreItems;
  final bool isLoading;
  final int currentPage;
  final String? error;
  final String query;

  const PaginatedDropdownState({
    required this.items,
    required this.hasMoreItems,
    required this.isLoading,
    required this.currentPage,
    required this.error,
    required this.query,
  });

  PaginatedDropdownState<T> copyWith({
    List<T>? items,
    bool? hasMoreItems,
    bool? isLoading,
    int? currentPage,
    String? error,
    String? query,
  }) {
    return PaginatedDropdownState<T>(
      items: items ?? this.items,
      hasMoreItems: hasMoreItems ?? this.hasMoreItems,
      isLoading: isLoading ?? this.isLoading,
      currentPage: currentPage ?? this.currentPage,
      error: error ?? this.error,
      query: query ?? this.query,
    );
  }
}