Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264724AbRFUDNz>; Wed, 20 Jun 2001 23:13:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264730AbRFUDNp>; Wed, 20 Jun 2001 23:13:45 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:50197 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S264724AbRFUDNh>; Wed, 20 Jun 2001 23:13:37 -0400
Date: Wed, 20 Jun 2001 23:13:35 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200106210313.f5L3DZ124717@devserv.devel.redhat.com>
To: landley@webofficenow.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [OT] Threads, inelegance, and Java
In-Reply-To: <mailman.993083762.1429.linux-kernel2news@redhat.com>
In-Reply-To: <20010620042544.E24183@vitelus.com> <01062007252301.00776@localhost.localdomain> <20010621000725.A24672@werewolf.able.es> <mailman.993083762.1429.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Then again JavaOS was an abortion on top of Slowaris. [...]

This is a false statemenet, Rob. It was an abortion, all right,
but not related to Solaris in any way at all.

JavaOS existed in two flavours minimum, which had very little
in common. The historically first of them (Luna), was a home-made
executive with pretty rudimentary abilities. I must admit I am
not intimately familiar with its genesis. A part of it was related
to the JavaOS running on Sun 701 chip, but what came first,
I cannot tell. Second flavour of JavaOS was made on top of
Chorus, and, _I think_, used large parts of Luna in the the
JVM department, but it had decent kernel, with such novations
as a device driver interface :)

> make a DPMI DOS port with an SVGA AWT and say "hey, we're done, and it boots 
> off a single floppy", I'll never know.

Such a thing existed. I do not remember its proper name,
but I remember that it booted from hard disk. Floppy
was too small for it.

> Porting half of Solaris to Power PC for JavaOS has got to be one of the most 
> peverse things I've seen in my professional career.

I never heard of PPC port of either of JavaOSes, although
Chorus runs on PPC. Perhaps this is what you mean.

Solaris for PPC existed, but never was widespread.
It did not have JVM bundled.

> I'm upset that Red Hat 7.1 won't install on that old laptop because it only 
> has 24 megs of ram and RedHat won't install in that. [...]

You blew adding a swap partition, I suspect...

-- Pete
