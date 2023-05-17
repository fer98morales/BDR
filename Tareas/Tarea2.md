# Tarea: Convierte tu base de datos no estructurada en un modelo entidad-relación

# Diagrama entidad-relación


## Nivel 1: Relaciones entre las entidades
A continuación se presenta el diagrama entidad-relación en el nivel 1, donde se muestran las relaciones entre las entidades:

```mermaid
flowchart TD
Entidad1[business]
Entidad2[checkin]
Entidad3[review]
Entidad4[tip]
Entidad5[user]

Entidad2 -- "1" --- R1{Realiza check-in en} -- "1" --- Entidad1
Entidad3 -- "N" --- R2{Opina sobre} --"1" --- Entidad1
Entidad4 -- "N" --- R3{Brinda consejos sobre} --"1" --- Entidad1
Entidad3 -- "N" --- R4{Recibe opiniones de} --"1" --- Entidad5
Entidad4 -- "N" --- R5{Recibe consejos de} --"1" --- Entidad5
```

## Nivel 2: Entidades y sus atributos
A continuación se presenta el diagrama entidad-relación en el nivel 2, donde se detallan las entidades y sus atributos:

### Entidad 1: Business
```mermaid
flowchart LR
Entidad1[business]
    Entidad1 --- E1_Atributo1([<u>business_id</u>]) --- E1_D1{{"TEXTO (100)"}}
    Entidad1 --- E1_Atributo2([name]) --- E1_D2{{"TEXTO (100)"}}
    Entidad1 --- E1_Atributo3([address]) --- E1_D3{{"TEXTO (100)"}}
    Entidad1 --- E1_Atributo4([city]) --- E1_D4{{"TEXTO (100)"}}
    Entidad1 --- E1_Atributo5([state]) --- E1_D5{{"TEXTO (100)"}}
    Entidad1 --- E1_Atributo6([postal_code]) --- E1_D6{{"NUMERO > 0"}}
    Entidad1 --- E1_Atributo7([latitude]) --- E1_D7{{"NUMERO > 0"}}
    Entidad1 --- E1_Atributo8([longitude]) --- E1_D8{{"NUMERO < 0"}}
    Entidad1 --- E1_Atributo9([stars]) --- E1_D9{{"NUMERO > 0"}}
    Entidad1 --- E1_Atributo10([review_count]) --- E1_D10{{"NUMERO > 0"}}
    Entidad1 --- E1_Atributo11([is_open]) --- E1_D11{{"NUMERO > 0"}}
    Entidad1 --- E1_Atributo12([ByAppointmentOnly]) --- E1_D12{{"TEXTO (20)"}}
    Entidad1 --- E1_Atributo13([BusinessAcceptsCreditCards]) --- E1_D13{{"TEXTO (20)"}}
    Entidad1 --- E1_Atributo21([categories]) --- E1_D21{{"TEXTO (100)"}}
    Entidad1 --- E1_Atributo14([Monday]) --- E1_D14{{"TEXTO (100)"}}
    Entidad1 --- E1_Atributo15([Tuesday]) --- E1_D15{{"TEXTO (100)"}}
    Entidad1 --- E1_Atributo16([Wednesday]) --- E1_D16{{"TEXTO (100)"}}
    Entidad1 --- E1_Atributo17([Thursday]) --- E1_D17{{"TEXTO (100)"}}
    Entidad1 --- E1_Atributo18([Friday]) --- E1_D18{{"TEXTO (100)"}}
    Entidad1 --- E1_Atributo19([Saturday]) --- E1_D19{{"TEXTO (100)"}}
    Entidad1 --- E1_Atributo20([Sunday]) --- E1_D20{{"TEXTO (100)"}}
```

