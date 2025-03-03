﻿#Использовать ".."
#Использовать asserts
#Использовать fs
#Использовать tempfiles
#Использовать v8find

Перем юТест;
Перем УправлениеИБ;
Перем ВременныйКаталог;

Процедура Инициализация()
	
	УправлениеИБ = Новый УправлениеИБ;
	ПутьКIBCMD = ПолучитьПутьКIBCMD();
	Если ЗначениеЗаполнено(ПутьКIBCMD) Тогда
		УправлениеИБ.ПутьКПриложению(ПутьКIBCMD);
	КонецЕсли;	
	Лог = Логирование.ПолучитьЛог("oscript.lib.ibcmdrunner");
	Лог.УстановитьУровень(УровниЛога.Отладка);
	
КонецПроцедуры

Функция ПолучитьСписокТестов(Тестирование) Экспорт
	
	юТест = Тестирование;
	
	СписокТестов = Новый Массив;
	СписокТестов.Добавить("ТестДолжен_СоздатьФайловуюБазуИзФайлаКонфигурации");
	СписокТестов.Добавить("ТестДолжен_ВыгрузитьДанныеФайловойБазыВФайл");
	СписокТестов.Добавить("ТестДолжен_СоздатьФайловуюБазуИзФайлаВыгрузки");
	СписокТестов.Добавить("ТестДолжен_ВыгрузитьКонфигурациюФайловойБазыВФайл");
	СписокТестов.Добавить("ТестДолжен_СоздатьФайловуюБазуИзФайловКонфигурации");
	СписокТестов.Добавить("ТестДолжен_ВыгрузитьКонфигурациюФайловойБазыВФайлы");
	СписокТестов.Добавить("ТестДолжен_ЗагрузитьФайловуюБазуИзФайлаВыгрузкиДанных");
    //СписокТестов.Добавить("ТестДолжен_ОчиститьФайловуюБазу");
	СписокТестов.Добавить("ТестДолжен_ЗагрузитьФайловуюБазуИзФайлаКонфигурации");
	СписокТестов.Добавить("ТестДолжен_ЗагрузитьВыбранныеФайлыКонфигурации");
	СписокТестов.Добавить("ТестДолжен_ЗагрузитьВыбранныйФайлКонфигурации");
	СписокТестов.Добавить("ТестДолжен_ВернутьНомерВерсии");
	СписокТестов.Добавить("ТестДолжен_СоздатьПустуюФайловуюБазу");
    
	Если ВерсияПлатформыБольше("8.3.21") Тогда
		СписокТестов.Добавить("ТестДолжен_СоздатьФайловуюБазуИзАрхива");
		СписокТестов.Добавить("ТестДолжен_ВыгрузитьКонфигурациюВАрхив");
		СписокТестов.Добавить("ТестДолжен_ЗагрузитьКонфигурациюИзАрхива");

		СписокТестов.Добавить("ТестДолжен_СнятьСПоддержкиКонфигурацию");
		СписокТестов.Добавить("ТестДолжен_ПолучитьСписокОбщихРеквизитов");
		СписокТестов.Добавить("ТестДолжен_ПолучитьИдентификаторПоколенияДанных");

		СписокТестов.Добавить("ТестДолжен_ОбновитьКонфигурациюДинамически");
		СписокТестов.Добавить("ТестДолжен_ОбновитьКонфигурациюСЗавершениемСеансов");

		СписокТестов.Добавить("ТестДолжен_СоздатьРасширение");
		СписокТестов.Добавить("ТестДолжен_ПолучитьИнформациюОРасширении");
		СписокТестов.Добавить("ТестДолжен_ПолучитьСписокРасширений");
		СписокТестов.Добавить("ТестДолжен_ИзменитьСвойстваРасширения");
		СписокТестов.Добавить("ТестДолжен_УдалитьРасширение");
		СписокТестов.Добавить("ТестДолжен_ВыгрузитьРасширениеВФайл");
		СписокТестов.Добавить("ТестДолжен_ЗагрузитьРасширениеИзФайла");
		СписокТестов.Добавить("ТестДолжен_ПолучитьОписанияРасширений");

	КонецЕсли;		
	
	Возврат СписокТестов;
	
КонецФункции

Процедура ПослеЗапускаТеста() Экспорт

	Если ЗначениеЗаполнено( ВременныйКаталог ) Тогда

		Утверждения.ПроверитьИстину( НайтиФайлы( ВременныйКаталог, "*").Количество() = 0, "Во временном каталоге " + ВременныйКаталог + " не должно остаться файлов" );
	
		ВременныеФайлы.УдалитьФайл(ВременныйКаталог);

		Утверждения.ПроверитьИстину( Не ФС.КаталогСуществует(ВременныйКаталог), "Временный каталог должен быть удален");

		ВременныйКаталог = "";

	КонецЕсли;

КонецПроцедуры

// Тест 0
Процедура ТестДолжен_СоздатьФайловуюБазуИзФайлаКонфигурации() Экспорт

	УстановитьПараметрыВременнойИБ();
	
	ПутьКФайлуКонфигурации = ОбъединитьПути(ТекущийСценарий().Каталог, "fixtures", "1.0", "1Cv8.cf");

	УправлениеИБ.СоздатьИБИзФайлаКонфигурации(ПутьКФайлуКонфигурации);
	ФайлБазыДанных = ОбъединитьПути(ВременныйКаталог, "1Cv8.1CD");
	Утверждения.ПроверитьИстину(ФС.ФайлСуществует(ФайлБазыДанных), "Должен быть создан файл базы данных во временном каталоге");
	УдалитьФайлы(ВременныйКаталог);
