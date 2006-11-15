Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966717AbWKOJ1c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966717AbWKOJ1c (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 04:27:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966718AbWKOJ1c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 04:27:32 -0500
Received: from armagnac.ifi.unizh.ch ([130.60.75.72]:57504 "EHLO
	albatross.madduck.net") by vger.kernel.org with ESMTP
	id S966717AbWKOJ1b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 04:27:31 -0500
Date: Wed, 15 Nov 2006 10:27:27 +0100
From: martin f krafft <madduck@madduck.net>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: How to interpret MCE messages?
Message-ID: <20061115092726.GA22720@piper.oerlikon.madduck.net>
Mail-Followup-To: linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <20061108162022.GA4258@piper.madduck.net> <1163003354.23956.43.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WIyZ46R2i8wDzkSu"
Content-Disposition: inline
In-Reply-To: <1163003354.23956.43.camel@localhost.localdomain>
X-OS: Debian GNU/Linux 4.0 kernel 2.6.18-2-amd64 x86_64
X-Motto: Keep the good times rollin'
X-Subliminal-Message: debian/rules!
X-Spamtrap: madduck.bogus@madduck.net
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Alan Cox <alan@lxorguk.ukuu.org.uk> [2006.11.08.1729 +0100]:
> > Before I go out and buy a new motherboard (as I assume that it's
> > a L1/L2 cache problem),=20
>=20
> L1/L2 cache are on the CPU these days. Double check with the
> processor docs and vendor but I think mcelog is actually trying to
> tell you that the CPU wants to be warranty returned. It might also
> of course be a heat problem.

I've cleaned the fan and cooler and put a huge fan next to the open
case, blowing any heat out of it. I saw the errors again, even
without any load.

Thus I guess the CPU is asking for retirement. I am just
double-checking with you guys whether I can be sure that it's only
the CPU, or whether it could also be the fault of the motherboard...

Thanks,

--=20
martin;              (greetings from the heart of the sun.)
  \____ echo mailto: !#^."<*>"|tr "<*> mailto:" net@madduck
=20
spamtraps: madduck.bogus@madduck.net
=20
time wounds all heels.
                                                       -- groucho marx

--WIyZ46R2i8wDzkSu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature (GPG/PGP)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFWt1+IgvIgzMMSnURAg+iAJ9+IZ3U+kiu4B69g4y9mOwmhKIBXwCgxd8z
dMGGs3p6e90lIKqYx1NSxMU=
=gi5G
-----END PGP SIGNATURE-----

--WIyZ46R2i8wDzkSu--
