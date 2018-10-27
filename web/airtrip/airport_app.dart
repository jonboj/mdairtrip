
import 'dart:html';
import 'dart:async';

import "package:mdcdavan/mdcdavan.dart";

import 'pages_elem.dart';
import 'signin_register.dart';
import 'airport_list.dart';
import 'trip_route_list.dart';

const MdcTopAppBarData topBarDataPublic =
const MdcTopAppBarData('DartAirTrip', '', const []);

const MdcDrawerData drawerDataPublic =
const MdcDrawerData('Trip', 'Compose your flight list',
    const [['Airport list', 'flight'],
    ['Route list', 'list'],
    ['Route map', 'map'],
    ['Login/register', 'account_circle']]);

const MdcDrawerData drawerDataSignedIn =
  const MdcDrawerData('Trip', 'Compose your flight list',
    const [['Airport list', 'flight'],
    ['Route list', 'list'],
    ['Route map', 'map'],
    ['Logout', 'account_circle']]);


enum PageIndex { airportList, routeList, routeMap, signinRegister}

class AirportApp {

  List<Element> contentPageElement = [
    new DivElement(),
    new DivElement(),
    new DivElement()..text = 'Three (Remove at fill)',
    new DivElement() ];

  PagesElem _pagesElem;
  MdaDomEntryHandle _topBarEntry;
  MdaDomEntryHandle<MdcDrawer> _drawerEntry;
  MdaDomEntryHandle _signinRegEntry;
  MdaDomEntryHandle<AirportList> _airportListEntry;
  MdaDomEntryHandle _routeListEntry;

  List<AirportData> _routeList = new List<AirportData>();

  AirportApp(final Element parent) {
    //Topbar
    _topBarEntry = new MdaDomEntryHandle.entry(parent, new MdcTopAppBar(topBarDataPublic));

    //Drawer
    _drawerEntry = new MdaDomEntryHandle<MdcDrawer>.entry(parent, new MdcDrawer(drawerDataPublic));

    Stream<MouseEvent> streamTopBar = _topBarEntry.getStreamMap()[MdcTopAppBar.STREAM_ID];
    streamTopBar.forEach((MouseEvent e) {_drawerEntry.node.open = true;});

    Stream<int> streamDrawer = _drawerEntry.getStreamMap()[MdcList.STREAM_ID];
    streamDrawer.forEach(_handleMenuSelect);

    //Pages
    _pagesElem = new PagesElem(contentPageElement);
    document.body.append(_pagesElem.element);
    _pagesElem.selectPage(PageIndex.airportList.index);

    //Airportlist
    _airportListEntry =
    new MdaDomEntryHandle<AirportList>.entry(
        contentPageElement[PageIndex.airportList.index], new AirportList(AIRPORT_LIST_DATA)
    );
    Stream<int> airportPickStream = _airportListEntry.getStreamMap()[MdcList.STREAM_ID];
    airportPickStream.forEach(_handleAirportPick);

    //Routelist
    _routeListEntry = new MdaDomEntryHandle.entry(
        contentPageElement[PageIndex.routeList.index], new TripRouteList(_routeList)
    );

    //SigninRegister
    _signinRegEntry = new MdaDomEntryHandle.entry(
        contentPageElement[PageIndex.signinRegister.index], new SigninRegister('')
    );
    Stream<UserCredentials> streamLogin = _signinRegEntry.getStreamMap()[Signin.STREAM_ID];
    streamLogin.forEach(_handleLogin);

    MdcSnackbar.attach(document.body);
  }

  void _handleMenuSelect(int index) {
    print('AirportRoot._handleMenuSelect : ' + index.toString());
    _pagesElem.selectPage(index);
    _drawerEntry.node.open = false;
  }

  void _handleLogin(final UserCredentials u) {
    print('AirportRoot._handleLogin : ' + u.userid);

    _drawerEntry = _drawerEntry.replace(new MdcDrawer(drawerDataSignedIn));
    Stream<int> streamDrawer = _drawerEntry.getStreamMap()[MdcList.STREAM_ID];
    streamDrawer.forEach(_handleMenuSelect);

    _topBarEntry = _topBarEntry.replace(new MdcTopAppBar(new MdcTopAppBarData('DartAirTrip', u.userid, const [])));

    Stream<MouseEvent> streamTopBar = _topBarEntry.getStreamMap()[MdcTopAppBar.STREAM_ID];
    streamTopBar.forEach((MouseEvent e) {_drawerEntry.node.open = true;});

    _signinRegEntry = _signinRegEntry.replace(new SigninRegister(u.userid));
    Stream<MouseEvent> streamLogout = _signinRegEntry.getStreamMap()[Logout.STREAM_ID];
    streamLogout.forEach(_handleLogout);

    MdcSnackbar.show('Login : ' + u.userid);
  }

  void _handleLogout(final MouseEvent e) {
    print('AirportRoot._handleLogout');

    _drawerEntry = _drawerEntry.replace(new MdcDrawer(drawerDataPublic));
    Stream<int> streamDrawer = _drawerEntry.getStreamMap()[MdcList.STREAM_ID];
    streamDrawer.forEach(_handleMenuSelect);

    _topBarEntry = _topBarEntry.replace(new MdcTopAppBar(topBarDataPublic));
    Stream<MouseEvent> streamTopBar = _topBarEntry.getStreamMap()[MdcTopAppBar.STREAM_ID];
    streamTopBar.forEach((MouseEvent e) {_drawerEntry.node.open = true;});

    _signinRegEntry = _signinRegEntry.replace(new SigninRegister(''));
    Stream<UserCredentials> streamLogin = _signinRegEntry.getStreamMap()[Signin.STREAM_ID];
    streamLogin.forEach(_handleLogin);

    MdcSnackbar.show('Logout');
  }

  void _handleAirportPick(int index) {
    final AirportData apd = _airportListEntry.node.getFromList(index);
    print('AirportRoot._handleAirportPick : ' + apd.name);
    _routeList.add(apd);
    _routeListEntry = _routeListEntry.replace( new TripRouteList(_routeList));
    MdcSnackbar.show('Picked to route : ' + apd.name);
  }

}