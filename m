Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263204AbSJJELF>; Thu, 10 Oct 2002 00:11:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263218AbSJJELE>; Thu, 10 Oct 2002 00:11:04 -0400
Received: from h52544c185a20.ne.client2.attbi.com ([24.147.42.69]:16770 "EHLO
	luna.pizzashack.org") by vger.kernel.org with ESMTP
	id <S263204AbSJJELD>; Thu, 10 Oct 2002 00:11:03 -0400
Date: Thu, 10 Oct 2002 00:16:48 -0400
From: "Derek D. Martin" <lkml@pizzashack.org>
To: linux-kernel@vger.kernel.org
Subject: Re: BK is *evil* corporate software [was Re: New BK License Problem?]
Message-ID: <20021010041647.GO2753@pizzashack.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20021005112552.A9032@work.bitmover.com> <20021007001137.A6352@elf.ucw.cz> <5.1.0.14.2.20021007204830.00b8b460@pop.gmx.net> <20021007143134.V14596@work.bitmover.com> <ao2ee1$l0c$1@forge.intermeta.de> <20021009165500.L27050@work.bitmover.com> <20021010035000.GD8805@mark.mielke.cc>
Mime-Version: 1.0
Content-Type: text/plain
Content-Disposition: inline; filename="msg.pgp"
In-Reply-To: <20021010035000.GD8805@mark.mielke.cc>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

At some point hitherto, Mark Mielke hath spake thusly:
> Hardware costs are nothing really. The true killer with ClearCase is
> the support costs. Not only do you need several full time people to
> deal with user problems, you need several full time people to
> customize your solution such that it meets your needs, several full
> time people to baby the servers, and a whole management structure on
> top to ensure that the full time people talk to each other, and the
> actual users.

I'd have to disagree... though it probably depends on your environment
a great deal, and possibly how braindead your development team and/or
your sysadmin team is.  At a previous job, I was one of two system
administrators that supported ClearCase in our Solaris environment for
about 100 engineers.  That is, there were two of us, and I never
touched it.  My coworker spent maybe an hour a week on it, discounting
time spent migrating to new hardware and a new config when our
environment changed (drastically).  I think that, like most
applications that aren't inherently broken, once you have it set up
PROPERLY for your environment, it doesn't require much maintenance.
Nor should it.  OTOH like I said, I didn't touch it, so for all I know
it could have been a horrid mess that the developers just weren't
inclined to complain about.  But I tend to doubt that...

Oh, and we never really saw our manager much... ;-)  Actually most of
the time, the engineers appreciated that.  For the most part, when
they had problems, they just came to us directly, and we took care of
them.  The only time management got involved was when each of our
visions of how things were supposed to work were miles apart, and we
each felt strongly about our own vision.  It was, in many ways, an
ideal job.  Unfortunately, as in most cases, circumstances change...

I have no comment about whether or not BK is evil...  ;-)

- -- 
Derek D. Martin
http://www.pizzashack.org/
GPG Key ID: 0x81CFE75D

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9pP8vdjdlQoHP510RAjFyAKC+LnSfXgaju5u0ujc+ZRgoLZcgwwCff3hU
jiGSLgbERQ2QALdx4MRO4CI=
=hfSD
-----END PGP SIGNATURE-----
