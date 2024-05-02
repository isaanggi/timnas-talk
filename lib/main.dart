import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp()); // Menjalankan aplikasi Flutter
}

class MyApp extends StatelessWidget {
  const MyApp({super.key}); // Konstruktor untuk kelas MyApp

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> players = [
      // Daftar pemain beserta path gambar
      {"name": "Adi Satryo", "imagePath": "images/adi-satryo.jpg"},
      {"name": "Arkhan Fikri", "imagePath": "images/arkhan-fikri.jpg"},
      {"name": "Bagas Kaffa", "imagePath": "images/bagas-kaffa.png"},
      {"name": "Daffa Fasya", "imagePath": "images/daffa-fasya.jpg"},
      {"name": "Ernando Ari", "imagePath": "images/ernando-ari.jpg"},
      {"name": "Hokky Caraka", "imagePath": "images/hokky-caraka.jpg"},
      {"name": "Ivar Jenner", "imagePath": "images/ivar-jenner.jpg"},
      {"name": "Justin Hubner", "imagePath": "images/justin-hubner.jpg"},
      {"name": "Komang Teguh", "imagePath": "images/komang-teguh.jpg"},
      {
        "name": "Marselino Ferdinan",
        "imagePath": "images/marselino-ferdinan.jpg"
      },
      {"name": "Muhammad Ferrari", "imagePath": "images/muhammad-ferarri.jpg"},
      {"name": "Nathan Tjoe A On", "imagePath": "images/nathan-tjoe-a-on.jpg"},
      {"name": "Pratama Arhan", "imagePath": "images/pratama-arhan.jpg"},
      {"name": "Rafael Struick", "imagePath": "images/rafael-struick.jpg"},
      {"name": "Ramadhan Sananta", "imagePath": "images/ramadhan-sananta.jpg"},
      {"name": "Rio Fahmi", "imagePath": "images/rio-fahmi.png"},
      {"name": "Rizky Ridho", "imagePath": "images/rizky-ridho.jpg"},
      {"name": "Witan", "imagePath": "images/witan.png"},
    ];

    return MaterialApp(
      title: 'TIMNAS TALK', // Judul aplikasi
      theme: ThemeData(
        primarySwatch: Colors.red, // Warna tema utama
      ),
      initialRoute: '/', // Rute awal aplikasi
      routes: {
        '/': (context) => MyHomePage(players: players), // Rute halaman utama
        '/subscribe': (context) =>
            const SubscribePage(), // Rute halaman langganan
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  final List<Map<String, String>>
      players; // Daftar pemain yang akan ditampilkan dalam grid.

  const MyHomePage({super.key, required this.players});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Map<String, String>> subscribedPlayers =
      []; // Menyimpan daftar pemain yang sudah berlangganan.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'TIMNAS TALK', // Judul pada appbar.
          style: TextStyle(color: Colors.white), // Warna teks judul.
        ),
        backgroundColor: Colors.red, // Warna latar belakang appbar.
        iconTheme:
            const IconThemeData(color: Colors.white), // Warna ikon di appbar.
      ),
      drawer: SizedBox(
        width: MediaQuery.of(context).size.width *
            0.5, // Lebar drawer setengah dari lebar layar.
        child: Drawer(
          child: IconTheme(
            data: const IconThemeData(
                color: Colors.white), // Warna ikon di drawer.
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                const DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.red, // Warna latar belakang header drawer.
                  ),
                  child: Text(
                    'Menu', // Judul header drawer.
                    style: TextStyle(
                      color: Colors.white, // Warna teks header drawer.
                      fontSize: 24,
                    ),
                  ),
                ),
                ListTile(
                  title: const Text('Home'), // Opsi menu Home.
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/');
                  },
                  leading: const Icon(Icons.home), // Icon menu Home.
                ),
                ListTile(
                  title: const Text('Subscription'), // Opsi menu Subscription.
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/subscribe',
                        arguments: {'subscribedPlayers': subscribedPlayers});
                  },
                  leading: const Icon(
                      Icons.subscriptions), // Icon menu Subscription.
                ),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Click the images to begin subscribe 😊', // Pesan untuk subs.
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
          ),
          const Divider(), // Garis pemisah antara pesan dan grid pemain.
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, // Jumlah kolom dalam grid.
                crossAxisSpacing: 10.0, // Jarak antar kolom.
                mainAxisSpacing: 10.0, // Jarak antar baris.
              ),
              padding: const EdgeInsets.only(top: 8.0),
              itemCount: widget.players.length, // Jumlah pemain dalam grid.
              itemBuilder: (context, index) {
                final player = widget.players[index];
                return GestureDetector(
                  onTap: () {
                    _showSubscriptionDialog(context, player);
                  },
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.red, width: 2.0),
                        ),
                        child: ClipOval(
                          child: Image.asset(
                            player["imagePath"]!, // Path gambar pemain.
                            fit: BoxFit.cover,
                            width: 100, // Lebar gambar.
                            height: 100, // Tinggi gambar.
                          ),
                        ),
                      ),
                      const SizedBox(
                          height:
                              5), // Spasi antara gambar dan teks nama pemain.
                      Text(
                        player["name"]!, // Nama pemain.
                        textAlign: TextAlign.center, // Teks rata tengah.
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showSubscriptionDialog(
      BuildContext context, Map<String, String> player) {
    // Periksa apakah pemain sudah berlangganan
    if (subscribedPlayers.contains(player)) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Already Subscribed"),
            content: const Text("You have subscribed."),
            actions: <Widget>[
              TextButton(
                child: const Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } else {
      // Jika belum berlangganan, tampilkan dialog berlangganan
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Subscribe to ${player["name"]}?"),
            content: const Text("Click Yes to begin Subscribe."),
            actions: <Widget>[
              TextButton(
                child: const Text("No"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text("Yes"),
                onPressed: () {
                  setState(() {
                    subscribedPlayers.add(player);
                  });
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }
}

class SubscribePage extends StatelessWidget {
  const SubscribePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Mendapatkan argumen rute
    final Map<String, List<Map<String, String>>> args = ModalRoute.of(context)
        ?.settings
        .arguments as Map<String, List<Map<String, String>>>;

    // Mengambil daftar pemain yang sudah berlangganan atau menggunakan daftar kosong jika tidak ada
    final List<Map<String, String>> subscribedPlayers =
        args['subscribedPlayers'] ?? [];

    if (subscribedPlayers.isNotEmpty) {
      // Jika ada pemain yang sudah berlangganan, tampilkan daftar mereka
      return Scaffold(
        appBar: AppBar(
          title: const Text('Subscription'), // Judul pada appbar
        ),
        body: ListView.builder(
          itemCount: subscribedPlayers.length,
          itemBuilder: (context, index) {
            final player = subscribedPlayers[index];
            return ListTile(
              leading: Image.asset(
                player["imagePath"]!, // Path gambar pemain
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
              title: Text(player["name"]!), // Nama pemain
            );
          },
        ),
      );
    } else {
      // Jika tidak ada pemain yang berlangganan, tampilkan pesan
      return Scaffold(
        appBar: AppBar(
          title: const Text('Subscription'), // Judul pada appbar
        ),
        body: const Center(
          child: Text(
            'You have no subscription.', // Pesan jika tidak ada berlangganan
            style: TextStyle(fontSize: 20),
          ),
        ),
      );
    }
  }
}
