Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265272AbUAHPlt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 10:41:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263946AbUAHPlt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 10:41:49 -0500
Received: from absinthe.ifi.unizh.ch ([130.60.75.58]:43181 "EHLO
	diamond.madduck.net") by vger.kernel.org with ESMTP id S265272AbUAHPlL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 10:41:11 -0500
Date: Thu, 8 Jan 2004 16:41:09 +0100
From: martin f krafft <madduck@madduck.net>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: scheduling problems in X with 2.6.0
Message-ID: <20040108154109.GB29224@piper.madduck.net>
Mail-Followup-To: Nick Piggin <piggin@cyberone.com.au>,
	linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <20040107102352.GA2954@piper.madduck.net> <3FFC2621.7060808@cyberone.com.au> <20040107174606.GA25307@piper.madduck.net> <3FFD789D.7020908@cyberone.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UHN/qo2QbUvPLonB"
Content-Disposition: inline
In-Reply-To: <3FFD789D.7020908@cyberone.com.au>
X-OS: Debian GNU/Linux testing/unstable kernel 2.6.0-diamond i686
X-Mailer: Mutt 1.5.4i (2003-03-19)
X-Motto: Keep the good times rollin'
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--UHN/qo2QbUvPLonB
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Nick Piggin <piggin@cyberone.com.au> [2004.01.08.1634 +0100]:
> You could try my alternate CPU scheduler which would tell us if your
> problem is the scheduler or something else. Its against the mm tree.
> http://www.kerneltrap.org/~npiggin/v29p6.gz

=46rom a quick glance, it mentions the Pentium 4 and Hyperthreading.
This *is* an SMP system, but it uses Athlon XPs. Will your scheduler
still work?

--=20
martin;              (greetings from the heart of the sun.)
  \____ echo mailto: !#^."<*>"|tr "<*> mailto:" net@madduck
=20
invalid/expired pgp subkeys? use subkeys.pgp.net as keyserver!
=20
government announcement - the government announced today that it is
changing its mascot to a condom because it more clearly reflects the
government's political stance. a condom stands up to inflation, halts
production, destroys the next generation, protects a bunch of pricks
and finally, gives you a sense of security while you're being screwed!

--UHN/qo2QbUvPLonB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE//XoVIgvIgzMMSnURAut6AKC/sa4+Yqiwu62lmYjb9UxOW0DVZwCgp8jD
YFZgxHpuhEwxiKuIn6ATrgw=
=Jim5
-----END PGP SIGNATURE-----

--UHN/qo2QbUvPLonB--
