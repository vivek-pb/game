import 'package:flutter/material.dart';
import 'package:game/hive/model/person_model.dart';
import 'package:game/hive/model/product_model.dart';

import 'hive_manager.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  List<PersonModel> users = [];
  List<ProductModel> product = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    fetchPersonData();
    fetchProductData();
  }

  fetchPersonData() async {
    HiveManager.instance.init("person");
    var data = await HiveManager.instance.getData();

    users.clear();
    for (int i = 0; i < data.length; i++) {
      var userMap = data.getAt(i);
      users.add(PersonModel.fromJson(Map.from(userMap)));
    }

    setState(() {
      isLoading = false;
    });
  }

  fetchProductData() async {
    HiveManager.instance.init("product");
    var data = await HiveManager.instance.getData();

    product.clear();
    if (data == null) return;
    for (int i = 0; i < data.length; i++) {
      var userMap = data.getAt(i);
      product.add(ProductModel.fromJson(Map.from(userMap)));
    }

    setState(() {
      isLoading = false;
    });
  }

  late TabController tabController = TabController(length: 2, vsync: this);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Game Testing'),
        bottom: TabBar(
          controller: tabController,
          tabs: const [
            Tab(text: "Husain"),
            Tab(text: "Zahir"),
          ],
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : TabBarView(
              controller: tabController,
              children: [
                SingleChildScrollView(
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    itemCount: users.length,
                    itemBuilder: (BuildContext context, index) {
                      return InkWell(
                        onDoubleTap: () {
                          HiveManager.instance.init("person");
                          HiveManager.instance.deleteAllData();
                          fetchPersonData();
                        },
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddEditPersonScreen(
                                refresh: () {
                                  fetchPersonData();
                                },
                                person: users[index],
                                index: index,
                              ),
                            ),
                          );
                        },
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Text(users[index].name ?? ""),
                                const Spacer(),
                                Text(users[index].age.toString()),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SingleChildScrollView(
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    itemCount: product.length,
                    itemBuilder: (BuildContext context, index) {
                      return InkWell(
                        onDoubleTap: () {
                          HiveManager.instance.init("product");
                          HiveManager.instance.deleteAtIndex(index);
                          fetchProductData();
                        },
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddEditProductScreen(
                                refresh: () {
                                  fetchProductData();
                                },
                                product: product[index],
                                index: index,
                              ),
                            ),
                          );
                        },
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Text(product[index].product ?? ""),
                                const Spacer(),
                                Text(product[index].id.toString()),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
      floatingActionButton: Text("Office e kam krva avo cho rmva ny"),
    );
  }
}

class AddEditPersonScreen extends StatefulWidget {
  final VoidCallback refresh;
  final PersonModel? person;
  final int? index;
  const AddEditPersonScreen(
      {super.key, required this.refresh, this.person, this.index});

  @override
  State<AddEditPersonScreen> createState() => _AddEditPersonScreenState();
}

class _AddEditPersonScreenState extends State<AddEditPersonScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();

  void addUser() {
    HiveManager.instance.addData(
        data: PersonModel(
                name: nameController.text, age: int.parse(ageController.text))
            .toJson());
    widget.refresh();
    Navigator.pop(context);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    HiveManager.instance.init("person");
    if (widget.person != null) {
      nameController.text = widget.person!.name ?? "";
      ageController.text = widget.person!.age.toString();
    }
    setState(() {});
  }

  update() {
    PersonModel person = PersonModel(
        age: int.parse(ageController.text), name: nameController.text);
    HiveManager.instance
        .updateAtIndex(index: widget.index ?? 0, data: person.toJson());
    widget.refresh();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(controller: nameController),
            TextFormField(controller: ageController),
            const SizedBox(
              height: 25,
            ),
            ElevatedButton(
              onPressed: () {
                widget.person != null ? update() : addUser();
              },
              child: widget.person != null
                  ? const Text("Save")
                  : const Text("Add"),
            ),
          ],
        ),
      ),
    );
  }
}

class AddEditProductScreen extends StatefulWidget {
  final VoidCallback refresh;
  final ProductModel? product;
  final int? index;
  const AddEditProductScreen(
      {super.key, required this.refresh, this.product, this.index});

  @override
  State<AddEditProductScreen> createState() => _AddEditProductScreenState();
}

class _AddEditProductScreenState extends State<AddEditProductScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();

  void addUser() {
    HiveManager.instance.addData(
        data: ProductModel(
                product: nameController.text, id: int.parse(ageController.text))
            .toJson());
    widget.refresh();
    Navigator.pop(context);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    HiveManager.instance.init("product");
    if (widget.product != null) {
      nameController.text = widget.product!.product ?? "";
      ageController.text = widget.product!.id.toString();
    }
    setState(() {});
  }

  update() {
    ProductModel product = ProductModel(
        id: int.parse(ageController.text), product: nameController.text);
    HiveManager.instance
        .updateAtIndex(index: widget.index ?? 0, data: product.toJson());
    widget.refresh();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(controller: nameController),
            TextFormField(controller: ageController),
            const SizedBox(
              height: 25,
            ),
            ElevatedButton(
              onPressed: () {
                widget.product != null ? update() : addUser();
              },
              child: widget.product != null
                  ? const Text("Save")
                  : const Text("Add"),
            ),
          ],
        ),
      ),
    );
  }
}
