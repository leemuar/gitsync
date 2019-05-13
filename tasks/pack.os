Перем ИндексКлассов;
Перем КаталогBin;
Перем КаталогКлассов;
Перем ПрефиксКлассов;
Перем ИмяМенеджераФайлов;

Процедура ВыполнитьЗапаковку()
	
	ТекущийКаталогЗадачи = ТекущийСценарий().Каталог;

	КаталогПроекта = Новый Файл(ОбъединитьПути(ТекущийКаталогЗадачи, "..")).ПолноеИмя;

	ПрефиксКлассов = "Gitsync";

	КаталогКлассов = ОбъединитьПути(КаталогПроекта, "src", "core", ОбъединитьПути("Классы","internal","bindata","Классы"));
	
	КаталогBin = ОбъединитьПути(КаталогПроекта, "bin");

	ИмяМенеджераФайлов = СтрШаблон("МенеджерЗапакованныхФайлов%1.os", ПрефиксКлассов);

	ИндексКлассов = Новый Соответствие;
	ОбработатьКаталог(КаталогBin, "*.cfe");
	ОбработатьКаталог(ОбъединитьПути(КаталогПроекта, "docs"), "*.md");

	ЗаписатьКлассИндексаЗапаковки(ИндексКлассов);

КонецПроцедуры

Процедура ЗаписатьКлассИндексаЗапаковки(ИндексКлассов)

	ТекстБлока = "Функция ПолучитьИндексФайлов() Экспорт
	|
	|	ИндексФайлов = Новый Соответствие;
	|";
	
	ШаблонДобавленияВИндекс = "	ИндексФайлов.Вставить(""%1"", ""%2"");";
	
	Для каждого ДанныеКласса Из ИндексКлассов Цикл

		ТекстБлока = ТекстБлока + СтрШаблон(ШаблонДобавленияВИндекс, ДанныеКласса.Ключ, ДанныеКласса.Значение) + Символы.ПС;
	
	КонецЦикла;

	ТекстБлока = ТекстБлока + "
	|	Возврат ИндексФайлов;
	|
	|КонецФункции";

	ФайлКлассаМенеджерЗапакованныхФайлов = ОбъединитьПути(КаталогКлассов, ИмяМенеджераФайлов);
	
	ЗаписьТекста = Новый ЗаписьТекста(ФайлКлассаМенеджерЗапакованныхФайлов);
	ЗаписьТекста.ЗаписатьСтроку(ТекстБлока);
	ЗаписьТекста.Закрыть();

	Сообщить("Данные запакованы в классы");

КонецПроцедуры

Процедура ОбработатьКаталог(Знач КаталогОбработки, Знач МаскаПоискаФайлов)
	
	МассивНайденныхФайлов = НайтиФайлы(КаталогОбработки, МаскаПоискаФайлов);

	Для каждого НайденныйФайл Из МассивНайденныхФайлов Цикл
	
		Если НайденныйФайл.ЭтоКаталог() Тогда
			Продолжить;
		КонецЕсли;

		ИмяФайла = СтрЗаменить(НайденныйФайл.ИмяБезРасширения, ".", "_");
		ПолныйПутьКФайлу = НайденныйФайл.ПолноеИмя;

		ИмяКлассаФайла = СтрШаблон("%1_%2", ИмяФайла, ПрефиксКлассов);
		
		ПутьКФайлуКласса = ОбъединитьПути(КаталогКлассов, ИмяКлассаФайла + ".os");
		ДанныеФайла = ПолучитBase64Строка(ПолныйПутьКФайлу);
		ХешСтрока = ПолучитьХешСтроку(ПолныйПутьКФайлу);

		ЗаписатьКласс(ПутьКФайлуКласса, НайденныйФайл.Имя, "1.0.0", ХешСтрока, ДанныеФайла);

		ИндексКлассов.Вставить(НайденныйФайл.Имя, ИмяКлассаФайла);

	КонецЦикла;


КонецПроцедуры

Функция ПолучитьХешСтроку(ПутьКФайлу)

	ХешФайла = Новый ХешированиеДанных(ХешФункция.MD5);
	ХешФайла.ДобавитьФайл(ПутьКФайлу);

	Возврат ХешФайла.ХешСуммаСтрокой;

КонецФункции

Процедура ЗаписатьКласс(ПутьКФайлуКласса, ИмяФайла, ВерсияФайла, ХешСтрока, ДанныеФайла)

	ШаблонТекст = "
	|///////////////////////////////////////////
	|//       ФАЙЛ СОЗДАН АВТОМАТИЧЕСКИ       //
	|///////////////////////////////////////////
	|//
	|// ФАЙЛ: <%1>
	|//
	|
	|// Возвращает версию запакованного файла
	|//
	|Функция Версия() Экспорт
	|	Возврат ""%2"";
	|КонецФункции
	|
	|// Возвращает имя запакованного файла
	|//
	|Функция ИмяФайла() Экспорт
	|	Возврат ""%1"";
	|КонецФункции
	|
	|// Возвращает хеш строку запакованного файла
	|//
	|Функция Хеш() Экспорт
	|	Возврат ""%3"";
	|КонецФункции
	|
	|// Возвращает запакованные данные файла
	|//
	|Функция ДвоичныеДанные() Экспорт
	|	ЗапакованныеДанные = ""%4"";
	|	Возврат ЗапакованныеДанные;
	|КонецФункции
	|
	|";

	ТекстКласса = СтрШаблон(ШаблонТекст, ИмяФайла, ВерсияФайла, ХешСтрока, ДанныеФайла);

	ЗаписьТекста = Новый ЗаписьТекста(ПутьКФайлуКласса);
	ЗаписьТекста.ЗаписатьСтроку(ТекстКласса);
	ЗаписьТекста.Закрыть();

КонецПроцедуры

Функция ПолучитBase64Строка(ПутьКФайлу)

	ДвоичныеДанныеФайла = Новый ДвоичныеДанные(ПутьКФайлу);
	Строка = Base64Строка(ДвоичныеДанныеФайла);
	Возврат Строка;

КонецФункции

ВыполнитьЗапаковку();