Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262604AbTBJT2y>; Mon, 10 Feb 2003 14:28:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262780AbTBJT2x>; Mon, 10 Feb 2003 14:28:53 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:54540 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262604AbTBJT2w>; Mon, 10 Feb 2003 14:28:52 -0500
Date: Mon, 10 Feb 2003 19:38:35 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: linux-kernel@vger.kernel.org
Subject: Re: The Linux Kernel and Castle Technology Ltd, UK
Message-ID: <20030210193835.D15661@flint.arm.linux.org.uk>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20030207151926.A30927@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030207151926.A30927@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Fri, Feb 07, 2003 at 03:19:26PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Castle Technology Limited ask me to post this press release to the
Linux Kernel mailing list.

By posting this press release, I wish to make it absolutely clear
that I am not expressing any views either way with respect to this
press release, merely passing the information on as requested.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

-----------------------------[ cut here ]----------------------------

PRESS RELEASE

10th February 2003

Castle Technology Limited note with interest the recent discussion
regarding their IYONIX computer, the world's first desktop computer
to use the Intel XScale processor.

Following discussions with Russell King and with this in mind, Castle
should like to respond to claims originally proposed in Justin Fletcher's
"ReadMe.txt" file and Russell King's subsequent posting to the Linux
Kernel Mailing List.

The RISC OS 5.00 kernel did not contain work taken from or derived from
the ARM-Linux or Linux kernel.

The RISC OS 5.01 kernel did not contain work taken from or derived from
the ARM-Linux or Linux kernel.

The RISC OS 5.02 kernel does not contain work taken from or derived from
the ARM-Linux or Linux kernel.

There are no plans to use GPL derived code in any part of the RISC OS
kernel in the future.

For the avoidance of doubt, the hardware abstraction layer (roughly
analogous to a PC's BIOS) has it's PCI allocation and bridge setup
based in part on the following functions from the Linux kernel sources:
 
 pci_alloc_primary_bus
 pbus_size_bridges
 pbus_assign_resources_sorted
 pci_setup_bridge
 pci_bridge_check_ranges
 pbus_size_mem
 pbus_assign_resources
 pci_assign_unassigned_resources
 pci_scan_bus
 pcibios_update_resource
 pci_read_bases
 pci_alloc_bus
 pci_add_new_bus
 pci_do_scan_bus
 pci_scan_bridge
 pci_setup_device
 pci_scan_device
 pci_scan_slot
 pcibios_fixup_bus
 pci_calc_resource_flags
 pci_size
 pdev_fixup_device_resources
 pbus_assign_bus_resources
 pci_do_scan_bus
 pcibios_fixup_pbus_ranges
 pci_assign_resource
 pdev_sort_resources
 pdev_enable_device
 pbus_size_io

Any company or individual wishing to receive a copy of the source code
to this component should apply in writing to:

 The Managing Director
 Castle Technology Ltd
 Ore Trading Estate
 Woodbridge Road
 Framlingham
 Suffolk
 IP13 9LL

enclosing a formatted 3.5" floppy diskette and return postage stamps,
or international reply coupons for those outside the United Kingdom.

These sources will also form an integral part of a forthcoming Linux
port to the IYONIX.

With the tough goal of fitting all of the supporting software and
applications for the IYONIX computer into just 4Mbytes of ROM, later
issues of the supporting software have had to have function names
removed (along with a strategy of tokenising textual messages and
compressing binaries) to make room for, in particular, the support
for the 'boot keyboard' USB drivers.

Issued by Mike Williams on behalf of Castle Technology Ltd
