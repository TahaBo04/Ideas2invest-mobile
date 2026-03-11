import 'package:flutter_test/flutter_test.dart';
import 'package:ideas2invest_mobile/config/env.dart';
import 'package:ideas2invest_mobile/web/url_helper.dart';
import 'package:ideas2invest_mobile/navigation/tab_item.dart';

void main() {
  group('UrlHelper.isExternal', () {
    const base = 'https://example.com/';

    test('same host is not external', () {
      expect(UrlHelper.isExternal('https://example.com/page', base), isFalse);
    });

    test('different host is external', () {
      expect(UrlHelper.isExternal('https://other.com/page', base), isTrue);
    });

    test('empty host (relative) is not external', () {
      expect(UrlHelper.isExternal('/page', base), isFalse);
    });

    test('malformed URL is treated as external', () {
      expect(UrlHelper.isExternal('not a url ::::', base), isFalse);
    });
  });

  group('TabItem', () {
    test('has exactly 5 tabs', () {
      expect(TabItem.tabs.length, 5);
    });

    test('all tab paths start with /', () {
      for (final tab in TabItem.tabs) {
        expect(tab.path.startsWith('/'), isTrue,
            reason: '${tab.label} path should start with /');
      }
    });

    test('tab labels are unique', () {
      final labels = TabItem.tabs.map((t) => t.label).toSet();
      expect(labels.length, TabItem.tabs.length);
    });
  });
}
