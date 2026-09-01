# Changelog

All notable changes to the TEcandidates pipeline are documented in this file.

## [V4] - 2026-08-31

### Added
- Containerized pipeline using Podman/Docker.
- `Dockerfile` based on Ubuntu 20.04 with Miniconda.
- `environment.yml` with conda-forge and bioconda channels.
- Automatic validation of Bedtools, Bowtie2, Samtools and Trinity.
- Timestamp at start and end of execution with total elapsed time.
- Diagnostic messages during pre-mapping (number of aligned reads and reads intersecting TEs).
- Support for multiple samples without recreating the BED file each time.

### Changed
- Replaced glob-based file search with `find` for robust FASTQ discovery, including subdirectories.
- Updated pre-mapping to sort and index BAM files before filtering with `samtools view -L`.
- Replaced BioPerl `parseFasta.pl` with native `perl -pe` one-liner.
- Modified read name headers automatically to include `/1` (single-end) or `/1` and `/2` (paired-end), as required by Trinity.
- Cleaned temporary files (SAM, BAM, BAI) after processing to save disk space.

### Fixed
- Removed unsupported `--threads` flag from `samtools fastq`.
- Fixed BAM sorting issue that caused empty filtered FASTQ files.
- Fixed read name formatting for SRA-derived FASTQ files.
- Fixed BED file removal inside sample loop, now created once and removed at the end.
- Fixed Python/Perl dependency conflicts in older versions.

### Removed
- BioPerl dependency.
- Obsolete version checks for exact old tool versions (e.g., bedtools 2.25.0, bowtie2 2.3.0).
- Redundant `grep` filtering in paired-end pre-mapping.

## [V2.0.3] - Original version

- Original Bash script with strict version checks and BioPerl dependency.
- Paired-end mode incomplete in some versions.
- Pre-mapping did not sort BAM files and used `bedtools intersect` directly.
