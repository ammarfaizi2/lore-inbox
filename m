Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266520AbTGEWZ2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jul 2003 18:25:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266524AbTGEWZ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jul 2003 18:25:28 -0400
Received: from mta1.srv.hcvlny.cv.net ([167.206.5.4]:9040 "EHLO
	mta1.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S266520AbTGEWZ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jul 2003 18:25:27 -0400
Date: Sat, 05 Jul 2003 18:39:41 -0400
From: Jeff Sipek <jeffpc@optonline.net>
Subject: Re: [PATCH - RFC] [1/5] 64-bit network statistics - generic net
In-reply-to: <20030705235131.A10511@electric-eye.fr.zoreil.com>
To: Francois Romieu <romieu@fr.zoreil.com>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Bernd Eckenfels <ecki@calista.eckenfels.6bone.ka-ip.net>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@digeo.com>,
       Dave Jones <davej@codemonkey.org.uk>,
       Linus Torvalds <torvalds@osdl.org>, netdev@oss.sgi.com
Message-id: <200307051839.50327.jeffpc@optonline.net>
MIME-version: 1.0
Content-type: Text/Plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
Content-disposition: inline
Content-description: clearsigned data
User-Agent: KMail/1.5.2
References: <E19YtAq-0006Xf-00@calista.inka.de>
 <200307051700.32533.jeffpc@optonline.net>
 <20030705235131.A10511@electric-eye.fr.zoreil.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Saturday 05 July 2003 17:51, Francois Romieu wrote:
> Jeff Sipek <jeffpc@optonline.net> :
> > The thing is that x86 is here to stay for quite some time. Even if 64-bit
> > processors take over the market, you will have so many "old" computers
> > that can:
> >
> > - - be thrown out
> > - - donated to some institution
> > - - converted to routers, and other "embedded" systems
> >
> > Plus, they will be dirt cheap.
>
> - the PCI bus don't/won't/can't handle multiple 10 Gb/s adapters;

Ok, so let's stay in the range of gigabit ethernet...

> - nobody sane would recycle x86 systems as core routers after having bought
>   a few Gb/s link.

When you have "a few Gb/s links" you would not use your beloved Pentium 100 
MHz to do the job, instead you would go for something like 1.5 GHz P4 or 
Athlon, both of which would be cheaper than the new 64-bit architecture.

Jeff.

P.S. I just looked up the cheapest gigabit copper I could find in 10 seconds, 
and I found: D-Link DGE-500T for $36.27 this is just 4 times the price of the 
cheapest fast ethernet I found on the same site (cdw.com - they are not the 
cheapest, but I like them)

- -- 
A computer without Microsoft is like chocolate cake without mustard.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/B1OxwFP0+seVj/4RAkWfAJ9lYLk9zwpR2LpVLgVIDLovQewZKwCeLivr
bRCwwzVIj29rmxiT5tpmkaM=
=HXK9
-----END PGP SIGNATURE-----

