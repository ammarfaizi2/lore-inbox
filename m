Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267903AbUJHFru@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267903AbUJHFru (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 01:47:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267973AbUJHFru
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 01:47:50 -0400
Received: from web52901.mail.yahoo.com ([206.190.39.178]:22185 "HELO
	web52901.mail.yahoo.com") by vger.kernel.org with SMTP
	id S267808AbUJHFrp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 01:47:45 -0400
Message-ID: <20041008054742.42568.qmail@web52901.mail.yahoo.com>
Date: Fri, 8 Oct 2004 06:47:42 +0100 (BST)
From: Ankit Jain <ankitjain1580@yahoo.com>
Subject: physical or virtual address
To: linux <linux-kernel@vger.kernel.org>
Cc: newbie <linux-newbie@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

in this file i have a doubt if this is the physical
address
it basically looks from 00000000-ffffffff

which is 0-4294967295

i feel after that there is a mapping for physical
address

if somebody can explain me this

thanks

ankit
[ankit@Ankit ankit]$ cat //proc/iomem
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-077effff : System RAM
  00100000-00250d5b : Kernel code
  00250d5c-0034ac43 : Kernel data
077f0000-077f2fff : ACPI Non-volatile Storage
077f3000-077fffff : ACPI Tables
10000000-100003ff : Intel Corp. 82801DB ICH4 IDE
e0000000-e7ffffff : Intel Corp. 82845G/GL
[Brookdale-G] Chipset Integrated Graphics Device
e8000000-ebffffff : Intel Corp. 82845G/GL
[Brookdale-G] Chipset Host Bridge
ed000000-ed0003ff : MYSON Technology Inc SURECOM
EP-320X-S 100/10M Ethernet PCI Adapter
  ed000000-ed0003ff :
????????a??N??<??G??R??P??g??q??x??p??v??m??V??Dm?
O?J?Q?M?!2Z<)ee000000-ee07ffff : Intel Corp.
82845G/GL [Brookdale-G] Chipset Integrated Graphics
Device
ee080000-ee0803ff : Intel Corp. 82801DB USB EHCI
Controller
  ee080000-ee0803ff : ehci-hcd
ee081000-ee0811ff : Intel Corp. 82801DB AC'97 Audio
  ee081000-ee0811ff : ich_audio MMBAR
ee082000-ee0820ff : Intel Corp. 82801DB AC'97 Audio
  ee082000-ee0820ff : ich_audio MBBAR
fec00000-ffffffff : reserved


________________________________________________________________________
Yahoo! Messenger - Communicate instantly..."Ping" 
your friends today! Download Messenger Now 
http://uk.messenger.yahoo.com/download/index.html
