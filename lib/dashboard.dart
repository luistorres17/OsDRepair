import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:percent_indicator/percent_indicator.dart';
import '/screens/userscreens.dart';
import '/controllers/authroutes.dart';

class DashboardWidget extends StatefulWidget {
  const DashboardWidget({super.key});

  @override
  State<DashboardWidget> createState() => _DashboardWidgetState();
}

class _DashboardWidgetState extends State<DashboardWidget>
    with TickerProviderStateMixin {
  late TabController _tabController;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      vsync: this,
      length: 2,
      initialIndex: 0,
    )..addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _getScreen(int index) {
    switch (index) {
      case 4:
        return UsersScreen();
      default:
        return Column(
          children: [
            Padding(
              padding: EdgeInsets.all(16),
              child: Container(
                width: double.infinity,
                height: 170,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 4,
                      color: Color(0x33000000),
                      offset: Offset(0, 2),
                    )
                  ],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Tus Trabajos Completados',
                              style: TextStyle(
                                color: Color(0xFF14181B),
                                fontSize: 24,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                              child: Text(
                                'Completados',
                                style: TextStyle(
                                  color: Color(0xFF57636C),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                              child: Text(
                                '20',
                                style: TextStyle(
                                  color: Color(0xFF14181B),
                                  fontSize: 32,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      CircularPercentIndicator(
                        percent: 0.55,
                        radius: 50,
                        lineWidth: 8,
                        animation: true,
                        animateFromLastPercent: true,
                        progressColor: Color(0xFF4B39EF),
                        backgroundColor: Color(0xFFE0E3E7),
                        center: Text(
                          '55%',
                          style: TextStyle(
                            color: Color(0xFF14181B),
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  ListView(
                    padding: EdgeInsets.zero,
                    children: [],
                  ),
                  ListView(
                    padding: EdgeInsets.zero,
                    children: [],
                  ),
                ],
              ),
            ),
          ],
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
          backgroundColor: Color(0xFF6F61EF),
          automaticallyImplyLeading: true,
          actions: [],
          centerTitle: true,
          elevation: 0,
        ),
        body: SafeArea(
          top: true,
          child: _getScreen(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.build),
              label: 'Reparaciones',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.people),
              label: 'Clientes',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.engineering),
              label: 'Tecnicos',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Usuarios',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Color(0xFF4B39EF),
          unselectedItemColor: Colors.grey,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}


