Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265189AbRFUUNB>; Thu, 21 Jun 2001 16:13:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265190AbRFUUMv>; Thu, 21 Jun 2001 16:12:51 -0400
Received: from Morgoth.esiway.net ([193.194.16.157]:7181 "EHLO
	Morgoth.esiway.net") by vger.kernel.org with ESMTP
	id <S265189AbRFUUMh>; Thu, 21 Jun 2001 16:12:37 -0400
Date: Thu, 21 Jun 2001 22:12:35 +0200 (CEST)
From: Marco Colombo <marco@esi.it>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Controversy over dynamic linking -- how to end the panic
In-Reply-To: <E15D9u7-0001xo-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0106212158090.6630-100000@Megathlon.ESI>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Jun 2001, Alan Cox wrote:

> > 1) Oracle Corp. builds their database for Linux on a Linux system.
> > 2) Said system comes with standard header files, which happen in this case to
> >    be GPL'd header files.
> > 3) Oracle Corp.'s database becomes GPL.
> >
> > There's not a court in the civilised world that would uphold the GPL in that
> > scenario.
>
> Yes but the concern is the USA 8)

Pardon me, but what does "Oracle Corp.'s database becomes GPL" mean in the
above 3)? (I'm asking to you since you seem to agree).  Even if the
database is found to be linked with a GPLed piece of SW, this doesn't make
it (the database) GPLed, it just breaks Oracle's licence on the GPL SW.
They only have to recompile their program against non-GPLed code (e.g.
rewrite that part from scratch) and redistribute it.  That's not like
everyone going to Oracle and say "Your SW is now GPLed, hand me the Source.
Resistance is Futile." ... GPL has a viral behaviour iff you want to
keep using the GPLed part that you included, or am I missing something?

.TM.
-- 
      ____/  ____/   /
     /      /       /			Marco Colombo
    ___/  ___  /   /		      Technical Manager
   /          /   /			 ESI s.r.l.
 _____/ _____/  _/		       Colombo@ESI.it

