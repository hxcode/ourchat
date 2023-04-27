import 'package:flutter/material.dart';
import 'package:gzx_dropdown_menu/gzx_dropdown_menu.dart';
import 'package:flutter_chat/homepage/person.dart';
import 'package:flutter_chat/model/sortCondition.dart';
import 'package:flutter_chat/util/sqlitedb.dart';

class GZXDropDownMenuWidget extends StatefulWidget {
  GlobalKey<ScaffoldState> scaffoldKey;
  GZXDropDownMenuWidget({required this.scaffoldKey});
  @override
  _GZXDropDownMenuWidgetState createState() => _GZXDropDownMenuWidgetState();
}

class _GZXDropDownMenuWidgetState extends State<GZXDropDownMenuWidget> {
  List<String> _dropDownHeaderItemStrings = ['行业', '城市', '界别', '筛选'];
  List<SortCondition> _industrySortConditions = [];
  List<SortCondition> _citySortConditions = [];
  List<SortCondition> _groupTypeConditions = [];
  late SortCondition _selectIndustrySortCondition;
  late SortCondition _selectCitySortCondition;
  late SortCondition _selectGroupTypeCondition;
  SortCondition _selectCondition =
      SortCondition(name: '', type: '', isSelected: true);
  GZXDropdownMenuController _dropdownMenuController =
      GZXDropdownMenuController();

  GlobalKey _stackKey = GlobalKey();

  String _dropdownMenuChange = '';

  @override
  void initState() {
    super.initState();
    // Create anonymous function:
    () async {
      GlobalDb globalDb;
      globalDb = new GlobalDb();
      await globalDb.initDb();
      _industrySortConditions = await globalDb.querySortCondition('industry');
      _industrySortConditions.insert(
          0, SortCondition(name: '全部', type: 'industry', isSelected: true));
      _selectIndustrySortCondition = _industrySortConditions[0];

      _citySortConditions = await globalDb.querySortCondition('city');
      _citySortConditions.insert(
          0, SortCondition(name: '全部', type: 'city', isSelected: true));
      _selectCitySortCondition = _citySortConditions[0];

      _groupTypeConditions = await globalDb.querySortCondition('groupType');
      _groupTypeConditions.insert(
          0, SortCondition(name: '全部', type: 'groupType', isSelected: true));
      _selectGroupTypeCondition = _groupTypeConditions[0];

      setState(() {
        // Update your UI with the desired changes.
      });
    }();
  }

  void setSelected(List<SortCondition> items, SortCondition selectItem,
      int index, String search) {
    selectItem = items[0];
    _dropDownHeaderItemStrings[index] =
        _selectIndustrySortCondition.name == '全部' ? search : selectItem.name;
    for (SortCondition value in items) {
      value.isSelected = false;
    }
    selectItem.isSelected = true;
  }

