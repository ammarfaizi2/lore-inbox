Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261713AbVANAcW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261713AbVANAcW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 19:32:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261730AbVANAa1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 19:30:27 -0500
Received: from grendel.firewall.com ([66.28.58.176]:63905 "EHLO
	grendel.firewall.com") by vger.kernel.org with ESMTP
	id S261723AbVAMVsX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 16:48:23 -0500
Date: Thu, 13 Jan 2005 22:48:14 +0100
From: Marek Habersack <grendel@caudium.net>
To: Dave Jones <davej@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Chris Wright <chrisw@osdl.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Linus Torvalds <torvalds@osdl.org>, Greg KH <greg@kroah.com>,
       akpm@osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: thoughts on kernel security issues
Message-ID: <20050113214814.GA9481@beowulf.thanes.org>
Reply-To: grendel@caudium.net
References: <20050112161227.GF32024@logos.cnet> <Pine.LNX.4.58.0501121148240.2310@ppc970.osdl.org> <20050112174203.GA691@logos.cnet> <1105627541.4624.24.camel@localhost.localdomain> <20050113194246.GC24970@beowulf.thanes.org> <20050113115004.Z24171@build.pdx.osdl.net> <20050113202905.GD24970@beowulf.thanes.org> <1105645267.4644.112.camel@localhost.localdomain> <20050113210229.GG24970@beowulf.thanes.org> <20050113213002.GI3555@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cNdxnHkX5QqsyA0e"
Content-Disposition: inline
In-Reply-To: <20050113213002.GI3555@redhat.com>
Organization: I just...
X-GPG-Fingerprint: 0F0B 21EE 7145 AA2A 3BF6  6D29 AB7F 74F4 621F E6EA
X-message-flag: Outlook - A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 13, 2005 at 04:30:02PM -0500, Dave Jones scribbled:
> On Thu, Jan 13, 2005 at 10:02:29PM +0100, Marek Habersack wrote:
>  > Theory is fine, practice is that the closed disclosure list changes ma=
tters
>  > for a vaste minority of people - those who are to install the fixed ke=
rnels
>  > are in perfectly the same situation they would be in if there was a fu=
lly
>  > open disclosure list.
>=20
> No, it's not the same. They're in a _worse_ situation if anything.
> With open disclosure, the bad guys get even more lead time.
I guess it depends on how you look at it. In fact, thinking again, I think
it gives the same time to the bad and good guys in each case. So it seems
there is no benefit to having a closed list or an open list in this regard
after all. And if this is not an issue, what might be the reason for having
the closed list? The lust for glory as you've said earlier?

> If admins don't install updates in a timely manner, there's
> not a lot we can do about it.  For those that _do_ however,
> we can make their lives a lot more stress free.
Indeed, but what does have it to do with a closed disclosure list? With open
disclosure list you provide a set of fixes right away, the admins take them
and apply. With closed list you do the same, but with a delay (which gives
an opportunity for a "race condition" with the bad guys, one could argue).
So, what's the advantage of the delayed disclosure?

best regards,

marek

--cNdxnHkX5QqsyA0e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFB5uyeq3909GIf5uoRAqozAJ99mtUPHFj5+HXX6s3JT3/2SjfVvACeM1S5
la+03tbPmcKMlObWtGO70w8=
=CM5k
-----END PGP SIGNATURE-----

--cNdxnHkX5QqsyA0e--
