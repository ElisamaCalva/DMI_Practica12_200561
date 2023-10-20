import 'package:flutter/material.dart';
import 'package:movieapp_200561/common/HttpHandler.dart';
import 'package:movieapp_200561/media_list.dart';
import 'package:movieapp_200561/common/MediaProvider.dart';
import 'package:movieapp_200561/model/Media.dart';

class Home extends StatefulWidget {
  const Home(
      {super.key});
  @override
  State<Home> createState() =>
      _HomeState();
}

class _HomeState extends State<Home> {

  @override
  void initState() {
    _pageController = new PageController();
    super.initState();
  }

  @override
  void dispose() {
    _pageController?.dispose();
    super.dispose();
  }

  final MediaProvider movieProvider = new MediaPrvider();
  final MediaProvider showProvider = new ShowProvider();
  PageController? _pageController;
  int _page = 0;

  MediaType mediaType = MediaType.movie;
  // Estilo de fuente personalizado
  final TextStyle customTextStyle = TextStyle(
    fontFamily: 'si',
    fontSize: 16.0,
    fontWeight: FontWeight
        .bold,
  );

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("MovieApp-200561"),
        titleTextStyle: TextStyle(fontFamily: 'si'),
        backgroundColor: Color.fromARGB(255, 0, 60, 255),
        actions: <Widget>[
          new IconButton(
            icon: new Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: () {
            },
          ),
        ],
      ),
      drawer: new Drawer(
        child: new ListView(children: <Widget>[
          new DrawerHeader(
            child: Center(),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/img/zelda.jpg'), fit: BoxFit.cover)),
                    
          ),
          new ListTile(
            title: new Text(
              "Peliculas",
              style: TextStyle(fontFamily: 'si'),
            ),
            selected: mediaType == MediaType.movie,
            trailing: new Icon(Icons.local_movies), // Icono de películas
            onTap: () {
              _changeMediaType(MediaType.movie);
              Navigator.of(context).pop();
            }, // Icono de películas
          ),
          // Separador en el menú
          new Divider(
            height: 5.0,
          ),
          // Elemento del menú "Television"
          new ListTile(
            title: new Text(
              "Television",
              style: TextStyle(fontFamily: 'si'), // Aplica el estilo de fuente personalizado
            ),
            trailing: new Icon(
                Icons.live_tv), // Icono de televisión, // Icono de películas
            onTap: () {
              _changeMediaType(MediaType.show);
              Navigator.of(context).pop();
            }, // Icono de películas
          ),
          // Separador en el menú
          new Divider(
            height: 5.0,
          ),
          // Elemento del menú "Cerrar"
          new ListTile(
            title: new Text(
              "Cerrar",
              style: TextStyle(fontFamily: 'si'), // Aplica el estilo de fuente personalizado
            ),
            trailing: new Icon(Icons.exit_to_app), // Icono de televisión
            // Icono de televisión
            onTap: () => Navigator.of(context)
                .pop(), // Cierra el menú al tocar este elemento
          ),
        ]),
      ),
      body: PageView(
        children: _getMediaList(),
        controller: _pageController,
        onPageChanged: (int index) {
          setState(() {
            _page = index;
          });
        },
      ),
      bottomNavigationBar: new BottomNavigationBar(
        // Barra de navegación inferior (BottomNavigationBar) con iconos y etiquetas
        items: _obtenerIconos(),
        onTap: _navigationTapped,
        currentIndex: _page,
      ),
    );
  }

  // Método para obtener los elementos de la barra de navegación inferior
  List<BottomNavigationBarItem> _obtenerIconos() {
    return mediaType == MediaType.movie? [
      new BottomNavigationBarItem(
        icon: new Icon(Icons.thumb_up), // Icono de pulgar hacia arriba
        label: ("Populares"), // Etiqueta para la opción "populares"
      ),
      new BottomNavigationBarItem(
        icon: new Icon(Icons.update), // Icono de actualización
        label: ("Proximamente"), // Etiqueta para la opción "Proximamente"
      ),
      new BottomNavigationBarItem(
        icon: new Icon(Icons.star), // Icono de estrella
        label: ("Mejor valorados"), // Etiqueta para la opción "Mejor valorados"
      )
      ]:
      [
      new BottomNavigationBarItem(
        icon: new Icon(Icons.thumb_up), // Icono de pulgar hacia arriba
        label: ("Populares"), // Etiqueta para la opción "populares"
      ),
      new BottomNavigationBarItem(
        icon: new Icon(Icons.update), // Icono de actualización
        label: ("En el Aire") // Etiqueta para la opción "Proximamente"
      ),
      new BottomNavigationBarItem(
        icon: new Icon(Icons.star), // Icono de estrella
        label: ("Mejor valorados"), // Etiqueta para la opción "Mejor valorados"
      ),
    ];
  }

  void _changeMediaType(MediaType type) {
    if (mediaType != type) {
      setState(() {
        mediaType = type;
      });
    }
  }

  List<Widget> _getMediaList() {
    return (mediaType == MediaType.movie)
        ? <Widget>[
            new MediaList(movieProvider, "popular"),
            new MediaList(movieProvider, "upcoming"),
            new MediaList(movieProvider, "top_rated"),
          ]
        : <Widget>[
            new MediaList(showProvider, "popular"),
            new MediaList(showProvider, "on_the_air"),
            new MediaList(showProvider, "top_rated"),
          ];
  }

  void _navigationTapped(int page) {
    _pageController?.animateToPage(page,
        duration: const Duration(milliseconds: 500), curve: Curves.ease);
  }
}
