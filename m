Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265585AbSKAD0o>; Thu, 31 Oct 2002 22:26:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265586AbSKAD0o>; Thu, 31 Oct 2002 22:26:44 -0500
Received: from paloma14.e0k.nbg-hannover.de ([62.181.130.14]:58875 "HELO
	paloma14.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S265585AbSKAD0n> convert rfc822-to-8bit; Thu, 31 Oct 2002 22:26:43 -0500
From: Dieter =?iso-8859-15?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: 2.5.45: IDE as modules - unresolved symbols
Date: Fri, 1 Nov 2002 04:33:07 +0100
User-Agent: KMail/1.4.7
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Message-Id: <200211010433.07804.Dieter.Nuetzel@hamburg.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

depmod: *** Unresolved symbols in 
/lib/modules/2.5.45/kernel/drivers/ide/ide-disk.o
depmod:         proc_ide_read_geometry
/lib/modules/2.5.45/kernel/drivers/ide/ide-disk.o
/lib/modules/2.5.45/kernel/drivers/ide/ide-geometry.o
/lib/modules/2.5.45/kernel/drivers/ide/ide-iops.o
/lib/modules/2.5.45/kernel/drivers/ide/ide-lib.o
depmod: *** Unresolved symbols in 
/lib/modules/2.5.45/kernel/drivers/ide/ide-probe.o
depmod:         do_ide_request
depmod:         ide_add_generic_settings
depmod:         ide_bus_type
depmod:         create_proc_ide_interfaces
/lib/modules/2.5.45/kernel/drivers/ide/ide-probe.o
/lib/modules/2.5.45/kernel/drivers/ide/ide-taskfile.o
depmod: *** Unresolved symbols in /lib/modules/2.5.45/kernel/drivers/ide/ide.o
depmod:         ide_release_dma
depmod:         ide_add_proc_entries
depmod:         ide_scan_pcibus
depmod:         proc_ide_read_capacity
depmod:         proc_ide_create
depmod:         ide_remove_proc_entries
depmod:         destroy_proc_ide_drives
depmod:         proc_ide_destroy
depmod:         create_proc_ide_interfaces
/lib/modules/2.5.45/kernel/drivers/ide/ide.o
depmod: *** Unresolved symbols in 
/lib/modules/2.5.45/kernel/drivers/ide/pci/amd74xx.o
depmod:         ide_setup_dma_Rsmp_247a1a8a
depmod:         ide_setup_pci_device_Rsmp_e3b2c5c5
depmod:         ide_pci_register_driver_Rsmp_1ee3fe52
depmod:         ide_pci_unregister_driver_Rsmp_f0e81386
depmod:         ide_pci_register_host_proc
/lib/modules/2.5.45/kernel/drivers/ide/pci/amd74xx.o

x86 (Athlon SMP)

Thanks,
	Dieter
