Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133105AbRD1XHB>; Sat, 28 Apr 2001 19:07:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135506AbRD1XGv>; Sat, 28 Apr 2001 19:06:51 -0400
Received: from www.topmail.de ([212.255.16.226]:130 "HELO www.topmail.de")
	by vger.kernel.org with SMTP id <S133105AbRD1XGl>;
	Sat, 28 Apr 2001 19:06:41 -0400
Message-ID: <010a01c0d037$e17e66b0$de00a8c0@homeip.net>
From: "mirabilos" <eccesys@topmail.de>
To: <linux-kernel@vger.kernel.org>, "Rogier Wolff" <R.E.Wolff@BitWizard.nl>
In-Reply-To: <200104282236.AAA06021@cave.bitwizard.nl>
Subject: Re: Sony Memory stick format funnies... 
Date: Sat, 28 Apr 2001 23:06:37 -0000
Organization: eccesys.net Linux development
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 001b0  00 00 00 00 00 00 00 00   00 00 00 00 00 00 80 02
................
> 001c0  08 00 01 07 d0 dd 27 00   00 00 d9 ee 01 00 00 00
....P]'...Yn....
> 001f0  00 00 00 00 00 00 00 00   00 00 00 00 00 00 55 aa
..............U*
> 04e00  e9 00 00 20 20 20 20 20   20 20 20 00 02 20 01 00 i..        ..
..
> 04e10  02 00 02 00 00 f8 0c 00   10 00 08 00 27 00 00 00
.....x......'...
> 04e20  d9 ee 01 00 00 00 29 00   00 00 00 00 00 00 00 00
Yn....).........
> 04e30  00 00 00 00 00 00 46 41   54 31 32 20 20 20 00 00 ......FAT12
..
> 04ff0  00 00 00 00 00 00 00 00   00 00 00 00 00 00 55 aa
..............U*

I didnt look further but IMO it must be PARTITIONED???
(I'd start the partition at +1 rather than +0x27)

No, the directory is not on the disk, and I've been DEBUG.COMing
FAT drives since I was 9 years old.

-mirabilos


