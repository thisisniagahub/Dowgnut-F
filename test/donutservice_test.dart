import 'package:donut_app/services/donutservice.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('previewNextDonut cycles through the selected flavor group', () {
    final DonutService service = DonutService();
    final firstDonut = service.previewDonuts.first;

    service.selectedDonut = firstDonut;
    service.previewNextDonut();

    final nextDonut = service.getSelectedDonut();
    expect(nextDonut, isNotNull);
    expect(nextDonut!.type, firstDonut.type);
    expect(nextDonut.name, isNot(firstDonut.name));

    for (int i = 1; i < service.previewDonuts.length; i++) {
      service.previewNextDonut();
    }

    expect(service.getSelectedDonut()?.name, firstDonut.name);
  });

  test('previewPreviousDonut wraps to the last flavor in the group', () {
    final DonutService service = DonutService();
    final firstDonut = service.previewDonuts.first;
    final lastDonut = service.previewDonuts.last;

    service.selectedDonut = firstDonut;
    service.previewPreviousDonut();

    final previousDonut = service.getSelectedDonut();
    expect(previousDonut, isNotNull);
    expect(previousDonut!.name, lastDonut.name);
    expect(previousDonut.type, firstDonut.type);
  });
}
