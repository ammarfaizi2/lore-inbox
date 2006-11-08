Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423918AbWKHXMx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423918AbWKHXMx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 18:12:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423922AbWKHXMx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 18:12:53 -0500
Received: from armagnac.ifi.unizh.ch ([130.60.75.72]:44511 "EHLO
	albatross.madduck.net") by vger.kernel.org with ESMTP
	id S1423918AbWKHXMw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 18:12:52 -0500
Date: Thu, 9 Nov 2006 00:12:48 +0100
From: martin f krafft <madduck@madduck.net>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: How to interpret MCE messages?
Message-ID: <20061108231248.GC28926@piper.madduck.net>
Mail-Followup-To: linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <20061108162022.GA4258@piper.madduck.net> <1163003354.23956.43.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="i7F3eY7HS/tUJxUd"
Content-Disposition: inline
In-Reply-To: <1163003354.23956.43.camel@localhost.localdomain>
X-OS: Debian GNU/Linux 4.0 kernel 2.6.17-2-amd64 x86_64
X-Motto: Keep the good times rollin'
X-Subliminal-Message: debian/rules!
X-Spamtrap: madduck.bogus@madduck.net
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--i7F3eY7HS/tUJxUd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Alan Cox <alan@lxorguk.ukuu.org.uk> [2006.11.08.1729 +0100]:
> >     memory/cache error 'data read mem transaction, data
> >     transaction, level 2'
>=20
> L2 Cache

Gosh, I must be blind. Somehow there was too much information in
that dump. Thanks Alan!

> > Before I go out and buy a new motherboard (as I assume that it's
> > a L1/L2 cache problem),=20
>=20
> L1/L2 cache are on the CPU these days. Double check with the processor
> docs and vendor but I think mcelog is actually trying to tell you that
> the CPU wants to be warranty returned. It might also of course be a heat
> problem.

I am afraid the CPU might be out of warranty, but I'll try; I doubt
it's a heat problem since there are plenty fans and the machine's
interior is actually of quite agreeable temperature.

I'll check the CPU. Again, thanks.

--=20
martin;              (greetings from the heart of the sun.)
  \____ echo mailto: !#^."<*>"|tr "<*> mailto:" net@madduck
=20
spamtraps: madduck.bogus@madduck.net
=20
if you find a spelling mistake in the above, you get to keep it.

--i7F3eY7HS/tUJxUd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature (GPG/PGP)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFUmRwIgvIgzMMSnURArhnAKDPeK6XlBbsHshUKCo4xy0CsIWN+QCgthCO
GWdddii8u33GaFtzEcGQO30=
=5dCP
-----END PGP SIGNATURE-----

--i7F3eY7HS/tUJxUd--