### Entidad 2: Checkin
```mermaid
flowchart LR
Entidad2[checkin]
    Entidad2 --- E2_Atributo1([<u>business_id</u>]) --- E2_D1{{"TEXTO (100)"}}
    Entidad2 --- E2_Atributo2([date]) --- E2_D2{{"TEXTO (100)"}}
```
### Entidad 3: Review
```mermaid
flowchart LR
Entidad3[review]
    Entidad3 --- E3_Atributo1([review_id]) --- E3_D1{{"TEXTO (100)"}}
    Entidad3 --- E3_Atributo2([user_id</u>]) --- E3_D2{{"TEXTO (100)"}}
    Entidad3 --- E3_Atributo3([<u>business_id</u>]) --- E3_D3{{"TEXTO (100)"}}
    Entidad3 --- E3_Atributo4([stars]) --- E3_D4{{"NUMERO > 0"}}
    Entidad3 --- E3_Atributo5([useful]) --- E3_D5{{"NUMERO"}}
    Entidad3 --- E3_Atributo6([funny]) --- E3_D6{{"NUMERO"}}
    Entidad3 --- E3_Atributo7([cool]) --- E3_D7{{"NUMERO"}}
    Entidad3 --- E3_Atributo8([text]) --- E3_D8{{"TEXTO (100)"}}
    Entidad3 --- E3_Atributo9([date]) --- E3_D9{{"FECHA"}}
```

### Entidad 4: Tip
```mermaid
flowchart LR
    Entidad4[tip]
    Entidad4 --- E4_Atributo1([<u>user_id</u>]) --- E4_D1{{"TEXTO (100)"}}
    Entidad4 --- E4_Atributo2([<u>business_id</u>]) --- E4_D2{{"TEXTO (100)"}}
    Entidad4 --- E4_Atributo3([text]) --- E4_D3{{"TEXTO (100)"}}
    Entidad4 --- E4_Atributo4([date]) --- E4_D4{{"TEXTO (100)"}}
    Entidad4 --- E4_Atributo5([compliment_count]) --- E4_D5{{"TEXTO (100)"}}
```

### Entidad 5: User
```mermaid
flowchart LR
    Entidad5[user]
    Entidad5 --- E5_Atributo1([<u>user_id</u>]) --- E5_D1{{"TEXTO (100)"}}
    Entidad5 --- E5_Atributo2([name]) --- E5_D2{{"TEXTO (100)"}}
    Entidad5 --- E5_Atributo3([review_count]) --- E5_D3{{"NUMERO > 0"}}
    Entidad5 --- E5_Atributo4([yelping_since]) --- E5_D4{{"FECHA"}}
    Entidad5 --- E5_Atributo5([useful]) --- E5_D5{{"NUMERO > 0"}}
    Entidad5 --- E5_Atributo6([funny]) --- E5_D6{{"NUMERO > 0"}}
    Entidad5 --- E5_Atributo7([cool]) --- E5_D7{{"NUMERO > 0"}}
    Entidad5 --- E5_Atributo8([elite]) --- E5_D8{{"NUMERO > 0"}}
    Entidad5 --- E5_Atributo9([friends]) --- E5_D9{{"TEXTO (100)"}}
    Entidad5 --- E5_Atributo10([fans]) --- E5_D10{{"NUMERO > 0"}}
    Entidad5 --- E5_Atributo11([average_stars]) --- E5_D11{{"NUMERO > 0"}}
    Entidad5 --- E5_Atributo12([compliment_hot]) --- E5_D12{{"NUMERO > 0"}}
    Entidad5 --- E5_Atributo13([compliment_more]) --- E5_D13{{"NUMERO > 0"}}
    Entidad5 --- E5_Atributo14([compliment_profile]) --- E5_D14{{"NUMERO > 0"}}
    Entidad5 --- E5_Atributo15([compliment_cute]) --- E5_D15{{"NUMERO > 0"}}
    Entidad5 --- E5_Atributo16([compliment_list]) --- E5_D16{{"NUMERO > 0"}}
    Entidad5 --- E5_Atributo17([compliment_note]) --- E5_D17{{"NUMERO > 0"}}
    Entidad5 --- E5_Atributo18([compliment_plain]) --- E5_D18{{"NUMERO > 0"}}
    Entidad5 --- E5_Atributo19([compliment_cool]) --- E5_D19{{"NUMERO > 0"}}
    Entidad5 --- E5_Atributo20([compliment_funny]) --- E5_D20{{"NUMERO > 0"}}
    Entidad5 --- E5_Atributo21([compliment_writer]) --- E5_D21{{"NUMERO > 0"}}
    Entidad5 --- E5_Atributo22([compliment_photos]) --- E5_D22{{"NUMERO > 0"}}
```