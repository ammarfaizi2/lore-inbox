Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261323AbVCCEEe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261323AbVCCEEe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 23:04:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261367AbVCCEEd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 23:04:33 -0500
Received: from falcon.csc.calpoly.edu ([129.65.242.5]:37250 "EHLO
	falcon.csc.calpoly.edu") by vger.kernel.org with ESMTP
	id S261323AbVCCECW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 23:02:22 -0500
Date: Wed, 2 Mar 2005 20:02:16 -0800 (PST)
From: Joshua Hudson <jwhudson@hornet.csc.calpoly.edu>
To: Dmitry Torokhov <dtor_core@ameritech.net>
cc: Joshua Hudson <jwhudson@hornet.csc.calpoly.edu>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Bug report -- keyboard not working Linux 2.6.11 on Inspiron 1150
In-Reply-To: <200503022200.18697.dtor_core@ameritech.net>
Message-ID: <Pine.GSO.4.44.0503021959520.14602-100000@hornet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


PCI: Using ACPI for IRQ routing
ACPI: AC Adapter [AC] (on-line)
ACPI: Battery Slot [BAT0] (battery present)
ACPI: Lid Switch [LID]
ACPI: Power Button (CM) [PBTN]
ACPI: Sleep Button (CM) [SBTN]
ACPI: Video Device [VID] (multi-head: yes  rom: no  post: no)
ACPI: Video Device [VID2] (multi-head: yes  rom: no  post: no)
ACPI: CPU0 (power states: C1[C1] C2[C2])
ACPI: Processor [CPU0] (supports 8 throttling states)
ACPI: Thermal Zone [THM] (59 C)
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
ACPI: PCI interrupt 0000:00:02.0[A] -> GSI 11 (level, low) -> IRQ 11
ACPI: PS/2 Keyboard Controller [KBC] at I/O 0x60, 0x66, irq 1
ACPI: PS/2 Mouse Controller [PS2M] at irq 12
i8042.c: Can't read CTR while initializing i8042.
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 7
ACPI: PCI interrupt 0000:00:1f.6[B] -> GSI 7 (level, low) -> IRQ 7
ACPI: PCI interrupt 0000:02:01.0[A] -> GSI 7 (level, low) -> IRQ 7
ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI interrupt 0000:02:04.0[A] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 11
ACPI: PCI interrupt 0000:00:1d.7[D] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI interrupt 0000:00:1d.0[A] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
ACPI: PCI interrupt 0000:00:1d.1[B] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
ACPI: PCI interrupt 0000:00:1d.2[C] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 7 (level, low) -> IRQ 7
ACPI wakeup devices:
ACPI: (supports S0 S1 S3 S4 S4bios S5)

More like it, hmmm?

