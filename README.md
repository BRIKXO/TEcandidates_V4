# TEcandidates V4

TEcandidates is a pipeline to include transposable elements (TEs) in RNA-seq differential expression analysis.

This repository contains a **modernized version** of the original TEcandidates pipeline, containerized with Podman/Docker to ensure reproducibility and portability across different computing environments.

---

## What's new in V4?

- Containerized using **Podman** (or Docker)
- Removed **BioPerl** dependency
- Updated for compatibility with modern versions of Bedtools, Bowtie2, Samtools and Trinity
- Fixed BAM sorting and indexing during pre-mapping
- Automatic correction of read names for Trinity (`/1` and `/2` suffixes)
- Supports multiple samples without recreating intermediate files
- Added execution time report
- Maintains strand-specific candidate selection (`bedtools coverage -s -a`) for higher specificity

---

## Requirements

You only need:

- **Podman** or Docker installed on your Linux machine.
- **SRA Toolkit** to download the test FASTQ files.
- At least **10 GB of free disk space** for the test data and results.

---

## Installation / Build

Clone this repository and build the container image:

```bash
git clone https://github.com/BRIKXO/TEcandidates_V4.git
cd TEcandidates_V4
sudo apt install podman
podman build -t tecandidates:latest .
