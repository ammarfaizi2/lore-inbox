Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262316AbRERNrp>; Fri, 18 May 2001 09:47:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262320AbRERNrY>; Fri, 18 May 2001 09:47:24 -0400
Received: from wks79.navicsys.com ([207.180.73.79]:11721 "EHLO noop.")
	by vger.kernel.org with ESMTP id <S262316AbRERNrQ>;
	Fri, 18 May 2001 09:47:16 -0400
To: Petr Konecny <pekon@informatics.muni.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel support for Sony Vaio PCG-FX140
In-Reply-To: <qwweltmbxvt.fsf@decibel.fi.muni.cz>
From: Nick Papadonis <npapadon@yahoo.com>
Organization: None
X-Face: 01-z%.O)i7LB;Cnxv)c<Qodw*J*^HU}]Y-1MrTwKNn<1_w&F$rY\\NU6U\ah3#y3r<!M\n9
 <vK=}-Z{^\-b)djP(pD{z1OV;H&.~bX4Tn'>aA5j@>3jYX:)*O6:@F>it.>stK5,i^jk0epU\$*cQ9
 !)Oqf[@SOzys\7Ym}:2KWpM=8OCC`
Content-Type: text/plain; charset=US-ASCII
Date: 18 May 2001 09:46:15 -0400
In-Reply-To: <qwweltmbxvt.fsf@decibel.fi.muni.cz> (Petr Konecny's message of "18 May 2001 15:16:38 +0200")
Message-ID: <m3n18ahis8.fsf@yahoo.com>
User-Agent: Gnus/5.090003 (Oort Gnus v0.03) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Petr Konecny <pekon@informatics.muni.cz> writes:

First I have a VAIO FX140 also.

> Hi,
> 
> I started to use Linux on Sony Vaio PCG-FX140. It has Intel 815-EM
> chipset.  I got the network card working, but had little luck with other
> stuff. I used 2.4.4-ac4.
> 
> 1) The ethernet:
Use the e100 driver that Intel wrote.  It is much better and runs
great on my VAIO.  The eepro100 had many lockups.


> 2) Audio:
> 00:1f.5 Multimedia audio controller: Intel Corporation: Unknown device 2445 (rev 03)
My audio works fine with stock kernel 2.2.16. i810_audio.  I use RH 7.0.

> 3) It has winmodem, so no luck there.
I'm working on this.  There is a driver for the 2.2.x series kernels,
but I couldn't get it to work.  Beg Conexant to release a driver or
open source their code.



Someone wrote a program to change LCD contrast.  It works.  Try:
http://samba.org/picturebook/


Let me know of any other things you encounter.

-- 
Nick
PGP KEY: http://www.coelacanth.com/~nick/npapadon.public.asc