КонецПроцедуры

// Тест 1
Процедура ТестДолжен_ВыгрузитьДанныеФайловойБазыВФайл() Экспорт
	
	УстановитьПараметрыТестовойИБ();
	
	ПутьВыгрузкиДанных = ОбъединитьПути(ТекущийСценарий().Каталог, "fixtures", "1C.dt");
	УправлениеИБ.ВыгрузитьДанныеИБ(ПутьВыгрузкиДанных);
	
	Утверждения.ПроверитьИстину(ФС.ФайлСуществует(ПутьВыгрузкиданных), "Должен быть создан файл выгрузки данных в каталоге fixtures");
	УдалитьФайлы(ПутьВыгрузкиДанных);
	
	УдалитьФайлы(ВременныйКаталог);
КонецПроцедуры

// Тест 2
Процедура ТестДолжен_СоздатьФайловуюБазуИзФайлаВыгрузки() Экспорт
	
	УстановитьПараметрыВременнойИБ();
	
	ПутьКФайлуВыгрузки = ОбъединитьПути(ТекущийСценарий().Каталог, "fixtures", "1.0", "1C.dt");

	УправлениеИБ.СоздатьИБИзФайлаВыгрузки(ПутьКФайлуВыгрузки);
	ФайлБазыДанных = ОбъединитьПути(ВременныйКаталог, "1Cv8.1CD");
	Утверждения.ПроверитьИстину(ФС.ФайлСуществует(ФайлБазыДанных), "Должен быть создан файл базы данных во временном каталоге");
	Приостановить(2000);
	УдалитьФайлы(ВременныйКаталог);
КонецПроцедуры

// Тест 3
Процедура ТестДолжен_ВыгрузитьКонфигурациюФайловойБазыВФайл() Экспорт
	
	УстановитьПараметрыТестовойИБ();
	
	ПутьКФайлуКонфигурации = ОбъединитьПути(ТекущийСценарий().Каталог, "fixtures", "1Cv8.cf");
	УправлениеИБ.ВыгрузитьКонфигурациюВФайл(ПутьКФайлуКонфигурации);
	
	Утверждения.ПроверитьИстину(ФС.ФайлСуществует(ПутьКФайлуКонфигурации), "Должен быть создан файл выгрузки данных в каталоге fixtures");
	УдалитьФайлы(ПутьКФайлуКонфигурации);
	УдалитьФайлы(ВременныйКаталог);
КонецПроцедуры

// Тест 4
Процедура ТестДолжен_СоздатьФайловуюБазуИзФайловКонфигурации() Экспорт
	
	УстановитьПараметрыВременнойИБ();
	
	КаталогВыгрузкиВФайлы = ОбъединитьПути(ТекущийСценарий().Каталог, "fixtures", "1.0", "files");
	
	УправлениеИБ.СоздатьИБИзФайловКонфигурации(КаталогВыгрузкиВФайлы);
	ФайлБазыДанных = ОбъединитьПути(ВременныйКаталог, "1Cv8.1CD");
	Приостановить(2000);
	Утверждения.ПроверитьИстину(ФС.ФайлСуществует(ФайлБазыДанных), "Должен быть создан файл базы данных во временном каталоге");
	УдалитьФайлы(ВременныйКаталог);
КонецПроцедуры

// Тест 5
Процедура ТестДолжен_ВыгрузитьКонфигурациюФайловойБазыВФайлы() Экспорт
	
	УстановитьПараметрыТестовойИБ();
	Если ВерсияПлатформыБольше("8.3.22") Тогда
		БазовыйФайлСостояния = ОбъединитьПути(ТекущийСценарий().Каталог, "fixtures", "8_3_22", "ConfigDumpInfo.xml");
	Иначе	
		БазовыйФайлСостояния = ОбъединитьПути(ТекущийСценарий().Каталог, "fixtures", "1.0", "ConfigDumpInfo.xml");
	КонецЕсли;	
	КаталогВыгрузкиВФайлы = ОбъединитьПути(ТекущийСценарий().Каталог, "fixtures", "files");
	ФС.ОбеспечитьКаталог(КаталогВыгрузкиВФайлы);
	
	УправлениеИБ.ВыгрузитьКонфигурациюВФайлы(КаталогВыгрузкиВФайлы, БазовыйФайлСостояния,, ЛОЖЬ);
	
	ФайлСостояния = ОбъединитьПути(КаталогВыгрузкиВФайлы, "ConfigDumpInfo.xml");
	Утверждения.ПроверитьИстину(ФС.ФайлСуществует(ФайлСостояния), "Должен быть создан файл состояния конфигурации в каталоге fixtures/files");
	УдалитьФайлы(КаталогВыгрузкиВФайлы);
	УдалитьФайлы(ВременныйКаталог);
		
КонецПроцедуры

