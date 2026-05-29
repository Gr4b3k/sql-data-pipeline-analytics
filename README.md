# SQL Data Pipeline

Projekt prezentuje kompletny proces przygotowania danych do analizy biznesowej z wykorzystaniem czystego SQL.  
Pipeline obejmuje: warstwę staging, kontrolę jakości danych, czyszczenie, budowę tabel wymiarów i faktów (model gwiazdy), a także finalny widok analityczny gotowy do raportowania.

---

##  Cel projektu

Celem projektu jest pokazanie, jak z surowych danych stworzyć **spójny, czysty i analitycznie użyteczny model danych**, który może być wykorzystany w narzędziach BI.

---

##  Struktura repozytorium

/data
    sales_data.csv

/sql
    01_staging.sql
    02_data_quality_and_cleaning.sql
    03_dim_tables.sql
    04_fact_table.sql
    05_analytical_view.sql

/screenshots
    dim_category.png
    dim_customer.png
    dim_date.png
    dim_product.png
    fact_sales.png
    staging.png
    vw_sales_analysis.png

README.md

---

##  Pipeline danych

### **Staging**
- import surowych danych  
- wstępne typowanie kolumn  
- brak transformacji (zasada: *as raw as possible*)

### **Kontrola jakości i czyszczenie**
- usuwanie duplikatów  
- walidacja nulli  
- poprawa typów danych  
- sanity checks  

### **Tabele wymiarów (DIM)**
- dim_customer  
- dim_product  
- dim_category  
- dim_date  

### **Tabela faktów (FACT)**
- fact_sales  
- klucze obce do DIM  
- wartości atomowe: quantity, price_each, total_price, cost_price  

### **Widok analityczny**
- połączenie DIM + FACT  
- kolumny obliczeniowe  
- finalny dataset gotowy do raportowania  

---

##  Opis kolumn widoku analitycznego

###  Identyfikatory i klucze
- **order_id** — unikalny identyfikator zamówienia.  
- **product_id** — klucz obcy do produktu.  
- **category_id** — klucz obcy do kategorii.  
- **customer_id** — klucz obcy do klienta.  
- **date_key** — klucz obcy do tabeli dat.  
- **order_date** — data i czas złożenia zamówienia.  

###  Atrybuty opisowe
- **product_name** — nazwa produktu.  
- **category_name** — nazwa kategorii.  
- **customer_address** — adres klienta.  

###  Wartości atomowe (FACT)
- **quantity** — liczba sprzedanych sztuk.  
- **price_each** — cena jednostkowa.  
- **cost_price** — koszt zakupu produktu.  

###  Kolumny obliczeniowe
- **turnover** — przychód z pozycji zamówienia (`quantity * price_each`).  
- **margin** — marża kwotowa (`(price_each - cost_price) * quantity`).  
- **margin_pct** — marża procentowa (`margin / turnover`).  
- **unit_margin** — marża jednostkowa (`price_each - cost_price`).  
- **markup_pct** — narzut procentowy (`unit_margin / cost_price`).  

###  Atrybuty czasu
- **year** — rok.  
- **month** — numer miesiąca.  
- **month_name** — nazwa miesiąca.  
- **quarter** — kwartał.  
- **is_weekday** — czy dzień jest roboczy.  

###  Atrybuty klienta
- **is_returning_customer** — TRUE, jeśli klient dokonał wcześniejszego zakupu.  

---

## Zrzuty ekranu (wybrane)

### **Staging (surowe dane)**
*![Staging](https://github.com/Gr4b3k/sql-data-pipeline-analytics/blob/c3093d5efa4f11dc0a57ddb11900b0d29bec6466/screenshots/staging.png)*

### **Tabela faktów — fact_sales**
*![Fact Sales](https://github.com/Gr4b3k/sql-data-pipeline-analytics/blob/f4d928aeef49b5fafec0e732ccc8758976013b44/screenshots/fact_sales.png)*

### **Widok analityczny (fragment)**
*![Analytics view](https://github.com/Gr4b3k/sql-data-pipeline-analytics/blob/f4d928aeef49b5fafec0e732ccc8758976013b44/screenshots/vw_sales_ananlysis.png)*

> Cały zasób zrzutów ekranu znajdują się w folderze `/screenshots`.

---
  
