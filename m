Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314684AbSEONnI>; Wed, 15 May 2002 09:43:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315272AbSEONnH>; Wed, 15 May 2002 09:43:07 -0400
Received: from a217-118-40-108.bluecom.no ([217.118.40.108]:15125 "EHLO
	mail.circlestorm.org") by vger.kernel.org with ESMTP
	id <S314684AbSEONnG>; Wed, 15 May 2002 09:43:06 -0400
Message-ID: <00bd01c1fc16$6fcfbd50$0d01a8c0@studio2pw0bzm4>
From: "Dead2" <dead2@circlestorm.org>
To: "Tigran Aivazian" <tigran@veritas.com>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0205141938390.1577-100000@einstein.homenet>
Subject: Re: Initrd or Cdrom as root
Date: Wed, 15 May 2002 15:43:03 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Interesting, so you are saying that the modern BIOSes are already capable
> of booting no-emulation CDs? Last time I tried it (perhaps a year ago)
> some of my Dell machines couldn't do it so I gave up and decided to live
> with the 2.88M limit.
> But if things changed and I should revisit the idea (i.e. if it is now
> possible to have boot images larger than 2.88M in a portable manner) then
> I would like to know.

Indeed it seems like it works on most computers here atleast, and I would
like to explore this way of doing it before boiling out of it just to find
new
problems arising with other ways.

So, I now have a new problem I hope someone can help me out with.
It now mounts the cdrom as root like it should, but then gives me the error:
"Warning: unable to open an initial console."

I have checked everything I can think of, but if someone could point me to
exactly generates this error, I would be forever grateful.

-=Dead2=-