// Тест 6
Процедура ТестДолжен_ЗагрузитьФайловуюБазуИзФайлаВыгрузкиДанных() Экспорт
	
	УстановитьПараметрыВременнойИБ();
	
	Если ВерсияПлатформыБольше("8.3.22.1703") Тогда
		ПутьКФайлуВыгрузки = ОбъединитьПути(ТекущийСценарий().Каталог, "fixtures", "8_3_22", "1Cv8.dt");
	Иначе
		ПутьКФайлуВыгрузки = ОбъединитьПути(ТекущийСценарий().Каталог, "fixtures", "1.0", "1C.dt");
	КонецЕсли;	

	УправлениеИБ.СоздатьИБИзФайлаВыгрузки(ПутьКФайлуВыгрузки);
	УправлениеИБ.ЗагрузитьДанныеИБ(ПутьКФайлуВыгрузки);
	ФайлБазыДанных = ОбъединитьПути(ВременныйКаталог, "1Cv8.1CD");
	Утверждения.ПроверитьИстину(ФС.ФайлСуществует(ФайлБазыДанных), "Должен быть создан файл базы данных во временном каталоге");
	УдалитьФайлы(ВременныйКаталог);
КонецПроцедуры

// Тест 7
// Процедура ТестДолжен_ОчиститьФайловуюБазу() Экспорт
// 	ВременныйКаталог = ОбъединитьПути(КаталогВременныхФайлов(), "tmp_db");
// 	УдалитьФайлы(ВременныйКаталог);
// 	КаталогАвтономногоСервера = ОбъединитьПути(КаталогВременныхФайлов(), "data");
// 	ФС.ОбеспечитьКаталог(ВременныйКаталог);
// 	ПутьКФайлуВыгрузки = ОбъединитьПути(ТекущийСценарий().Каталог, "fixtures", "1.0", "1C_.dt");

// 	УправлениеИБ.УстановитьПараметрыФайловойИБ(ВременныйКаталог);
// 	УправлениеИБ.УстановитьПараметрыАвтономногоСервера(КаталогАвтономногоСервера);
// 	УправлениеИБ.СоздатьИБИзФайлаВыгрузки(ПутьКФайлуВыгрузки);
// 	УправлениеИБ.УстановитьПараметрыАвторизацииИБ("Администратор", "1");
// 	ФайлБазыДанных = ОбъединитьПути(ВременныйКаталог, "1Cv8.1CD");
// 	Утверждения.ПроверитьИстину(ФС.ФайлСуществует(ФайлБазыДанных), "Должен быть создан файл базы данных во временном каталоге");
// 	УправлениеИБ.ОчиститьИБ();
// 	// Сч = 0;
// 	// Пока НайтиФайлы( ВременныйКаталог, "*").Количество() <> 0 Цикл
// 	// 	Приостановить(1000);
// 		УдалитьФайлы(КаталогАвтономногоСервера);
// 		УдалитьФайлы(ВременныйКаталог);
// 	// 	Сч = Сч + 1;
// 	// 	Если Сч > 100 Тогда
// 	// 		Прервать;
// 	// 	КонецЕсли;	

// 	// КонецЦикла;	
// 	// Сообщить("Ожидание " + Сч + " сек.");
// КонецПроцедуры	

// Тест 7
Процедура ТестДолжен_ЗагрузитьФайловуюБазуИзФайлаКонфигурации() Экспорт
	
	УстановитьПараметрыВременнойИБ();
	
	Если ВерсияПлатформыБольше("8.3.22.1703") Тогда
		ПутьКФайлуВыгрузки = ОбъединитьПути(ТекущийСценарий().Каталог, "fixtures", "8_3_22", "1Cv8.dt");
	Иначе
		ПутьКФайлуВыгрузки = ОбъединитьПути(ТекущийСценарий().Каталог, "fixtures", "1.0", "1C.dt");
	КонецЕсли;	
	
	ПутьКФайлуКонфигурации = ОбъединитьПути(ТекущийСценарий().Каталог, "fixtures", "1.0", "1Cv8.cf");

	УправлениеИБ.СоздатьИБИзФайлаВыгрузки(ПутьКФайлуВыгрузки);
	УправлениеИБ.ЗагрузитьКонфигурацию(ПутьКФайлуКонфигурации);
	ФайлБазыДанных = ОбъединитьПути(ВременныйКаталог, "1Cv8.1CD");
	Утверждения.ПроверитьИстину(ФС.ФайлСуществует(ФайлБазыДанных), "Должен быть создан файл базы данных во временном каталоге");
	УдалитьФайлы(ВременныйКаталог);
КонецПроцедуры

// Тесты выгрузки-загрузки файл zip
Процедура ТестДолжен_СоздатьФайловуюБазуИзАрхива() Экспорт

	УстановитьПараметрыВременнойИБ();
	
	ФайлАрхива = ОбъединитьПути(ТекущийСценарий().Каталог, "fixtures", "arcive.zip");

	УправлениеИБ.СоздатьИБИзФайловКонфигурации(ФайлАрхива);
	ФайлБазыДанных = ОбъединитьПути(ВременныйКаталог, "1Cv8.1CD");
	Утверждения.ПроверитьИстину(ФС.ФайлСуществует(ФайлБазыДанных), "Должен быть создан файл базы данных во временном каталоге");
	УдалитьФайлы(ВременныйКаталог);
КонецПроцедуры	

