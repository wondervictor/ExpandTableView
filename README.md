## 如何制作一个可以展开的TableView


[SwiftGG 翻译组](https://segmentfault.com/a/1190000004103139)

[ExpandTableView](https://github.com/zhengwenming/ExpandTableView)


**熟悉两个方法：**


UITableView中：section层次：

Section A  
	HeaderView  
	Cells  
	FooterView  
Section B  
	HeaderView  
	Cells  
	FooterView  
...




```
- (void)reloadSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation 
```
> 此方法重新加载UITableView中section内的cells



```
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section

```
> 此方法定制Section的HeaderView。


基本思路：

1. 最开始初始化TableView的时候可以通过在 `- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section` 方法中返回0使得所有cell都不加载出来只保留sections
2. 通过上面的 viewForHeaderViewInSection方法返回自定义的SectionView但要注意设置展开和闭合的动画，上面可以添加一个按钮来监测操作
3. 用户点击展开后，会调用reloadSections方法来加载。每次点击都回加载，还是通过 numberOfRowsInSections来调控cell的显示
4. 通过设置Transfrom来设置箭头动画.







