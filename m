Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267435AbUGNQEA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267435AbUGNQEA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 12:04:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267432AbUGNQD7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 12:03:59 -0400
Received: from mout1.freenet.de ([194.97.50.132]:56803 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id S267431AbUGNQDt convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 12:03:49 -0400
From: Michael Buesch <mbuesch@freenet.de>
To: arjanv@redhat.com
Subject: Re: [Q] don't allow tmpfs to page out
Date: Wed, 14 Jul 2004 18:03:18 +0200
User-Agent: KMail/1.6.2
References: <200407141654.31817.mbuesch@freenet.de> <200407141751.14292.mbuesch@freenet.de> <1089820882.2806.7.camel@laptop.fenrus.com>
In-Reply-To: <1089820882.2806.7.camel@laptop.fenrus.com>
Cc: William Stearns <wstearns@pobox.com>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200407141803.21388.mbuesch@freenet.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Quoting Arjan van de Ven <arjanv@redhat.com>:
> On Wed, 2004-07-14 at 17:51, Michael Buesch wrote:
> > -----BEGIN PGP SIGNED MESSAGE-----
> > Hash: SHA1
> > 
> > Quoting William Stearns <wstearns@pobox.com>:
> > > Good afternoon, Michael,
> > 
> > Hi William,
> > 
> > > 	I suspect a regular ramdisk, as opposed to tmpfs, would do what 
> > > you want.
> > 
> > No, since a regular ramdisk is static in size.
> 
> which is why there is ramfs .. :)

In 2.4, too? Can't find it.
What's the CONFIG_* of ramfs?

- -- 
Regards Michael Buesch  [ http://www.tuxsoft.de.vu ]


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA9VlGFGK1OIvVOP4RAn3HAJ9fU0KX6FNJDQwn9gVFGKA506eivgCfd28S
zBmNkGBYQd4lmSmUVSzvmGA=
=eejH
-----END PGP SIGNATURE-----
