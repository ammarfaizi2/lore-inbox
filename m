Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261387AbVAMTe6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261387AbVAMTe6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 14:34:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261383AbVAMTe6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 14:34:58 -0500
Received: from grendel.firewall.com ([66.28.58.176]:32417 "EHLO
	grendel.firewall.com") by vger.kernel.org with ESMTP
	id S261430AbVAMTZx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 14:25:53 -0500
Date: Thu, 13 Jan 2005 20:25:51 +0100
From: Marek Habersack <grendel@caudium.net>
To: "Barry K. Nathan" <barryn@pobox.com>
Cc: Dave Jones <davej@redhat.com>, Linus Torvalds <torvalds@osdl.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Greg KH <greg@kroah.com>, Chris Wright <chrisw@osdl.org>, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: thoughts on kernel security issuesiig
Message-ID: <20050113192551.GA24970@beowulf.thanes.org>
Reply-To: grendel@caudium.net
References: <Pine.LNX.4.58.0501121002200.2310@ppc970.osdl.org> <20050112185133.GA10687@kroah.com> <Pine.LNX.4.58.0501121058120.2310@ppc970.osdl.org> <20050112161227.GF32024@logos.cnet> <Pine.LNX.4.58.0501121148240.2310@ppc970.osdl.org> <20050112205350.GM24518@redhat.com> <Pine.LNX.4.58.0501121750470.2310@ppc970.osdl.org> <20050113032506.GB1212@redhat.com> <20050113035331.GC9176@beowulf.thanes.org> <20050113053807.GE4378@ip68-4-98-123.oc.oc.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qDbXVdCdHGoSgWSk"
Content-Disposition: inline
In-Reply-To: <20050113053807.GE4378@ip68-4-98-123.oc.oc.cox.net>
Organization: I just...
X-GPG-Fingerprint: 0F0B 21EE 7145 AA2A 3BF6  6D29 AB7F 74F4 621F E6EA
X-message-flag: Outlook - A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 12, 2005 at 09:38:07PM -0800, Barry K. Nathan scribbled:
> On Thu, Jan 13, 2005 at 04:53:31AM +0100, Marek Habersack wrote:
> > archived mail message or a webpage with the patch. Hoping he'll find the
> > fixes in the vendor kernels, he goes to download source packages from S=
uSe,
> > RedHat or Trustix, Debian, Ubuntu, whatever and discovers that it is as=
 easy
> > to find the patch there as it is to fish it out of the vanilla kernel p=
atch
> > for the new version. Frustrating, isn't it? Not to mention that he might
>=20
> http://linux.bkbits.net is your friend.
I know about that, but many people don't.
=20
> Each patch (including security fixes) in the mainline kernels (2.4 and
> 2.6) appears there as an individual, clickable link with a description
> (e.g. "1.1551  Paul Starzetz: sys_uselib() race vulnerability
> (CAN-2004-1235)").
>=20
> If other patches have gone in since then, you may have to scroll through
> a (short-form) changelog. However, it's still less frustrating than the
> scenario you portray.
Less frustrating, yes, safer, not even slightly. You are still left on the
thin ice precisely the moment you are notified about the vulnerability (when
it goes public). Those not being members of vendor-sec still don't have the
privilege to know about the vulnerability ahead of time, before it goes
"officially" public. Besides, I know a few people who administer linux
machines who don't know what bkbits.net is, and they don't have to. There
should be a single place, a webpage which you can visit (or get an rss feed
of) and be sure you will be among the first to know about a vulnerability
(yes, I know about the CIA feeds, but this is still not the real thing,
IMHO).

regards,

marek

--qDbXVdCdHGoSgWSk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFB5ss/q3909GIf5uoRAovuAJ46VL1kQv9TblX0uLGlmzSxT5sA6QCcD7bI
J4B+XANjDwDZwMeJUad09a8=
=rH3H
-----END PGP SIGNATURE-----

--qDbXVdCdHGoSgWSk--
