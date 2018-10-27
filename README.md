# MdAirTrip

Small demo/tutorial app for [mdcdavan](https://github.com/jonboj/mdcdavan) lib.

### Usage

From the `Airport list` compose a route, by airport selection with tap. The route will be
shown in list.

Note: **mdairtrip** is a demo client with no server connection, hence account creation and login
functionality only holds credentials for the session and will not store these between sessions.

Hosted build [mdairtrip build](https://jonboj.net/mdairtrip).

### Design

Adapts [mdcdavan](https://github.com/jonboj/mdcdavan) design of application framework.

`AirportApp` is root container for the app. It handles entries to `MdaDomEntryHandle` for the
different nodes in tree (topbar, drawer, signin/registry, airport list and route list). Updates
to these entries enters through Streams, then processed and result replaces old
`MdaNodeElem` instances with new.

### Unimplemented map view

To simplify build, deployment and illustrate compactness of build (size of `main.dart.js`)
map view isn't implemented, just showing a template element. Still datastructure from
`Route list` is similar to [daflight](https://github.com/jonboj/daflight), hence similar could
be implemented using same design.

### Mobile

MdAirTrip has a `manifest.json` for mobile deployment, this enables option from e.g. Chrome
of adding shortcut to the start screen. The build is compact, small size of `main.dart.js`, which
contributes to low load and instantiation time on mobile devices.

### Contributions

A test/demo of concept. Bugs and feature requests are welcome and will be considered.
Other feedback is welcome.
