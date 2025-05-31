part of '../../../custom_dropdown.dart';

class _ItemsList<T> extends StatelessWidget {
  final ScrollController scrollController;
  final T? selectedItem;
  final List<T> items, selectedItems;
  final Function(T) onItemSelect;
  final bool excludeSelected;
  final EdgeInsets itemsListPadding, listItemPadding;
  final _ListItemBuilder<T> listItemBuilder;
  final ListItemDecoration? decoration;
  final _DropdownType dropdownType;
  final Future<void> Function()? onRefresh;

  const _ItemsList({
    super.key,
    required this.scrollController,
    required this.selectedItem,
    required this.items,
    required this.onItemSelect,
    required this.excludeSelected,
    required this.itemsListPadding,
    required this.listItemPadding,
    required this.listItemBuilder,
    required this.selectedItems,
    required this.decoration,
    required this.dropdownType,
    this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    if (onRefresh != null) {
      return RefreshIndicator.adaptive(
        onRefresh: onRefresh!,
        child: Scrollbar(
          controller: scrollController,
          child: ListView.builder(
            controller: scrollController,
            shrinkWrap: true,
            padding: itemsListPadding,
            itemCount: items.length,
            itemBuilder: (_, index) {
              final selected = switch (dropdownType) {
                _DropdownType.singleSelect =>
                  !excludeSelected && selectedItem == items[index],
                _DropdownType.multipleSelect =>
                  selectedItems.contains(items[index])
              };
              return Material(
                color: Colors.transparent,
                child: InkWell(
                  splashColor: decoration?.splashColor ??
                      ListItemDecoration._defaultSplashColor,
                  highlightColor: decoration?.highlightColor ??
                      ListItemDecoration._defaultHighlightColor,
                  onTap: () => onItemSelect(items[index]),
                  child: Ink(
                    color: selected
                        ? (decoration?.selectedColor ??
                            ListItemDecoration._defaultSelectedColor)
                        : Colors.transparent,
                    padding: listItemPadding,
                    child: listItemBuilder(
                      context,
                      items[index],
                      selected,
                      () => onItemSelect(items[index]),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      );
    }
    return Scrollbar(
      controller: scrollController,
      child: ListView.builder(
        controller: scrollController,
        shrinkWrap: true,
        padding: itemsListPadding,
        itemCount: items.length,
        itemBuilder: (_, index) {
          final selected = switch (dropdownType) {
            _DropdownType.singleSelect =>
              !excludeSelected && selectedItem == items[index],
            _DropdownType.multipleSelect => selectedItems.contains(items[index])
          };
          return Material(
            color: Colors.transparent,
            child: InkWell(
              splashColor: decoration?.splashColor ??
                  ListItemDecoration._defaultSplashColor,
              highlightColor: decoration?.highlightColor ??
                  ListItemDecoration._defaultHighlightColor,
              onTap: () => onItemSelect(items[index]),
              child: Ink(
                color: selected
                    ? (decoration?.selectedColor ??
                        ListItemDecoration._defaultSelectedColor)
                    : Colors.transparent,
                padding: listItemPadding,
                child: listItemBuilder(
                  context,
                  items[index],
                  selected,
                  () => onItemSelect(items[index]),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
