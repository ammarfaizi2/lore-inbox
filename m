Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130977AbRCJJu3>; Sat, 10 Mar 2001 04:50:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130971AbRCJJuT>; Sat, 10 Mar 2001 04:50:19 -0500
Received: from dyn545.dhcp.lancs.ac.uk ([148.88.245.69]:516 "EHLO
	dyn545.dhcp.lancs.ac.uk") by vger.kernel.org with ESMTP
	id <S130977AbRCJJuO>; Sat, 10 Mar 2001 04:50:14 -0500
Date: Fri, 9 Mar 2001 21:08:55 +0000 (GMT)
From: Stephen Torri <s.torri@lancaster.ac.uk>
X-X-Sender: <torri@localhost.localdomain>
To: David Christensen <David_Christensen@Phoenix.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: RE: ACPI:system description tables not found.
In-Reply-To: <D973CF70008ED411B273009027893BA409728C@irv-exch.phoenix.com>
Message-ID: <Pine.LNX.4.33.0103092106180.10511-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Mar 2001, David Christensen wrote:

> Stephen,
>
> Is there a BIOS setup option for enabling ACPI?  Make sure it is enabled.

The BIOS setup option for ACPI is enabled.

> Also attach a copy of the E820 output from dmesg.

Linux version 2.4.2 (root@base.torri.linux) (gcc version egcs-2.91.66
19990314/Linux (egcs-1.1.2 release)) #2 SMP Mon Feb 26 23:47:16 GMT 2001

BIOS-provided physical RAM map:
 BIOS-e820: 000000000009fc00 @ 0000000000000000 (usable)
 BIOS-e820: 0000000000000400 @ 000000000009fc00 (reserved)
 BIOS-e820: 0000000000020000 @ 00000000000e0000 (reserved)
 BIOS-e820: 0000000017f00000 @ 0000000000100000 (usable)
 BIOS-e820: 0000000000001000 @ 00000000fec00000 (reserved)
 BIOS-e820: 0000000000001000 @ 00000000fee00000 (reserved)
 BIOS-e820: 0000000000040000 @ 00000000fffc0000 (reserved)
Scan SMP from c0000000 for 1024 bytes.
Scan SMP from c009fc00 for 1024 bytes.
Scan SMP from c00f0000 for 65536 bytes.
found SMP MP-table at 000fb4f0
hm, page 000fb000 reserved twice.
hm, page 000fc000 reserved twice.
hm, page 000f2000 reserved twice.
hm, page 000f3000 reserved twice.
On node 0 totalpages: 98304
zone(0): 4096 pages.
zone(1): 94208 pages.
zone(2): 0 pages.

Stephen
-----------------------------------------------
Buyer's Guide for a Operating System:
Don't care to know: Mac
Don't mind knowing but not too much: Windows
Hit me! I can take it!: Linux

