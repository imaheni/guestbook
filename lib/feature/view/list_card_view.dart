import 'package:bukutamu/feature/controller/list_card_controller.dart';
import 'package:flutter/material.dart';

class ListCardsView extends StatefulWidget {
  const ListCardsView({super.key});

  @override
  State<ListCardsView> createState() => _ListCardsViewState();
}

class _ListCardsViewState extends State<ListCardsView> {
  late ListCardController _controller;

  @override
  void initState() {
    // TODO: implement initState
    _controller = ListCardController(initState: () => setState(() {}));
    _controller.getGuestsAll();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Daftar Tamu"),
        actions: const [],
        
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              ListView.builder(
                itemCount: _controller.dataGuets.length,
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                clipBehavior: Clip.none,
                itemBuilder: (context, index) {
                  var item = _controller.dataGuets[index];
                  return Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Container(
                      padding: const EdgeInsets.all(12.0),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x19000000),
                            blurRadius: 24,
                            offset: Offset(0, 11),
                          ),
                        ],
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            8.0,
                          ),
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 96,
                            height: 96,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                  "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png",
                                ),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(
                                  8.0,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 12.0,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item['name'] ?? "",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(
                                  height: 6.0,
                                ),
                                Text(
                                  item['institution'] ?? "",
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item['recipient'] ?? "",
                                      style: TextStyle(
                                        fontSize: 14.0,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                    const SizedBox(
                                    width: 10.0,
                                    ),
                                    Text(
                                      item['phone'] ?? "",
                                      style: TextStyle(
                                        fontSize: 14.0,
                                        color: Colors.grey[600],
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 24.0,
                                ),
                                Row(
                                  children: [
                                    InkWell(
                                      onTap: () {},
                                      child: CircleAvatar(
                                        radius: 16.0,
                                        backgroundColor: Colors.grey[200],
                                        child: const Icon(
                                          Icons.delete_outline,
                                          color: Colors.grey,
                                          size: 16.0,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
