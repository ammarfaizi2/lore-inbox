Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316754AbSERF5l>; Sat, 18 May 2002 01:57:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316755AbSERF5k>; Sat, 18 May 2002 01:57:40 -0400
Received: from chac.inf.utfsm.cl ([200.1.19.54]:17931 "EHLO chac.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id <S316754AbSERF5i>;
	Sat, 18 May 2002 01:57:38 -0400
Message-Id: <200205180401.g4I41ero018310@sleipnir.valparaiso.cl>
To: Wayne.Brown@altec.com
cc: linux-kernel@vger.kernel.org
Subject: Re: kbuild 2.5 is ready for inclusion in the 2.5 kernel - take 3 
In-Reply-To: Your message of "Fri, 17 May 2002 17:59:28 CDT."
             <86256BBC.007E84E7.00@smtpnotes.altec.com> 
X-mailer: MH [Version 6.8.4]
X-charset: ISO_8859-1
Date: Sat, 18 May 2002 00:01:40 -0400
From: Horst von Brand <vonbrand@sleipnir.valparaiso.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wayne.Brown@altec.com said:

[Long explanation on routine kernel compilation elided]]

> I have all this down to a science.  All these commands are in my bash
> command history so I can pull them up with a couple of keystrokes.

Guess what... after the first time you do it the newfangled way the
new commands will be in .bash_history too!

>                                                                    I've
> done them all so many times that I can type them from scratch almost
> without thinking about them.

If you do it _that_ often, then you'll get it the same automation in no
time with any strange new commands. Or find a way to integrate them with
your cron job that downloads patches (Heck... I update gcc from CVS
nightly, build it and run its testsuite from cron). But just compiling any
random kernel that shows up is not enough...
--
Horst von Brand                             vonbrand@sleipnir.valparaiso.cl
Casilla 9G, Vin~a del Mar, Chile                               +56 32 672616
