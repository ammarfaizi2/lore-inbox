Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284913AbRLKHhO>; Tue, 11 Dec 2001 02:37:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284918AbRLKHhF>; Tue, 11 Dec 2001 02:37:05 -0500
Received: from front1.mail.megapathdsl.net ([66.80.60.31]:14344 "EHLO
	front1.mail.megapathdsl.net") by vger.kernel.org with ESMTP
	id <S284913AbRLKHgu>; Tue, 11 Dec 2001 02:36:50 -0500
Date: Mon, 10 Dec 2001 23:39:03 -0800 (PST)
From: Miles Lane <miles@megapathdsl.net>
To: <linux-kernel@vger.kernel.org>
Subject: 2.5.1-pre9 -- Unresolved symbols in scsi_mod.o
Message-ID: <Pine.LNX.4.33.0112102333310.9791-100000@stomata.megapathdsl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


depmod: *** Unresolved symbols in /lib/modules/2.5.1-pre9/kernel/drivers/scsi/scsi_mod.o
depmod: 	blk_contig_segment
depmod: 	bio_hw_segments
depmod: 	blk_queue_segment_boundary


#
# Automatically generated make config: don't edit
#
CONFIG_X86=y
CONFIG_ISA=y
CONFIG_UID16=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_KMOD=y

#
# Processor type and features
#
CONFIG_MK7=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_USE_3DNOW=y
CONFIG_X86_PGE=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_NOHIGHMEM=y

#
# General setup
#
CONFIG_NET=y
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_NAMES=y
CONFIG_HOTPLUG=y

#
# PCI Hotplug Support
#
CONFIG_HOTPLUG_PCI=m
CONFIG_HOTPLUG_PCI_COMPAQ=m
CONFIG_HOTPLUG_PCI_COMPAQ_NVRAM=y
CONFIG_SYSVIPC=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_AOUT=y
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=y
CONFIG_PM=y
CONFIG_ACPI=y
CONFIG_ACPI_DEBUG=y
CONFIG_ACPI_BUSMGR=m
CONFIG_ACPI_SYS=m
CONFIG_ACPI_CPU=m
CONFIG_ACPI_BUTTON=m
CONFIG_ACPI_AC=m
CONFIG_ACPI_EC=m
CONFIG_ACPI_CMBATT=m
CONFIG_ACPI_THERMAL=m

#
# SCSI support
#
CONFIG_SCSI=m

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=m
CONFIG_SD_EXTRA_DEVS=40
CONFIG_BLK_DEV_SR=m
CONFIG_BLK_DEV_SR_VENDOR=y
CONFIG_SR_EXTRA_DEVS=2
CONFIG_CHR_DEV_SG=m

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
CONFIG_SCSI_CONSTANTS=y

#
# SCSI low-level drivers
#
CONFIG_SCSI_AIC7XXX=m
CONFIG_AIC7XXX_CMDS_PER_DEVICE=253
CONFIG_AIC7XXX_RESET_DELAY_MS=15000

