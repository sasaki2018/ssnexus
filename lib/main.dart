import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(const PortafolioWeb());
}

class PortafolioWeb extends StatelessWidget {
  const PortafolioWeb({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SSNexus',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.cyanAccent,
        scaffoldBackgroundColor: const Color(0xFF0A0E21),
        fontFamily: 'Roboto',
      ),
      home: const PantallaPrincipal(),
    );
  }
}

class PantallaPrincipal extends StatefulWidget {
  const PantallaPrincipal({super.key});

  @override
  State<PantallaPrincipal> createState() => _PantallaPrincipalState();
}

class _PantallaPrincipalState extends State<PantallaPrincipal> {
  late AudioPlayer _reproductorAudio;
  bool _musicaReproduciendo = false;
  bool _haSidoIniciado = false;

  final List<Map<String, dynamic>> datosJuegos = [
    {
      "titulo": "SSWORDS",
      "desc": "Un juego de palabras desafiante con múltiples modos de juego y un sistema de ordenamiento para el registro histórico.",
      "url": "https://www.mediafire.com/file/yggpb7c3j1orw70/sswords.apk/file",
      "ad": false,
      "caratula": "assets/juegos/sswords/caratula.png",
      "tags": ["#Palabras", "#Puzzle", "#Casual"],
      "imagenes": [
        "assets/juegos/sswords/img1.png",
        "assets/juegos/sswords/img2.png",
        "assets/juegos/sswords/img3.png",
        "assets/juegos/sswords/img4.png"
      ]
    },
    {
      "titulo": "PROYECTO JUEGO 2",
      "desc": "Concepto de videojuego en etapa de planificación. Los detalles técnicos y narrativos permanecen clasificados por el momento.",
      "url": "",
      "ad": true,
      "caratula": "assets/caratula_juego2.png",
      "tags": ["#Terror", "#Sigilo", "#Supervivencia"],
      "imagenes": [
        "assets/placeholder_1.png",
        "assets/placeholder_2.png"
      ]
    }
  ];

  final List<Map<String, dynamic>> datosAplicaciones = [
    {
      "titulo": "PROYECTO APP 1",
      "desc": "Herramienta de software en desarrollo. Enfocada en ofrecer soluciones prácticas y optimización para los usuarios.",
      "url": "assets/descargas/app1.apk",
      "ad": false,
      "caratula": "assets/caratula_app1.png",
      "tags": ["#Utilidad", "#Sistema", "#Herramientas"],
      "imagenes": [
        "assets/placeholder_1.png",
        "assets/placeholder_2.png"
      ]
    }
  ];

  final List<Map<String, dynamic>> datosProximos = [
    {
      "titulo": "PROYECTO DESCONOCIDO",
      "desc": "Nueva experiencia en fase de concepto inicial. Los detalles de desarrollo y mecánicas principales permanecen confidenciales.",
      "url": "",
      "ad": false,
      "caratula": "assets/caratula_prox1.png",
      "tags": ["#Clasificado", "#TBA"],
      "imagenes": [
        "assets/placeholder_1.png"
      ]
    }
  ];

  @override
  void initState() {
    super.initState();
    _reproductorAudio = AudioPlayer();
    _reproductorAudio.setReleaseMode(ReleaseMode.loop);
  }

  void _alternarMusica() async {
    try {
      if (_musicaReproduciendo) {
        await _reproductorAudio.pause();
        setState(() {
          _musicaReproduciendo = false;
        });
      } else {
        if (!_haSidoIniciado) {
          await _reproductorAudio.play(AssetSource('background_music.mp3'));
          _haSidoIniciado = true;
        } else {
          await _reproductorAudio.resume();
        }
        setState(() {
          _musicaReproduciendo = true;
        });
      }
    } catch (e) {
      setState(() {
        _musicaReproduciendo = false;
      });
    }
  }

  @override
  void dispose() {
    _reproductorAudio.dispose();
    super.dispose();
  }