Процедура ТестДолжен_ВыгрузитьКонфигурациюВАрхив() Экспорт
	
	УстановитьПараметрыТестовойИБ();
	Если ВерсияПлатформыБольше("8.3.22") Тогда
		БазовыйФайлСостояния = ОбъединитьПути(ТекущийСценарий().Каталог, "fixtures", "8_3_22", "ConfigDumpInfo.xml");
	ИначеЕсли ВерсияПлатформыБольше("8.3.21") Тогда
		БазовыйФайлСостояния = ОбъединитьПути(ТекущийСценарий().Каталог, "fixtures", "8_3_21", "ConfigDumpInfo.xml");	
	Иначе	
		БазовыйФайлСостояния = ОбъединитьПути(ТекущийСценарий().Каталог, "fixtures", "1.0", "ConfigDumpInfo.xml");
	КонецЕсли;	
	
	ФайлВыгрузки = ОбъединитьПути(ТекущийСценарий().Каталог, "fixtures", "archive1.zip");
		
	УправлениеИБ.ВыгрузитьКонфигурациюВФайлы(ФайлВыгрузки, БазовыйФайлСостояния,, Ложь, Истина);
	
	Утверждения.ПроверитьИстину(ФС.ФайлСуществует(ФайлВыгрузки), "Должен быть создан файл состояния конфигурации в каталоге fixtures/files");
	УдалитьФайлы(ФайлВыгрузки);
	УдалитьФайлы(ВременныйКаталог);
КонецПроцедуры

Процедура ТестДолжен_ЗагрузитьКонфигурациюИзАрхива() Экспорт
	УстановитьПараметрыВременнойИБ();
	
	Если ВерсияПлатформыБольше("8.3.22") Тогда
		ПутьКФайлуВыгрузки = ОбъединитьПути(ТекущийСценарий().Каталог, "fixtures", "8_3_22", "1Cv8.dt");
	Иначе
		ПутьКФайлуВыгрузки = ОбъединитьПути(ТекущийСценарий().Каталог, "fixtures", "1.0", "1C.dt");
	КонецЕсли;	
	
	ПутьКФайлуАрхиваКонфигурации = ОбъединитьПути(ТекущийСценарий().Каталог, "fixtures", "arcive.zip");
	
	УправлениеИБ.СоздатьИБИзФайлаВыгрузки(ПутьКФайлуВыгрузки);
	УправлениеИБ.УстановитьПараметрыАвторизацииИБ("admin", "admin");
	УправлениеИБ.ЗагрузитьКонфигурациюИзФайлов(ПутьКФайлуАрхиваКонфигурации);
	ФайлБазыДанных = ОбъединитьПути(ВременныйКаталог, "1Cv8.1CD");
	Утверждения.ПроверитьИстину(ФС.ФайлСуществует(ФайлБазыДанных), "Должен быть создан файл базы данных во временном каталоге");
	УдалитьФайлы(ВременныйКаталог);
КонецПроцедуры

// Новые команды
Процедура ТестДолжен_СнятьСПоддержкиКонфигурацию() Экспорт
	
	УстановитьПараметрыВременнойИБ();
	
	Если ВерсияПлатформыБольше("8.3.22") Тогда
		ПутьКФайлуВыгрузки = ОбъединитьПути(ТекущийСценарий().Каталог, "fixtures", "8_3_22", "8_3_22with_support.dt");
	ИначеЕсли ВерсияПлатформыБольше("8.3.21") Тогда
		ПутьКФайлуВыгрузки = ОбъединитьПути(ТекущийСценарий().Каталог, "fixtures", "8_3_21", "8_3_21with_support.dt");
	Иначе
		Возврат;
	КонецЕсли;	
	
	УправлениеИБ.СоздатьИБИзФайлаВыгрузки(ПутьКФайлуВыгрузки);
	ФайлБазыДанных = Новый Файл(ОбъединитьПути(ВременныйКаталог, "1Cv8.1CD"));
	РазмерБазыДанных = ФайлБазыДанных.Размер();
	
	УправлениеИБ.УстановитьПараметрыАвторизацииИБ("admin", "admin");
	УправлениеИБ.СнятьСПоддержки();

	ВыводКоманды = УправлениеИБ.ВыводПоследнейКоманды();
	УспешноЗавершено = СтрЧислоВхождений(ВыводКоманды, "Снятие конфигурации с поддержки успешно завершено") > 0;
	Утверждения.ПроверитьИстину(УспешноЗавершено, 
		"Снятие конфигурации с поддержки должно быть успешно завершено");
	УдалитьФайлы(ВременныйКаталог);

КонецПроцедуры	

Процедура ТестДолжен_ПолучитьСписокОбщихРеквизитов() Экспорт
	УстановитьПараметрыТестовойИБ();
	
	Рез = УправлениеИБ.СписокОбщихРеквизитов();
	Утверждения.ПроверитьИстину(СтрНайти(Рез, "ОбщийРеквизит1") > 0, "Список должен содержать ""ОбщийРеквизит1"".");
	
	УдалитьФайлы(ВременныйКаталог);

КонецПроцедуры

Процедура ТестДолжен_ПолучитьИдентификаторПоколенияДанных() Экспорт
	
	УстановитьПараметрыТестовойИБ();
	
	Рез = УправлениеИБ.ИДПоколенияДанных();

	ДлинаСтроки = СтрДлина(Рез);
	
	Если ЭтоWindows() Тогда
		ТестПрошел = (СтрДлина(Рез) = 43);
	Иначе
		ТестПрошел = (СтрДлина(Рез) = 42);
	КонецЕсли;		

	УдалитьФайлы(ВременныйКаталог);
КонецПроцедуры

