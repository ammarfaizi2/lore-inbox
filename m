Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267438AbRGLF5U>; Thu, 12 Jul 2001 01:57:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267439AbRGLF5K>; Thu, 12 Jul 2001 01:57:10 -0400
Received: from rillanon.amristar.com.au ([202.181.77.23]:32516 "HELO
	amristar.com.au") by vger.kernel.org with SMTP id <S267438AbRGLF5E>;
	Thu, 12 Jul 2001 01:57:04 -0400
From: "Daniel Harvey" <daniel@amristar.com.au>
To: <linux-kernel@vger.kernel.org>
Subject: RE: FW: UPDATE: Linux SLOW on Compaq Armada 110 PIII Speedstep
Date: Thu, 12 Jul 2001 14:01:04 +0800
Message-ID: <NEBBJDBLILDEDGICHAGAMEAHCGAA.daniel@amristar.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here it is:

Linux version 2.4.5 (root@elvandar) (gcc version 2.95.4 20010703 (Debian
prerelease)) #1 Tue Jul 10 03:09:36 WST 2001
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000ea000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000fbf0000 (usable)
 BIOS-e820: 000000000fbf0000 - 000000000fbffc00 (ACPI data)
 BIOS-e820: 000000000fbffc00 - 000000000fc00000 (ACPI NVS)
 BIOS-e820: 00000000fffe0000 - 0000000100000000 (reserved)

Thanks,
Daniel.

> > the bios returns a memory value to accommodate this
>
> The BIOS /should/.  Perhaps that's the problem.  Daniel, can you send a
> copy of your BIOS memory map (reported by Linux during boot) to myself
> and the list?

