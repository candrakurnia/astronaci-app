import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_astro/common/state_enum.dart';
import 'package:mobile_astro/model/list_user_model.dart';
import 'package:mobile_astro/provider/auth_provider.dart';
import 'package:mobile_astro/provider/list_user_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/HomeScreen';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _searchQuery = '';
  List<Datum> _filteredList = [];

  void _onSearchChanged(String query, List<Datum> originalList) {
    setState(() {
      _searchQuery = query;
      if (query.isEmpty) {
        _filteredList = originalList;
      } else {
        _filteredList = originalList
            .where(
              (user) =>
                  user.username != null &&
                  user.username!.toLowerCase().contains(query.toLowerCase()),
            )
            .toList();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    final listUser = context.read<ListUserProvider>();
    final authProvider = context.read<AuthProvider>();
    Future.microtask(() async => listUser.getListUser(authProvider.token!));
  }

  List<String> sampleData = List.generate(12, (index) => "Item ${index + 1}");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        maxRadius: 26,
                        backgroundImage: NetworkImage(
                          "https://res.cloudinary.com/dotz74j1p/raw/upload/v1716044979/nr7gt66alfhmu9vaxu2u.png",
                        ),
                      ),
                      const SizedBox(width: 12.0),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Welcome, ",
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "Candra Kurnia",
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/ProfileScreen');
                    },
                    icon: Icon(Icons.person),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 6.0,
                  horizontal: 12.0,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: const BorderRadius.all(Radius.circular(12.0)),
                  border: Border.all(width: 1.0, color: Colors.grey[400]!),
                ),
                child: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.search),
                    ),
                    Consumer<ListUserProvider>(
                      builder: (context, provider, child) => Expanded(
                        child: TextFormField(
                          decoration: const InputDecoration.collapsed(
                            filled: true,
                            fillColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            hintText: "Search",
                          ),
                          onChanged: (value) {
                            if (provider.requestState == RequestState.loaded) {
                              _onSearchChanged(
                                value,
                                provider.listUserModel.data ?? [],
                              );
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16.0),
              Consumer<ListUserProvider>(
                builder: (context, value, child) {
                  if (value.requestState == RequestState.loading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (value.requestState == RequestState.loaded) {
                    final dataList = _searchQuery.isEmpty
                        ? value.listUserModel.data ?? []
                        : _filteredList;
                    return Expanded(
                      child: dataList.isEmpty
                          ? const Center(child: Text('No users found'))
                          : ListView.builder(
                              itemCount: dataList.length,
                              itemBuilder: (context, index) {
                                final data = dataList[index];
                                return Card(
                                  margin: const EdgeInsets.symmetric(
                                    vertical: 6.0,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      backgroundColor:
                                          Colors.deepPurple.shade100,
                                      child: Text(
                                        data.username?[0].toUpperCase() ??
                                            "Undefined",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    title: Text(
                                      data.namaLengkap ?? "Undefined",
                                      style: GoogleFonts.poppins(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    subtitle: Text(
                                      data.deskripsi ?? "Undefined",
                                    ),
                                    trailing: const Icon(
                                      Icons.arrow_forward_ios,
                                      size: 16,
                                    ),
                                    onTap: () {
                                      Navigator.pushNamed(
                                        context,
                                        '/DetailScreen',
                                        arguments: data,
                                      );
                                    },
                                  ),
                                );
                              },
                            ),
                    );
                  }
                  return Center(
                    child: Text(
                      value.message,
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
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