// Обновление конфигурации БД
Процедура ТестДолжен_ОбновитьКонфигурациюДинамически() Экспорт
	// разворачиваем базу
	Если ВерсияПлатформыБольше("8.3.23") Тогда
		КаталогАрхива = ОбъединитьПути(ТекущийСценарий().Каталог, "fixtures", "8_3_23");
		КаталогИБ = ОбъединитьПути(ТекущийСценарий().Каталог, "fixtures", "8_3_23", "update");
		АрхивИБ = ОбъединитьПути(ТекущийСценарий().Каталог, "fixtures", "8_3_23", "update_dyn.zip");
	ИначеЕсли ВерсияПлатформыБольше("8.3.22") Тогда
		КаталогАрхива = ОбъединитьПути(ТекущийСценарий().Каталог, "fixtures", "8_3_22");
		КаталогИБ = ОбъединитьПути(ТекущийСценарий().Каталог, "fixtures", "8_3_22", "update");
		АрхивИБ = ОбъединитьПути(ТекущийСценарий().Каталог, "fixtures", "8_3_22", "update_dyn.zip");
	ИначеЕсли ВерсияПлатформыБольше("8.3.21") Тогда
		КаталогАрхива = ОбъединитьПути(ТекущийСценарий().Каталог, "fixtures", "8_3_21");
		КаталогИБ = ОбъединитьПути(ТекущийСценарий().Каталог, "fixtures", "8_3_21", "update");
		АрхивИБ = ОбъединитьПути(ТекущийСценарий().Каталог, "fixtures", "8_3_21", "update_dyn.zip");
	Иначе	
		Возврат;
	КонецЕсли;	
	УдалитьФайлы(КаталогИБ, "*.*");
	Архив = Новый ЧтениеZipФайла(АрхивИБ);
	Архив.ИзвлечьВсе(КаталогАрхива, РежимВосстановленияПутейФайловZIP.Восстанавливать);
	// запускаем тонкий клиент
	

	ПутьК1С = СтрЗаменить(ПолучитьПутьКIBCMD(), "ibcmd", "1cv8c");
	Команда = """" + ПутьК1С + """ /F""" + КаталогИБ + """ /Nadmin /Padmin /DisableStartupMessages";
	Сообщить(Команда);

	ЗапуститьПриложение(Команда);

	// обновляем конфигурацию динамически
	УправлениеИБ.УстановитьПараметрыФайловойИБ(КаталогИБ);
	КаталогАвтономногоСервера = ОбъединитьПути(КаталогВременныхФайлов(), "data");
	УправлениеИБ.УстановитьПараметрыАвтономногоСервера(КаталогАвтономногоСервера);
	УправлениеИБ.УстановитьПараметрыАвторизацииИБ("admin", "admin");
	Приостановить(2000);
	УправлениеИБ.ОбновитьКонфигурациюБазыДанных("", "force", "auto");
	Приостановить(2000);
	ФайлБлокировки = ОбъединитьПути(КаталогИБ, "1Cv8tmp.1CL");
	ТестПрошел = Ложь;
	Если Не ФС.ФайлСуществует(ФайлБлокировки) Тогда
		ТестПрошел = Истина;
	КонецЕсли;	
	// проверяем, что база закрылась (отсутствие файла 1Cv8tmp.1CL)
	Утверждения.ПроверитьИстину(ТестПрошел, "Сеанс 1С должен закрыться после динамического обновления.");
	УдалитьФайлы(КаталогАвтономногоСервера);
	УдалитьФайлы(КаталогИБ, "*.*");
КонецПроцедуры	

Процедура ТестДолжен_ОбновитьКонфигурациюСЗавершениемСеансов() Экспорт

	Если Не ЭтоWindows() Тогда
		Возврат;
	КонецЕсли;	

	// разворачиваем базу
	Если ВерсияПлатформыБольше("8.3.22") Тогда
		ФайлВыгрузки = ОбъединитьПути(ТекущийСценарий().Каталог, "fixtures", "8_3_22", "update_mono.dt");
	
		УправлениеИБ.УстановитьКонфигурационныйФайл("c:\tmp\conf-test.yml");
		УправлениеИБ.УстановитьПараметрыАвторизацииИБ("admin", "admin");
		УправлениеИБ.ЗагрузитьДанныеИБ(ФайлВыгрузки);
	Иначе
		Возврат;
	КонецЕсли;	
	// запускаем тонкий клиент через автономный сервер
	ПутьК1С = СтрЗаменить(ПолучитьПутьКIBCMD(), "ibcmd", "1Cv8c");
	Команда = """" + ПутьК1С + """ /Sff--db01\test /Nadmin /Padmin /DisableStartupMessages";
	ЗапуститьПриложение(Команда);

	// обновляем конфигурацию c завершением сеансов
	Приостановить(2000);
	УправлениеИБ.ОбновитьКонфигурациюБазыДанных("", "disable", "force");
		
	МассивПроцессов = НайтиПроцессыПоИмени("1Cv8c");
	Для Каждого Процесс Из МассивПроцессов Цикл
		Сообщить("Ид процесса " + Процесс.Идентификатор);
		Процесс.Завершить();
	КонецЦикла;	
	//Приостановить(2000);
	// проверяем, что база закрылась (отсутствие файла 1Cv8tmp.1CL)
	//Утверждения.ПроверитьИстину(ТестПрошел, "Сеанс 1С должен закрыться при обновлении.");
	
	//УдалитьФайлы(КаталогИБ, "*.*");
КонецПроцедуры

// Работа с расширениями
Процедура ТестДолжен_СоздатьРасширение() Экспорт
	УстановитьПараметрыВременнойИБ();
	ПутьКФайлуВыгрузки = ОбъединитьПути(ТекущийСценарий().Каталог, "fixtures", "8_3_21", "1Cv8.dt");
	УправлениеИБ.СоздатьИБИзФайлаВыгрузки(ПутьКФайлуВыгрузки);
	УправлениеИБ.УстановитьПараметрыАвторизацииИБ("admin", "admin");

	УправлениеИБ.СоздатьРасширение("СуперРасширение", "ср", "ru = ""Расширение для всего""", "add-on");

	Результат = УправлениеИБ.ИнформацияОРасширении("СуперРасширение");
	Утверждения.ПроверитьИстину(СтрНайти(Результат, "СуперРасширение") > 0, "Вывод команды должен содержать строку с именем расширения.");
	УдалитьФайлы(ВременныйКаталог);