  @override
  Widget build(BuildContext context) {
    print('_GZXDropDownMenuWidgetState.build');
    return Stack(
      key: _stackKey,
      children: <Widget>[
        Column(
          children: <Widget>[
//              SizedBox(height: 20,),
            // 下拉菜单头部
            GZXDropDownHeader(
              // 下拉的头部项，目前每一项，只能自定义显示的文字、图标、图标大小修改
              items: [
                GZXDropDownHeaderItem(
                  _dropDownHeaderItemStrings[0],
                  iconData: Icons.keyboard_arrow_down,
                  iconDropDownData: Icons.keyboard_arrow_up,
                ),
                GZXDropDownHeaderItem(
                  _dropDownHeaderItemStrings[1],
                  iconData: Icons.keyboard_arrow_down,
                  iconDropDownData: Icons.keyboard_arrow_up,
                ),
                GZXDropDownHeaderItem(
                  _dropDownHeaderItemStrings[2],
                  // style: TextStyle(color: Colors.green),
                  iconData: Icons.keyboard_arrow_down,
                  iconDropDownData: Icons.keyboard_arrow_up,
                ),
                GZXDropDownHeaderItem(
                  _dropDownHeaderItemStrings[3],
                  iconData: Icons.filter_frames,
                  iconSize: 18,
                ),
              ],
              // GZXDropDownHeader对应第一父级Stack的key
              stackKey: _stackKey,
              // controller用于控制menu的显示或隐藏
              controller: _dropdownMenuController,
              // 当点击头部项的事件，在这里可以进行页面跳转或openEndDrawer
              onItemTap: (index) {
                if (index == 3) {
                  _dropdownMenuController.hide();
                  widget.scaffoldKey.currentState!.openEndDrawer();
                }
              },
              style: TextStyle(color: Color(0xFF666666), fontSize: 14),
//                // 下拉时文字样式
              dropDownStyle: TextStyle(
                fontSize: 14,
                color: Theme.of(context).primaryColor,
              ),
//                // 图标大小
//                iconSize: 20,
//                // 图标颜色
//                iconColor: Color(0xFFafada7),
//                // 下拉时图标颜色
//                iconDropDownColor: Theme.of(context).primaryColor,
            ),
            Expanded(
              child: NbPerson(
                searchValue:
                    _selectCondition.name == '全部' ? '' : _selectCondition.name,
                selectedCondition: _selectCondition.type,
              ),
            ),
          ],
        ),
        // 下拉菜单，注意GZXDropDownMenu目前只能在Stack内，后续有时间会改进，以及支持CustomScrollView和NestedScrollView
        GZXDropDownMenu(
          // controller用于控制menu的显示或隐藏
          controller: _dropdownMenuController,
          // 下拉菜单显示或隐藏动画时长
          animationMilliseconds: 300,
          // 下拉后遮罩颜色
//          maskColor: Theme.of(context).primaryColor.withOpacity(0.5),
//          maskColor: Colors.red.withOpacity(0.5),
          dropdownMenuChanging: (isShow, index) {
            setState(() {
              _dropdownMenuChange = '(正在${isShow ? '显示' : '隐藏'}$index)';
              print(_dropdownMenuChange);
            });
          },
          dropdownMenuChanged: (isShow, index) {
            setState(() {
              _dropdownMenuChange = '(已经${isShow ? '显示' : '隐藏'}$index)';
              print(_dropdownMenuChange);
            });
          },
          // 下拉菜单，高度自定义，你想显示什么就显示什么，完全由你决定，你只需要在选择后调用_dropdownMenuController.hide();即可
          menus: [
            GZXDropdownMenuBuilder(
                dropDownHeight: 40 * 8.0,
                dropDownWidget:
                    _buildConditionListWidget(_industrySortConditions, (value) {
                  _selectIndustrySortCondition = value;
                  _dropDownHeaderItemStrings[0] =
                      _selectIndustrySortCondition.name == '全部'
                          ? '行业'
                          : _selectIndustrySortCondition.name;
                  _dropdownMenuController.hide();
                  setState(() {
                    setSelected(
                        _citySortConditions, _selectCitySortCondition, 1, '城市');
                    setSelected(_groupTypeConditions, _selectGroupTypeCondition,
                        2, '界别');
                    this._selectCondition = _selectIndustrySortCondition;
                  });
                })),
            GZXDropdownMenuBuilder(
                dropDownHeight: 40 * 8.0,
                dropDownWidget:
                    _buildConditionListWidget(_citySortConditions, (value) {
                  _selectCitySortCondition = value;
                  _dropDownHeaderItemStrings[1] =
                      _selectCitySortCondition.name == '全部'
                          ? '城市'
                          : _selectCitySortCondition.name;
                  _dropdownMenuController.hide();
                  setState(() {
                    setSelected(_industrySortConditions,
                        _selectIndustrySortCondition, 0, '行业');
                    setSelected(_groupTypeConditions, _selectGroupTypeCondition,
                        2, '界别');
                    this._selectCondition = _selectCitySortCondition;
                  });
                })),
            GZXDropdownMenuBuilder(
                dropDownHeight: 40.0 * _groupTypeConditions.length,
                dropDownWidget:
                    _buildConditionListWidget(_groupTypeConditions, (value) {
                  _selectGroupTypeCondition = value;
                  _dropDownHeaderItemStrings[2] =
                      _selectGroupTypeCondition.name == '全部'
                          ? '界别'
                          : _selectGroupTypeCondition.name;
                  _dropdownMenuController.hide();
                  setState(() {
                    setSelected(_industrySortConditions,
                        _selectIndustrySortCondition, 0, '行业');
                    setSelected(
                        _citySortConditions, _selectCitySortCondition, 1, '城市');
                    this._selectCondition = _selectGroupTypeCondition;
                  });
                })),
          ],
        ),
      ],
    );
  }

  _buildConditionListWidget(
      items, void itemOnTap(SortCondition sortCondition)) {
    return ListView.separated(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: items.length,
      // item 的个数
      separatorBuilder: (BuildContext context, int index) =>
          Divider(height: 1.0),
      // 添加分割线
      itemBuilder: (BuildContext context, int index) {
        return gestureDetector(items, index, itemOnTap, context);
      },
    );
  }

  GestureDetector gestureDetector(items, int index,
      void itemOnTap(SortCondition sortCondition), BuildContext context) {
    SortCondition goodsSortCondition = items[index];
    return GestureDetector(
      onTap: () {
        for (var value in items) {
          value.isSelected = false;
        }
        goodsSortCondition.isSelected = true;

        itemOnTap(goodsSortCondition);
      },
      child: Container(
        //            color: Colors.blue,
        height: 40,
        child: Row(
          children: <Widget>[
            SizedBox(
              width: 16,
            ),
            Expanded(
              child: Text(
                goodsSortCondition.name,
                style: TextStyle(
                  color: goodsSortCondition.isSelected
                      ? Theme.of(context).primaryColor
                      : Colors.black,
                ),
              ),
            ),
            goodsSortCondition.isSelected
                ? Icon(
                    Icons.check,
                    color: Theme.of(context).primaryColor,
                    size: 16,
                  )
                : SizedBox(),
            SizedBox(
              width: 16,
            ),
          ],
        ),
      ),
    );
  }
}
