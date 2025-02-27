import 'package:flutter/material.dart';
import 'package:prueba2/HomePage.dart';
import 'package:prueba2/Menu.dart';

class Meraki extends StatefulWidget {
  @override
  _MerakiState createState() => _MerakiState();
}

class _MerakiState extends State<Meraki> with SingleTickerProviderStateMixin {
  int selectedDrawerIndex = 0;
  bool _isHomeIconVisible = false;

  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );
    _offsetAnimation = Tween<Offset>(
      begin: Offset(-1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void onSelectDrawerItem(int index) {
    setState(() {
      selectedDrawerIndex = index;
    });
    Navigator.pop(context);
  }

  void _onLogoTap() {
    setState(() {
      _isHomeIconVisible = !_isHomeIconVisible;
    });

    Future.delayed(Duration(milliseconds: 350), () {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
        (Route<dynamic> route) => false,
      );
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
                onTap: _onLogoTap,
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
            SizedBox(width: 10),
            Flexible(
              child: Text(
                'Parque Temático Meraki',
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.teal[800],
        automaticallyImplyLeading: false,
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openEndDrawer();
              },
            ),
          ),
        ],
      ),
      endDrawer: Menu(
        selectedDrawerIndex: selectedDrawerIndex,
        onSelectDrawerItem: onSelectDrawerItem,
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.teal[50]!, Colors.teal[200]!],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Banner con imagen
              Container(
                height: 200, // Altura del banner
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/banner.jpg'), // Ruta de tu imagen
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              SizedBox(height: 20),
              _buildAnimatedHeader('Ubicación', Icons.location_on),
              _buildText('Vereda Villa Vista, Avenida Ambalá'),
              _buildText('Inaugurado hace 14 años.'),
              SizedBox(height: 20),
              _buildAnimatedHeader('Ofrecemos', Icons.attractions),
              _buildListTile(
                'Bicicletas Aéreas',
                'Recorrido de 250 metros por \$50.000.',
                '¡Una experiencia emocionante a gran altura!',
              ),
              _buildListTile(
                'Senderos',
                'Sendero corto 1 km - \$10.000, largo 2.5 km - \$15.000.',
                'Conéctate con la naturaleza mientras caminas.',
              ),
              _buildListTile(
                'Capilla San Nicolás',
                'Espacio para bodas y ceremonias.',
                'Un lugar ideal para tus momentos especiales.',
              ),
              _buildListTile(
                'Mirador',
                'Vistas panorámicas impresionantes.',
                'Disfruta de la belleza del paisaje.',
              ),
              _buildListTile(
                'Experiencia Cafetera',
                'Aprende sobre el café y chocolate.',
                'Sumérgete en el mundo de los sabores.',
              ),
              SizedBox(height: 20),
              _buildAnimatedHeader('Pasadía Incluye', Icons.assignment),
              _buildText('• Parqueadero\n'
                  '• Ingreso al parque\n'
                  '• Recorrido guiado\n'
                  '• Visita a los miradores\n'
                  '• Una taza de café Meraki\n'
                  '• Almuerzo\n'
                  '• Bici paseo aéreo\n'
                  '• Seguro de turismo\n'),
              Divider(
                  thickness: 2, color: Colors.teal[800]), // Línea separadora
              SizedBox(height: 20),
              _buildAnimatedHeader('Restaurante', Icons.restaurant_menu),
              _buildExpandableMenu('Entradas', Icons.local_restaurant, [
                'Chorizo + arepa - \$12.000: ¡El inicio perfecto!',
                'Chicharrón + papa criolla - \$15.000: ¡Crujiente y sabroso!',
              ]),
              _buildExpandableMenu('Pescados', Icons.add_to_home_screen, [
                'Filete de pescado - \$40.000: Frescura y sabor.',
                'Cazuela de amarillo - \$42.000: Tradición en cada bocado.',
              ]),
              _buildExpandableMenu('Carnes Res', Icons.local_dining, [
                'Carne a la plancha - \$35.000: Jugosa y deliciosa.',
              ]),
              _buildExpandableMenu('Cerdo', Icons.fastfood_rounded, [
                'Costillas + papa criolla - \$38.000: ¡Irresistibles!',
              ]),
              _buildExpandableMenu('Pollo', Icons.hourglass_bottom_outlined, [
                'Pierna pernil + ensalada - \$25.000: Placer en cada bocado.',
              ]),
              _buildExpandableMenu('Sancocho de Gallina', Icons.soup_kitchen, [
                'Porción - \$30.000: Un clásico reconfortante.',
                'Porción para 4 - \$100.000: Ideal para compartir.',
              ]),
              _buildExpandableMenu('Comidas Rápidas', Icons.fastfood, [
                'Salchipapa - \$20.000: Un favorito de todos.',
                'Nuggets + papas - \$20.000: Perfecto para los niños.',
              ]),
              _buildExpandableMenu('Picada de la Casa', Icons.local_pizza, [
                'Picada para compartir - \$30.000: ¡Disfruta en grupo!',
              ]),
              SizedBox(height: 20),
              _buildAnimatedHeader('Cafetería', Icons.local_cafe),
              _buildExpandableMenu('Bebidas de la Casa', Icons.local_drink, [
                'Agua - \$10.000\nLeche - \$12.000: Refrescos esenciales.',
                'Jugos de frutas: Naturaleza en cada sorbo.',
              ]),
              _buildExpandableMenu('Bebidas Calientes', Icons.local_cafe, [
                'Aromáticas - \$5.000\nCafé - \$2.000: Calidez en cada taza.',
              ]),
              _buildExpandableMenu('Productos Meraki', Icons.shopping_basket, [
                'Café premium - \$30.000: Para los amantes del café.',
                'Miel de abejas - \$30.000: Dulzura natural.',
              ]),
              Divider(
                  thickness: 2, color: Colors.teal[800]), // Línea separadora
              SizedBox(height: 20),
              _buildAnimatedHeader(
                  'Actividades al Aire Libre', Icons.nature_people),
              _buildExpandableMenu('Recorridos', Icons.explore, [
                'Corto - \$5.000: Un vistazo rápido.',
                'Largo - \$20.000: Una aventura completa.',
                'Bicicletas aéreas - \$50.000: ¡Captura momentos únicos!',
                'Camping para 2 - \$250.000: Conéctate con la naturaleza.',
              ]),
              _buildText('Descubre cómo se prepara el café y el chocolate.'),
              SizedBox(height: 20),
              _buildAnimatedHeader('4 Factores', Icons.list),
              _buildText('• Ambiental\n• Social\n• Económico\n• Producción\n'),
              SizedBox(height: 20),
              _buildAnimatedHeader('Contacto', Icons.phone),
              _buildText('Tel: 3187156890 (Logística), 3122751769 (Nelson)'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedHeader(String title, IconData icon) {
    return SlideTransition(
      position: _offsetAnimation,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal[300]!, Colors.teal[800]!],
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.all(8),
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 28),
            SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildText(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Text(
        text,
        style: TextStyle(fontSize: 16, color: Colors.grey[800]),
      ),
    );
  }

  Widget _buildListTile(String title, String description,
      [String additionalInfo = '']) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.symmetric(vertical: 12),
      child: ListTile(
        title: Text(title,
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.teal[800])),
        subtitle: Text('$description\n$additionalInfo'),
      ),
    );
  }

  Widget _buildExpandableMenu(String title, IconData icon, List<String> items) {
    return ExpansionTile(
      title: Row(
        children: [
          Icon(icon, color: Colors.teal[800]),
          SizedBox(width: 8),
          Text(
            title,
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.teal[800]),
          ),
        ],
      ),
      children: items
          .map((item) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(item),
              ))
          .toList(),
    );
  }
}