КонецПроцедуры	

Процедура ТестДолжен_ПолучитьИнформациюОРасширении() Экспорт
КонецПроцедуры

Процедура ТестДолжен_ПолучитьСписокРасширений() Экспорт
	УстановитьПараметрыВременнойИБ();
	ПутьКФайлуВыгрузки = ОбъединитьПути(ТекущийСценарий().Каталог, "fixtures", "8_3_21", "1Cv8.dt");
	УправлениеИБ.СоздатьИБИзФайлаВыгрузки(ПутьКФайлуВыгрузки);
	УправлениеИБ.УстановитьПараметрыАвторизацииИБ("admin", "admin");

	УправлениеИБ.СоздатьРасширение("СуперРасширение", "ср", "ru = ""Расширение для всего""", "add-on");

	Результат = УправлениеИБ.СписокРасширений();
	Сообщить(Результат);
	Утверждения.ПроверитьИстину(СтрНайти(Результат, "СуперРасширение") > 0, "Вывод команды должен содержать строку с именем расширения.");
	УдалитьФайлы(ВременныйКаталог);
КонецПроцедуры

Процедура ТестДолжен_ИзменитьСвойстваРасширения() Экспорт
	УстановитьПараметрыВременнойИБ();
	ПутьКФайлуВыгрузки = ОбъединитьПути(ТекущийСценарий().Каталог, "fixtures", "8_3_21", "1Cv8.dt");
	УправлениеИБ.СоздатьИБИзФайлаВыгрузки(ПутьКФайлуВыгрузки);
	УправлениеИБ.УстановитьПараметрыАвторизацииИБ("admin", "admin");
	УправлениеИБ.СоздатьРасширение("СуперРасширение", "ср", "ru = ""Расширение для всего""", "add-on");
	//УправлениеИБ.ОбновитьКонфигурациюБазыДанных("СуперРасширение");
	УправлениеИБ.ИзменитьСвойстваРасширения("СуперРасширение", Ложь, Истина, Истина, Истина, Ложь, Истина);
	Результат = УправлениеИБ.ИнформацияОРасширении("СуперРасширение");
	Сообщить(Результат);
	Утверждения.ПроверитьИстину(СтрНайти(Результат, "active                       : no") > 0, "Вывод команды должен содержать строку active : no.");
	УдалитьФайлы(ВременныйКаталог);
КонецПроцедуры

Процедура ТестДолжен_УдалитьРасширение() Экспорт
	УстановитьПараметрыВременнойИБ();
	ПутьКФайлуВыгрузки = ОбъединитьПути(ТекущийСценарий().Каталог, "fixtures", "8_3_21", "1Cv8.dt");
	УправлениеИБ.СоздатьИБИзФайлаВыгрузки(ПутьКФайлуВыгрузки);
	УправлениеИБ.УстановитьПараметрыАвторизацииИБ("admin", "admin");
	УправлениеИБ.СоздатьРасширение("СуперРасширение", "ср", "ru = ""Расширение для всего""", "add-on");
	УправлениеИБ.УдалитьРасширение("СуперРасширение");
	Результат = УправлениеИБ.СписокРасширений();
	Сообщить(Результат);
	Утверждения.ПроверитьИстину(СтрНайти(Результат, "СуперРасширение") = 0, "Вывод команды не должен содержать строку с именем расширения.");
	УдалитьФайлы(ВременныйКаталог);
КонецПроцедуры

Процедура ТестДолжен_ВыгрузитьРасширениеВФайл() Экспорт
	УстановитьПараметрыТестовойИБ();
	ФайлВыгрузки = ОбъединитьПути(ТекущийСценарий().Каталог, "fixtures", "se.cfe");
	УправлениеИБ.ВыгрузитьКонфигурациюВФайл(ФайлВыгрузки, "СуперРасширение");
	Утверждения.ПроверитьИстину(ФС.ФайлСуществует(ФайлВыгрузки), "Должен быть создан файл расширения");
	УдалитьФайлы(ФайлВыгрузки);
	УдалитьФайлы(ВременныйКаталог);
КонецПроцедуры

