Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262104AbTKLPLV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Nov 2003 10:11:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262360AbTKLPKI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Nov 2003 10:10:08 -0500
Received: from oobleck.astro.cornell.edu ([132.236.6.230]:27607 "EHLO
	oobleck.astro.cornell.edu") by vger.kernel.org with ESMTP
	id S262202AbTKLPJ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Nov 2003 10:09:26 -0500
Date: Wed, 12 Nov 2003 10:09:17 -0500
Message-Id: <200311121509.hACF9HG20967@oobleck.astro.cornell.edu>
From: Joe Harrington <jh@oobleck.astro.cornell.edu>
To: solt@dns.toxicfilms.tv
CC: linux-kernel@vger.kernel.org
In-reply-to: <Pine.LNX.4.51.0311121016130.30003@dns.toxicfilms.tv> (message
	from Maciej Soltysiak on Wed, 12 Nov 2003 10:19:49 +0100 (CET))
Subject: Re: Via KT600 support?
CC: jh@oobleck.astro.cornell.edu
Reply-To: jh@oobleck.astro.cornell.edu
References: <200311111921.hABJLur16428@oobleck.astro.cornell.edu> <Pine.LNX.4.51.0311121016130.30003@dns.toxicfilms.tv>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > During install of Fedora Core 1, Fedora Core test3, Red Hat 9, and
> > Debian 3.0r1, the install fails at a random point, generally during
> > the non-interactive package loading phase.  The most recent kernel
> > with the problem is kernel-2.4.22-1.2115.nptl in the Fedora Core 1
> > release.  The problem is 100% reproducible.

> Hmm, I have installed Mandrake 9.1 on some Gigabyte KT600 motherboard
> with no problems. It had 2.4.21 kernel.

> Maybe you should check if there's a BIOS update for that MB?

Yes, thanks, I did that before I posted.  The problem exists with both
the original BIOS (1004) and the latest (1005).

Is anyone aware of similar problems with other manufacturers' KT600
boards that were fixed in recent BIOS updates?  Perhaps Asus has a
BIOS bug they haven't fixed yet.

By the way, I also underclocked both the CPU and the memory as far
down as they would go, just to check, and the problem persisted.

--jh--
