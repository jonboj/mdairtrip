
import 'dart:html';

import "package:mdcdavan/mdcdavan.dart";

class PagesElem extends MdaBaseElem {
  static const String CSS_SELECTED = 'mdcda-selected';
  static const String CSS_CONTAINER = 'container_page';

  final List<Element> _pages;
  PagesElem(final List<Element> this._pages) {
    element = document.createElement('main');
    element.classes.addAll([MDC_CSS.TOP_APP_BAR__FIXED_ADJUST, CSS_CONTAINER]);

    _pages.forEach((Element e){ element.append(e); });
  }

  void selectPage(int index) {
    print('PagesElem.selectPage : ' + index.toString());

    List<Element> selected = element.querySelectorAll('.' + CSS_SELECTED);
    selected.forEach((Element e){ e.classes.remove(CSS_SELECTED); });

    _pages[index].classes.add(CSS_SELECTED);
  }

}