Процедура ТестДолжен_ЗагрузитьРасширениеИзФайла() Экспорт
	УстановитьПараметрыВременнойИБ();
	Если ВерсияПлатформыБольше("8.3.22") Тогда
		ФайлРасширения = ОбъединитьПути(ТекущийСценарий().Каталог, "fixtures", "8_3_22", "se.cfe");
		ФайлВыгрузки = ОбъединитьПути(ТекущийСценарий().Каталог, "fixtures", "8_3_22", "1Cv8.dt");
	Иначе
		ФайлРасширения = ОбъединитьПути(ТекущийСценарий().Каталог, "fixtures", "8_3_21", "se.cfe");	
		ФайлВыгрузки = ОбъединитьПути(ТекущийСценарий().Каталог, "fixtures", "8_3_21", "1Cv8.dt");
	КонецЕсли;
	УправлениеИБ.СоздатьИБИзФайлаВыгрузки(ФайлВыгрузки);
	УправлениеИБ.УстановитьПараметрыАвторизацииИБ("admin", "admin");
	УправлениеИБ.СоздатьРасширение("СуперРасширение", "ср", "ru = ""Расширение для всего""", "add-on");
	УправлениеИБ.ЗагрузитьКонфигурацию(ФайлРасширения, "СуперРасширение");
	КаталогВыгрузки = ОбъединитьПути(ТекущийСценарий().Каталог, "fixtures", "files");
	УправлениеИБ.ВыгрузитьКонфигурациюВФайлы(КаталогВыгрузки, "" , "СуперРасширение", Ложь);
	ФайлОбщегоМодуля = ОбъединитьПути(КаталогВыгрузки, "CommonModules", "срОбщийМодуль1.xml");

	Утверждения.ПроверитьИстину(ФС.ФайлСуществует(ФайлОбщегоМодуля), "В расширении должен быть файл общего модуля");
	УдалитьФайлы(КаталогВыгрузки);
	УдалитьФайлы(ВременныйКаталог);
		
КонецПроцедуры	

Процедура ТестДолжен_ЗагрузитьВыбранныеФайлыКонфигурации() Экспорт

	// Дано
	УстановитьПараметрыВременнойИБ();
	Если ВерсияПлатформыБольше("8.3.22") Тогда
		ФайлВыгрузки = ОбъединитьПути(ТекущийСценарий().Каталог, "fixtures", "8_3_22", "1Cv8.dt");
	ИначеЕсли ВерсияПлатформыБольше("8.3.21") Тогда
		ФайлВыгрузки = ОбъединитьПути(ТекущийСценарий().Каталог, "fixtures", "8_3_21", "1Cv8.dt");
	Иначе
		ФайлВыгрузки = ОбъединитьПути(ТекущийСценарий().Каталог, "fixtures", "1.0", "1C.dt");
	КонецЕсли;
	КаталогВыгрузки = ПолныйПутьШаблонаДанных(  "1.0", "files");
	УправлениеИБ.СоздатьИБИзФайлаВыгрузки(ФайлВыгрузки);

	ВыбранныеФайлы = Новый Массив;
	ВыбранныеФайлы.Добавить("Configuration.xml");
	ВыбранныеФайлы.Добавить("Languages/Русский.xml");
	ВыбранныеФайлы.Добавить("Roles/ПолныеПрава.xml");
	ВыбранныеФайлы.Добавить("Roles/ПолныеПрава/Ext/Rights.xml");
	
	// Когда
	УправлениеИБ.ЗагрузитьВыбранныеФайлыКонфигурации(КаталогВыгрузки, ВыбранныеФайлы, "", Истина);

	// Тогда
	ВыводКоманды = УправлениеИБ.ВыводПоследнейКоманды();
	ИмпортУспешноЗавершен = СтрЧислоВхождений(ВыводКоманды, "Импорт файлов конфигурации из XML успешно завершен") > 0
		ИЛИ СтрЧислоВхождений(ВыводКоманды, "The configuration files are imported from XML") > 0;
	Утверждения.ПроверитьИстину(ИмпортУспешноЗавершен, 
		"Импорт файлов конфигурации из XML должен быть успешно завершен");
	
	УдалитьФайлы(ВременныйКаталог);

КонецПроцедуры

Процедура ТестДолжен_ЗагрузитьВыбранныйФайлКонфигурации() Экспорт

	// Дано
	УстановитьПараметрыВременнойИБ();
	Если ВерсияПлатформыБольше("8.3.22") Тогда
		ФайлВыгрузки = ОбъединитьПути(ТекущийСценарий().Каталог, "fixtures", "8_3_22", "1Cv8.dt");
	ИначеЕсли ВерсияПлатформыБольше("8.3.21") Тогда
		ФайлВыгрузки = ОбъединитьПути(ТекущийСценарий().Каталог, "fixtures", "8_3_21", "1Cv8.dt");
	Иначе
		ФайлВыгрузки = ОбъединитьПути(ТекущийСценарий().Каталог, "fixtures", "1.0", "1C.dt");
	КонецЕсли;
	КаталогВыгрузки = ПолныйПутьШаблонаДанных(  "1.0", "files");
	УправлениеИБ.СоздатьИБИзФайлаВыгрузки(ФайлВыгрузки);
	
	ВыбранныеФайлы = Новый Массив;
	ВыбранныеФайлы.Добавить("Configuration.xml");
	
	// Когда
	УправлениеИБ.ЗагрузитьВыбранныеФайлыКонфигурации(КаталогВыгрузки, ВыбранныеФайлы, "", Истина);

	// Тогда
	ВыводКоманды = УправлениеИБ.ВыводПоследнейКоманды();
	ИмпортУспешноЗавершен = СтрЧислоВхождений(ВыводКоманды, "Импорт файлов конфигурации из XML успешно завершен") > 0
		ИЛИ СтрЧислоВхождений(ВыводКоманды, "The configuration files are imported from XML") > 0;
	Утверждения.ПроверитьИстину(ИмпортУспешноЗавершен, 
		"Импорт файлов конфигурации из XML должен быть успешно завершен");
	
	УдалитьФайлы(ВременныйКаталог);

КонецПроцедуры

Процедура ТестДолжен_ВернутьНомерВерсии() Экспорт

	// Когда
	НомерВерсии = УправлениеИБ.Версия();

	// Тогда
	РегулярноеВыражение = Новый РегулярноеВыражение("^(\d+)\.(\d+)\.(\d+)\.(\d+)\z");
	РегулярноеВыражение.Совпадает(НомерВерсии);
	Утверждения.ПроверитьИстину(РегулярноеВыражение.Совпадает(НомерВерсии), 
		"Номер версии должен соотвествовать шаблону");

