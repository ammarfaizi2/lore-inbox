Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265392AbUAHPoh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 10:44:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265400AbUAHPnK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 10:43:10 -0500
Received: from absinthe.ifi.unizh.ch ([130.60.75.58]:44717 "EHLO
	diamond.madduck.net") by vger.kernel.org with ESMTP id S265392AbUAHPm4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 10:42:56 -0500
Date: Thu, 8 Jan 2004 16:42:55 +0100
From: martin f krafft <madduck@madduck.net>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: scheduling problems in X with 2.6.0
Message-ID: <20040108154255.GC29224@piper.madduck.net>
Mail-Followup-To: linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <20040107102352.GA2954@piper.madduck.net> <3FFC2621.7060808@cyberone.com.au> <20040107174606.GA25307@piper.madduck.net> <3FFD789D.7020908@cyberone.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sHrvAb52M6C8blB9"
Content-Disposition: inline
In-Reply-To: <3FFD789D.7020908@cyberone.com.au>
X-OS: Debian GNU/Linux testing/unstable kernel 2.6.0-diamond i686
X-Mailer: Mutt 1.5.4i (2003-03-19)
X-Motto: Keep the good times rollin'
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--sHrvAb52M6C8blB9
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Nick Piggin <piggin@cyberone.com.au> [2004.01.08.1634 +0100]:
> OK so its not VM stalls. In fact, it looks like your system is
> only under a moderate load.

I would not expect so. I find it kinda hard to load a system with 2Gb
of RAM and a dual Athlon XP 2400+ using only rsync... the
harddrive bottleneck prevents it from breaking a sweat.

--=20
martin;              (greetings from the heart of the sun.)
  \____ echo mailto: !#^."<*>"|tr "<*> mailto:" net@madduck
=20
invalid/expired pgp subkeys? use subkeys.pgp.net as keyserver!
=20
linux is like a wigwam.
no gates, no windoze, and an apache inside.

--sHrvAb52M6C8blB9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE//Xp/IgvIgzMMSnURAkA2AJ91MBjQxszYHVHf8Re9Vs4FbdPAJACg64ic
CQgJc41rUyH5dhqQ6WDm55c=
=94Qk
-----END PGP SIGNATURE-----

--sHrvAb52M6C8blB9--
