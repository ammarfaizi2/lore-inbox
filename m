Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286347AbRLTT2T>; Thu, 20 Dec 2001 14:28:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286346AbRLTT2J>; Thu, 20 Dec 2001 14:28:09 -0500
Received: from [198.17.35.35] ([198.17.35.35]:6600 "HELO mx1.peregrine.com")
	by vger.kernel.org with SMTP id <S286339AbRLTT14>;
	Thu, 20 Dec 2001 14:27:56 -0500
Message-ID: <B51F07F0080AD511AC4A0002A52CAB445B2A26@ottonexc1.ottawa.loran.com>
From: Dana Lacoste <dana.lacoste@peregrine.com>
To: "'nknight@pocketinet.com'" <nknight@pocketinet.com>
Cc: linux-kernel@vger.kernel.org
Subject: RE: Changing KB, MB, and GB to KiB, MiB, and GiB in Configure.hel
	 p.
Date: Thu, 20 Dec 2001 11:27:57 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Everyone I know has been using KB/MB/GB for 1024 forever.

Ahhh, now I see the problem.  You don't know many people :) :) :) :) :)

> The *only* exception is networking, and the occasional FLASH/ROM size. 

bullshit.

check out any recent hard drive : 

drive size = 40235MB*
* 1MB = 1000000 Bytes

there is _no_ standard for what 1MB means.  There is a LOT of
confusion, and most places will accept both

for example, the gnu ls command has :
  -h, --human-readable  print sizes in human readable format (e.g., 1K 234M
2G)
      --si                   likewise, but use powers of 1000 not 1024

This move might look weird, but in 6 months nobody will even remember
the change happening.  Less ambiguity is a Good Thing :)

Dana Lacoste
Ottawa, Canada
