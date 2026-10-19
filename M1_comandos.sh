#!/usr/bin/env bash
# Modulo 1: Introduccion a Unix y repositorios
# Practica de nivelacion en transcriptomica

# Mostrar el directorio de trabajo actual
pwd

# ==========================================
# Inspección de un archivo FASTQ de ENA
# Organismo: Magallana gigas
# Run: SRR11285537
# Archivo: R1 (paired-end)
# ==========================================

# Descargar el archivo FASTQ R1 desde ENA.
wget "ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR112/037/SRR11285537/SRR11285537_1.fastq.gz"

# Mostrar las primeras 8 líneas.
zcat < SRR11285537_1.fastq.gz | head -8

# Contar todas las líneas del FASTQ descomprimido.
zcat < SRR11285537_1.fastq.gz | wc -l

# Resultado obtenido: 31,895,736 líneas.
# Cada read ocupa 4 líneas.
# Número de reads R1: 31,895,736 / 4 = 7,973,934.

# Conteo de genes anotados por cromosoma en Magallana gigas
# Ensamblaje: xbMagGiga1.1 (RefSeq GCF_963853765.1)
grep $'\tgene\t' genomic.gtf | cut -f1 | sort | uniq -c | grep 'NC_' > genes_por_cromosoma.txt

# Filtrado de muestras de branquias (gill) de Magallana gigas (Tax ID: 29159)
# Fuente: ENA, Advanced Search, Raw reads (read_run)
# Entrada: results_read_run.tsv
# Salida: muestras_gill.tsv
# Criterio: columna 2 (tissue_type) = gill o gills 

# Se conservan los encabezados y las filas cuyo tejido es gill o gills
awk -F '\t' 'NR == 1 || tolower($2) == "gill" || tolower($2) == "gills"' results_read_run.tsv > muestras_gill.tsv