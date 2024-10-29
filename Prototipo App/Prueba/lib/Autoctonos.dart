import 'package:flutter/material.dart';
import 'package:prueba2/HomePage.dart';
import 'package:prueba2/PaginaOferta.dart';
import 'Menu.dart'; // Importa el menú que creaste

class Autoctonos extends StatefulWidget {
  @override
  _AutoctonosState createState() => _AutoctonosState();
}

class _AutoctonosState extends State<Autoctonos> {
  bool _isHomeIconVisible =
      false; // Variable para controlar la visibilidad del ícono

  void _onLogoTap() {
    setState(() {
      _isHomeIconVisible =
          !_isHomeIconVisible; // Cambia la visibilidad del ícono
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () {
                  _onLogoTap(); // Cambia la visibilidad del ícono al hacer clic

                  // Espera a que la animación termine antes de navegar
                  Future.delayed(Duration(milliseconds: 350), () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                      (Route<dynamic> route) => false,
                    );
                  });
                },
                child: AnimatedSwitcher(
                  duration: Duration(milliseconds: 350),
                  transitionBuilder:
                      (Widget child, Animation<double> animation) {
                    return ScaleTransition(scale: animation, child: child);
                  },
                  child: _isHomeIconVisible
                      ? Icon(
                          Icons.home,
                          key: ValueKey('homeIcon'),
                          size: 40,
                          color: Colors.white,
                        )
                      : CircleAvatar(
                          key: ValueKey('logoIcon'),
                          radius: 20,
                          backgroundImage: AssetImage('assets/logo.png'),
                        ),
                ),
              ),
            ),
            SizedBox(width: 10), // Espaciado entre el logo y el título
            Flexible(
              child: Text(
                'Autóctonos',
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.green[700],
        automaticallyImplyLeading: false, // Elimina la flecha de regresar
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context)
                    .openEndDrawer(); // Abre el menú lateral a la derecha
              },
            ),
          ),
        ],
      ),
      endDrawer: Menu(
        selectedDrawerIndex: 0, // Usa el índice actual
        onSelectDrawerItem: (int index) {
          // Lógica para seleccionar la página basada en el índice
          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          } else if (index == 1) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => PaginaOferta()),
            );
          }
        },
      ),
      body: Stack(
        children: [
          _buildBackgroundGradient(),
          _buildBanner(),
          _buildContent(context),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('Llamando al mirador...');
        },
        backgroundColor: Colors.green,
        child: Icon(Icons.phone, size: 30, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget _buildBackgroundGradient() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.teal[200]!,
            Colors.teal[400]!,
            Colors.teal[600]!,
          ],
        ),
      ),
    );
  }

  Widget _buildBanner() {
    return Container(
      height: 220,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/image.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        padding: EdgeInsets.only(left: 16, bottom: 16),
        alignment: Alignment.bottomLeft,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.transparent, Colors.teal.withOpacity(0.7)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Text(
          'Mirador Autóctonos',
          style: TextStyle(
            color: Colors.white,
            fontSize: 42,
            fontWeight: FontWeight.bold,
            shadows: [
              Shadow(
                offset: Offset(0, 1),
                blurRadius: 2,
                color: Colors.black38,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 220),
      child: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildShortDescription(),
            SizedBox(height: 20),
            _buildSections(),
            SizedBox(height: 20),
            _buildMenu(),
            SizedBox(height: 20),
            _buildFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildShortDescription() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Text(
        'Disfruta de vistas impresionantes y sabores auténticos. '
        'Un espacio perfecto para conectar con la naturaleza y saborear lo mejor de la tradición rural.',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildSections() {
    return Column(
      children: [
        _buildSection('Ubicación', 'Vereda Alcon Tesorito, Ibagué'),
        _buildSection(
          'Desde cuando inició este mirador',
          'Este increíble y maravilloso mirador comenzó a operar en mayo de 2024.',
        ),
        _buildSection(
          'Servicios',
          '• Restaurante sábados, domingos y festivos de 11:00 AM a 10:00 PM\n'
              '• Reservas con dos días de anticipación\n'
              '• Celebraciones especiales\n'
              '• Servicio a domicilio fines de semana',
        ),
      ],
    );
  }

  Widget _buildSection(String title, String content) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.teal[900],
                shadows: [
                  Shadow(
                    offset: Offset(2, 2),
                    blurRadius: 4,
                    color: Colors.black45,
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Text(
              content,
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenu() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.teal[800],
            borderRadius: BorderRadius.circular(8),
          ),
          padding: EdgeInsets.all(10),
          child: Text(
            'Nuestro MENÚ',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(height: 10),
        Text('Almuerzos desde \$15.000', style: TextStyle(fontSize: 16)),
        SizedBox(height: 10),
        _buildMenuList(),
      ],
    );
  }

  Widget _buildMenuList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildExpandableMenuSection('Carnes Rojas', [
          '✔ Punta de Anca - \$30.000\n  Arroz primavera, papa a la francesa y ensalada',
          '✔ Lomo de Cerdo - \$28.000\n  Arroz primavera, papas a la francesa y ensalada',
          '✔ Costilla BBQ - \$28.000\n  Arroz primavera, papa a la francesa y ensalada',
          '✔ Sobrebarriga al Horno - \$28.000\n  Arroz primavera, papas a la francesa y ensalada',
          '✔ Plato Fuerte a la Parrilla - \$22.000\n  Arroz, rellena, yuca, envuelto de maíz y ensalada',
          '✔ Churrasco - \$28.000\n  Ensalada y chimichurri',
          '✔ Salchicharpa - \$20.000\n  Papa salada, arepa, y ensalada',
          '✔ Salchipapa - \$15.000\n  Francés americana, papas a la francesa y salchipapa.',
        ]),
        _buildExpandableMenuSection('Carnes Blancas', [
          '✔ Gordon Blue - \$20.000\n  Arroz primavera, papas a la francesa, ensalada rusa.',
        ]),
        _buildExpandableMenuSection('Mar', [
          '✔ Mojarra Frita - \$25.000\n  Arroz primavera, papas a la francesa y ensalada.',
          '✔ Bagre en Salsa - \$40.000\n  Arroz primavera, papa, yuca y aguacate.',
          '✔ Camarón en Mantequilla - \$24.000\n  Frutos del mar acompañado de patacones.',
        ]),
        _buildExpandableMenuSection('Bebidas', [
          '✔ Gaseosa',
          '✔ Jugos',
          '✔ Agua',
          '✔ Cerveza Corona',
          '✔ Cerveza Costeña',
          '✔ Águila',
          '✔ Poker',
          '✔ Y mucho más...',
        ]),
      ],
    );
  }

  Widget _buildExpandableMenuSection(String title, List<String> items) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ExpansionTile(
        leading: Icon(Icons.local_dining, color: Colors.teal, size: 30),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.teal[800],
          ),
        ),
        children: items.map((item) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
            child: Text(item, style: TextStyle(fontSize: 16)),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildFooter() {
    return Center(
      child: Column(
        children: [
          Text(
            '¡Gracias por visitarnos!',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text('Mirador Tesorito - Donde el campo y el sabor se unen.'),
        ],
      ),
    );
  }
}