КонецПроцедуры

Процедура ТестДолжен_ПолучитьОписанияРасширений() Экспорт
	УстановитьПараметрыВременнойИБ();
	ПутьКФайлуВыгрузки = ОбъединитьПути(ТекущийСценарий().Каталог, "fixtures", "8_3_21", "1Cv8.dt");
	УправлениеИБ.СоздатьИБИзФайлаВыгрузки(ПутьКФайлуВыгрузки);
	УправлениеИБ.УстановитьПараметрыАвторизацииИБ("admin", "admin");

	УправлениеИБ.СоздатьРасширение("СуперРасширение", "ср", "ru = ""Расширение для всего""", "add-on");

	ОписанияРасширений = УправлениеИБ.ОписанияРасширений();
	Утверждения.ПроверитьТип(ОписанияРасширений, "Массив", "Метод должен вернуть массив");
	Утверждения.ПроверитьИстину(ОписанияРасширений.Количество() = 1, "Метод должен вернуть массив с одним элементом");
	ОписаниеРасширения = ОписанияРасширений[0];
	Утверждения.ПроверитьТип(ОписаниеРасширения, "Соответствие", "Описание расширения должно быть соответствием");
	Утверждения.ПроверитьИстину(ОписаниеРасширения.Получить("name") = "СуперРасширение", 
		"В описании расширения должно быть свойство name с именем расширения");
	
	УдалитьФайлы(ВременныйКаталог);
КонецПроцедуры

Процедура ТестДолжен_СоздатьПустуюФайловуюБазу() Экспорт

	// Дано
	УстановитьПараметрыВременнойИБ();

	// Когда
	УправлениеИБ.СоздатьИБ();
	
	// Тогда
	ФайлБазыДанных = ОбъединитьПути(ВременныйКаталог, "1Cv8.1CD");
	Утверждения.ПроверитьИстину(ФС.ФайлСуществует(ФайлБазыДанных), 
		"Должен быть создан файл базы данных во временном каталоге");
	УдалитьФайлы(ВременныйКаталог);
	
КонецПроцедуры

Функция ПолучитьПутьКIBCMD()
	Возврат ПолучитьПеременнуюСреды("IBCMD_PATH", РасположениеПеременнойСреды.Процесс);
КонецФункции	

Функция ВерсияПлатформыБольше(Версия)
	Рез = Ложь;
	РезультатСравнения = УправлениеИБ.СравнитьВерсии(УправлениеИБ.Версия(), Версия);
	Если РезультатСравнения > 0 Тогда
		Рез = Истина;
	КонецЕсли;	
	Возврат Рез;
КонецФункции	

Функция ЭтоWindows()
	СИ = Новый СистемнаяИнформация();
	Если СтрНайти(СИ.ВерсияОС, "windows") > 0 Тогда
		Возврат Истина;
	КонецЕсли;	
	Возврат Ложь;
КонецФункции	

Процедура УстановитьПараметрыВременнойИБ()
	ВременныйКаталог = ОбъединитьПути(КаталогВременныхФайлов(), "tmp_db");
	УдалитьФайлы(ВременныйКаталог);
	ФС.ОбеспечитьКаталог(ВременныйКаталог);
	
	УправлениеИБ.УстановитьПараметрыФайловойИБ(ВременныйКаталог);
	УправлениеИБ.УстановитьПараметрыАвтономногоСервера(ВременныйКаталог);
КонецПроцедуры	

Процедура УстановитьПараметрыТестовойИБ()
	ВременныйКаталог = ОбъединитьПути(КаталогВременныхФайлов(), "tmp_db");
	УдалитьФайлы(ВременныйКаталог);

    Если ВерсияПлатформыБольше("8.3.22") Тогда
		КаталогИБ = ОбъединитьПути(ТекущийСценарий().Каталог, "fixtures", "8_3_22", "db");
	ИначеЕсли ВерсияПлатформыБольше("8.3.21") Тогда
		КаталогИБ = ОбъединитьПути(ТекущийСценарий().Каталог, "fixtures", "8_3_21", "db");	
	Иначе	
		КаталогИБ = ОбъединитьПути(ТекущийСценарий().Каталог, "fixtures", "1.0", "db");
	КонецЕсли;	
	УправлениеИБ.УстановитьПараметрыФайловойИБ(КаталогИБ);
	УправлениеИБ.УстановитьПараметрыАвторизацииИБ("admin", "admin");
	УправлениеИБ.УстановитьПараметрыАвтономногоСервера(ВременныйКаталог);
КонецПроцедуры	

Функция ПолныйПутьШаблонаДанных(ЧастьКаталога1, ЧастьКаталога2 = "", ЧастьКаталога3 = "")
	КорневойПутьШаблонов = ОбъединитьПути(ТекущийСценарий().Каталог, "fixtures");
	Возврат ОбъединитьПути(КорневойПутьШаблонов, ЧастьКаталога1, ЧастьКаталога2, ЧастьКаталога3);
КонецФункции

//////////////////////////////////////////////////////////////////////////////////////
// Инициализация

// УстановитьПеременнуюСреды("IBCMD_PATH","""c:\Program Files\1cv8\8.3.22.1704\bin\ibcmd""" , РасположениеПеременнойСреды.Процесс);
Инициализация();
