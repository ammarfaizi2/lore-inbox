Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313032AbSEDO0i>; Sat, 4 May 2002 10:26:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313087AbSEDO0h>; Sat, 4 May 2002 10:26:37 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:2779 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S313032AbSEDO0g>; Sat, 4 May 2002 10:26:36 -0400
Date: Sat, 4 May 2002 16:22:05 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Robert Baruch <autophile@starband.net>
cc: mdharm-usb@one-eyed-alien.net, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: NDA used for drivers/usb/storage/shuttle_usbat.c?
Message-ID: <Pine.NEB.4.44.0205041618030.283-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robert,

drivers/usb/storage/shuttle_usbat.c contains the following:

<--  snip  -->

...
 * SCM Microsystems (www.scmmicro.com) makes a device, sold to OEM's only,
 * which does the USB-to-ATAPI conversion.  By obtaining the data sheet on
 * their device under nondisclosure agreement, I have been able to write
 * this driver for Linux.
...

<--  snip  -->

This sounds as if it might be that this open source driver violates the
NDA you signed. Could you please clarify in the comment in this file that
this driver doesn't violate the NDA?


TIA
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox

