Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261970AbTDAB1V>; Mon, 31 Mar 2003 20:27:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261972AbTDAB1V>; Mon, 31 Mar 2003 20:27:21 -0500
Received: from sinfonix.rz.tu-clausthal.de ([139.174.2.33]:53742 "EHLO
	sinfonix.rz.tu-clausthal.de") by vger.kernel.org with ESMTP
	id <S261970AbTDAB1T> convert rfc822-to-8bit; Mon, 31 Mar 2003 20:27:19 -0500
From: "Hemmann, Volker Armin" <volker.hemmann@heim9.tu-clausthal.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Query about SIS963 Bridges
Date: Tue, 1 Apr 2003 03:38:14 +0200
User-Agent: KMail/1.5.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200304010338.14233.volker.hemmann@heim9.tu-clausthal.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

 please cc me, bcause I am not suscribed to lkml.

I have an Asrock K7S8X with such a 746FX/963l combo.

Networking, IDE is working fine, I am able to access the pci soundcard and a 
hotrod 66 controller. Even watching Tv is fine.

I am burning cds and have no problems to access an usb-stick.

The only setback is missing support in the agpgart, crippling 3d and problems 
with dga.

Kernel is gentoo's 2.4.20-gaming, an 2.5.66-mm1 was even able to boot, but had 
a panic, killing the interrupt handler when loading modules.

ACPI and Local APIC is inabled, enablic IO-APIC gives lost interrupts for the 
Hotrod.

If desired I can test different kernels, send the output of dmesg etc.

My Hardware:

AMD Xp 2000+
Asrock K7S8X
2x256mb ram
Geforce 4mx 440 (Agp 4x)
Abit Hotrod 66 udma 66 controller  (one hd at each channel)
Terratec Tv+
C-Media 8738 based soundcard.

2 hardrives on ide 0
1 cdrw-drive and 1 dvd at ide1
1 usb 1.1 256mb flash stick.

Glück Auf,
Volker