  void _navegarACategoria(BuildContext context, String titulo, List<Map<String, dynamic>> proyectos) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PantallaCategoria(titulo: titulo, proyectos: proyectos),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.cyanAccent.withValues(alpha: 0.1),
        elevation: 0,
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.cyanAccent, width: 1),
          borderRadius: BorderRadius.circular(30),
        ),
        onPressed: _alternarMusica,
        child: Icon(
          _musicaReproduciendo ? Icons.music_note : Icons.music_off,
          color: Colors.cyanAccent,
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(top: 60, bottom: 40, left: 20, right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black,
                    border: Border.all(color: Colors.cyanAccent, width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.cyanAccent.withValues(alpha: 0.5),
                        blurRadius: 30,
                        spreadRadius: 5,
                      )
                    ],
                  ),
                  child: Center(
                    child: Text(
                      "SS",
                      style: TextStyle(
                        fontSize: 45,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: -2,
                        shadows: [
                          Shadow(
                            color: Colors.blue.withValues(alpha: 0.8),
                            offset: const Offset(-3, 0),
                            blurRadius: 0,
                          ),
                          Shadow(
                            color: Colors.cyanAccent.withValues(alpha: 0.8),
                            offset: const Offset(3, 0),
                            blurRadius: 0,
                          ),
                          Shadow(
                            color: Colors.blueAccent.withValues(alpha: 0.5),
                            blurRadius: 15,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Text(
                  "SSNexus",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    letterSpacing: 8,
                    shadows: [
                      Shadow(
                        color: Colors.blue.withValues(alpha: 0.8),
                        offset: const Offset(-3, 0),
                        blurRadius: 0,
                      ),
                      Shadow(
                        color: Colors.cyanAccent.withValues(alpha: 0.8),
                        offset: const Offset(3, 0),
                        blurRadius: 0,
                      ),
                      Shadow(
                        color: Colors.blueAccent.withValues(alpha: 0.5),
                        blurRadius: 15,
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Text(
                  "SHADOW SYSTEMS",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.cyanAccent.withValues(alpha: 0.8),
                    letterSpacing: 4,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 60),
                Wrap(
                  spacing: 30,
                  runSpacing: 30,
                  alignment: WrapAlignment.center,
                  children: [
                    _construirBotonCategoria(context, "APLICACIONES", Icons.code, datosAplicaciones),
                    _construirBotonCategoria(context, "JUEGOS", Icons.videogame_asset, datosJuegos),
                    _construirBotonCategoria(context, "PRÓXIMAMENTE...", Icons.lock_clock, datosProximos),
                  ],
                ),
                const SizedBox(height: 80),
                Text(
                  "SHADOW SYSTEMS © 2026",
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.5),
                    fontSize: 12,
                    letterSpacing: 2,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Desarrollado por Leiver Leandro | Sasaki2019",
                  style: TextStyle(
                    color: Colors.cyanAccent.withValues(alpha: 0.4),
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _construirBotonCategoria(BuildContext context, String titulo, IconData icono, List<Map<String, dynamic>> datos) {
    return GestureDetector(
      onTap: () => _navegarACategoria(context, titulo, datos),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
          width: 240,
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.03),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.cyanAccent.withValues(alpha: 0.3), width: 1.5),
            boxShadow: [
              BoxShadow(color: Colors.cyanAccent.withValues(alpha: 0.05), blurRadius: 15, spreadRadius: 1)
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icono, size: 40, color: Colors.cyanAccent),
              const SizedBox(height: 15),
              Text(
                titulo,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 1.5,
                  shadows: [Shadow(color: Colors.cyanAccent, blurRadius: 8)],
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PantallaCategoria extends StatefulWidget {
  final String titulo;
  final List<Map<String, dynamic>> proyectos;

  const PantallaCategoria({super.key, required this.titulo, required this.proyectos});

  @override
  State<PantallaCategoria> createState() => _PantallaCategoriaState();
}

class _PantallaCategoriaState extends State<PantallaCategoria> {
  String _terminoBusqueda = "";
  late TextEditingController _controladorBusqueda;

  @override
  void initState() {
    super.initState();
    _controladorBusqueda = TextEditingController();
  }

  @override
  void dispose() {
    _controladorBusqueda.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> proyectosFiltrados = widget.proyectos
        .where((p) => p['titulo'].toString().toLowerCase().contains(_terminoBusqueda.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A0E21),
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.cyanAccent),
        title: Text(
          widget.titulo,
          style: const TextStyle(color: Colors.cyanAccent, fontWeight: FontWeight.bold, letterSpacing: 3, fontSize: 18),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(color: Colors.cyanAccent.withValues(alpha: 0.2), height: 1.0),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              controller: _controladorBusqueda,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Buscar...",
                hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.5)),
                prefixIcon: const Icon(Icons.search, color: Colors.cyanAccent),
                filled: true,
                fillColor: Colors.white.withValues(alpha: 0.05),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: Colors.cyanAccent.withValues(alpha: 0.5), width: 1),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 15),
              ),
              onChanged: (valor) {
                setState(() {
                  _terminoBusqueda = valor;
                });
              },
            ),
          ),
          Expanded(
            child: proyectosFiltrados.isEmpty
                ? Center(
                    child: Text(
                      "No se encontraron resultados",
                      style: TextStyle(color: Colors.white.withValues(alpha: 0.5), fontSize: 16),
                    ),
                  )
                : GridView.builder(
                    padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 280,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      childAspectRatio: 0.8,
                    ),
                    itemCount: proyectosFiltrados.length,
                    itemBuilder: (context, index) {
                      return _construirTarjetaResumen(context, proyectosFiltrados[index]);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _construirTarjetaResumen(BuildContext context, Map<String, dynamic> proyecto) {
    Color colorPrincipal = proyecto['ad'] ? Colors.pinkAccent : Colors.cyanAccent;
    List<String> tags = List<String>.from(proyecto['tags'] ?? []);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PantallaDetalleProyecto(proyecto: proyecto, colorPrincipal: colorPrincipal)),
        );
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.02),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: colorPrincipal.withValues(alpha: 0.3), width: 1),
            boxShadow: [
              BoxShadow(color: colorPrincipal.withValues(alpha: 0.05), blurRadius: 10, spreadRadius: 1)
            ],
          ),
          clipBehavior: Clip.hardEdge,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  color: Colors.black,
                  child: Image.asset(
                    proyecto['caratula'],
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Icon(Icons.image, size: 60, color: colorPrincipal.withValues(alpha: 0.2)),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        proyecto['titulo'],
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 1,
                          shadows: [Shadow(color: colorPrincipal.withValues(alpha: 0.5), blurRadius: 5)],
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 4,
                        runSpacing: 4,
                        children: tags.map((tag) => Text(
                          tag,
                          style: TextStyle(color: colorPrincipal.withValues(alpha: 0.8), fontSize: 10, fontWeight: FontWeight.bold),
                        )).toList(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PantallaDetalleProyecto extends StatefulWidget {
  final Map<String, dynamic> proyecto;
  final Color colorPrincipal;

  const PantallaDetalleProyecto({super.key, required this.proyecto, required this.colorPrincipal});

  @override
  State<PantallaDetalleProyecto> createState() => _PantallaDetalleProyectoState();
}

class _PantallaDetalleProyectoState extends State<PantallaDetalleProyecto> {
  late PageController _controladorPagina;
  late FocusNode _focusNode;
  int _imagenActual = 0;
  late List<String> _imagenes;

  @override
  void initState() {
    super.initState();
    _controladorPagina = PageController();
    _focusNode = FocusNode();
    _imagenes = List<String>.from(widget.proyecto['imagenes'] ?? []);
  }

  @override
  void dispose() {
    _controladorPagina.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _siguienteImagen() {
    if (_imagenActual < _imagenes.length - 1) {
      _controladorPagina.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    }
  }

  void _anteriorImagen() {
    if (_imagenActual > 0) {
      _controladorPagina.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    }
  }

  Future<void> _abrirEnlace(String urlPath) async {
    if (urlPath.isNotEmpty) {
      final Uri url = Uri.parse(urlPath);
      if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
        throw Exception('Could not launch $urlPath');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: widget.colorPrincipal),
      ),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              height: 250,
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: widget.colorPrincipal.withValues(alpha: 0.3), width: 2)),
              ),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    widget.proyecto['caratula'],
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(color: const Color(0xFF0A0E21)),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, const Color(0xFF0A0E21).withValues(alpha: 0.9), const Color(0xFF0A0E21)],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    left: 20,
                    right: 20,
                    child: Text(
                      widget.proyecto['titulo'],
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        letterSpacing: 2,
                        shadows: [Shadow(color: widget.colorPrincipal, blurRadius: 15)],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 800),
                child: Column(
                  children: [
                    Text(
                      widget.proyecto['desc'],
                      style: const TextStyle(color: Colors.white70, fontSize: 16, height: 1.6),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 40),
                    if (_imagenes.isNotEmpty)
                      Focus(
                        focusNode: _focusNode,
                        autofocus: true,
                        onKeyEvent: (node, event) {
                          if (event is KeyDownEvent) {
                            if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
                              _siguienteImagen();
                              return KeyEventResult.handled;
                            } else if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
                              _anteriorImagen();
                              return KeyEventResult.handled;
                            }
                          }
                          return KeyEventResult.ignored;
                        },
                        child: Container(
                          height: 350,
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.5),
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: widget.colorPrincipal.withValues(alpha: 0.3)),
                            boxShadow: [
                              BoxShadow(color: widget.colorPrincipal.withValues(alpha: 0.05), blurRadius: 10, spreadRadius: 1)
                            ],
                          ),
                          child: Stack(
                            children: [
                              PageView.builder(
                                controller: _controladorPagina,
                                onPageChanged: (index) {
                                  setState(() {
                                    _imagenActual = index;
                                  });
                                },
                                itemCount: _imagenes.length,
                                itemBuilder: (context, index) {
                                   return Image.asset(
                                    _imagenes[index],
                                    fit: BoxFit.contain,
                                    errorBuilder: (context, error, stackTrace) => Center(
                                      child: Icon(Icons.image_not_supported, color: widget.colorPrincipal.withValues(alpha: 0.3), size: 50),
                                    ),
                                  );
                                },
                              ),
                              if (_imagenActual > 0)
                                Positioned(
                                  left: 10,
                                  top: 0,
                                  bottom: 0,
                                  child: Center(
                                    child: IconButton(
                                      icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
                                      color: widget.colorPrincipal,
                                      style: IconButton.styleFrom(backgroundColor: Colors.black45),
                                      onPressed: _anteriorImagen,
                                    ),
                                  ),
                                ),
                              if (_imagenActual < _imagenes.length - 1)
                                Positioned(
                                  right: 10,
                                  top: 0,
                                  bottom: 0,
                                  child: Center(
                                    child: IconButton(
                                      icon: const Icon(Icons.arrow_forward_ios, color: Colors.white),
                                      color: widget.colorPrincipal,
                                      style: IconButton.styleFrom(backgroundColor: Colors.black45),
                                      onPressed: _siguienteImagen,
                                    ),
                                  ),
                                ),
                              Positioned(
                                bottom: 10,
                                left: 0,
                                right: 0,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: List.generate(
                                    _imagenes.length,
                                    (index) => Container(
                                      margin: const EdgeInsets.symmetric(horizontal: 4),
                                      width: _imagenActual == index ? 12 : 8,
                                      height: _imagenActual == index ? 12 : 8,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: _imagenActual == index ? widget.colorPrincipal : Colors.white30,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    const SizedBox(height: 40),
                    GestureDetector(
                      onTap: () => _abrirEnlace(widget.proyecto['url']),
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                          decoration: BoxDecoration(
                            border: Border.all(color: widget.colorPrincipal, width: 2),
                            borderRadius: BorderRadius.circular(30),
                            color: widget.colorPrincipal.withValues(alpha: 0.1),
                            boxShadow: [
                              BoxShadow(color: widget.colorPrincipal.withValues(alpha: 0.1), blurRadius: 15, spreadRadius: 1)
                            ],
                          ),
                          child: Text(
                            widget.proyecto['url'].toString().isEmpty ? "EN DESARROLLO" : "DESCARGAR PROYECTO",
                            style: TextStyle(
                              color: widget.colorPrincipal,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              letterSpacing: 2,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}