Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261358AbVB0Kum@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261358AbVB0Kum (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Feb 2005 05:50:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261372AbVB0Kul
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Feb 2005 05:50:41 -0500
Received: from armagnac.ifi.unizh.ch ([130.60.75.72]:46266 "EHLO
	albatross.madduck.net") by vger.kernel.org with ESMTP
	id S261358AbVB0Kub (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Feb 2005 05:50:31 -0500
Date: Sat, 26 Feb 2005 16:39:05 +0100
From: martin f krafft <madduck@madduck.net>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: Pavel Machek <pavel@ucw.cz>
Subject: Re: swsusp logic error?
Message-ID: <20050226153905.GA8108@localhost.localdomain>
Mail-Followup-To: linux kernel mailing list <linux-kernel@vger.kernel.org>,
	Pavel Machek <pavel@ucw.cz>
References: <20050208203950.GA21623@cirrus.madduck.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gKMricLos+KVdGMg"
Content-Disposition: inline
In-Reply-To: <20050209220750.GB2065@elf.ucw.cz>
X-OS: Debian GNU/Linux 3.1 kernel 2.6.10-wing i686
X-Mailer: Mutt 1.5.6+20040907i (CVS)
X-Motto: Keep the good times rollin'
X-Subliminal-Message: debian/rules!
X-Spamtrap: madduck.bogus@madduck.net
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Sorry for the late reply, I've been strung up with work. I tried
your suggestion on another machine, with a vanilla 2.6.10 kernel and
a single swap device, twice the size of the physical RAM; I get
exactly the same result. The swap device cannot be found.

What to try next?

--=20
martin;              (greetings from the heart of the sun.)
  \____ echo mailto: !#^."<*>"|tr "<*> mailto:" net@madduck
=20
invalid/expired pgp subkeys? use subkeys.pgp.net as keyserver!
spamtraps: madduck.bogus@madduck.net
=20
to err is human - to moo, bovine

--gKMricLos+KVdGMg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFCIJgZIgvIgzMMSnURAqAdAJ0fNPAc5kKlTkxlHfKPvkmsDZ3M+QCff9Zc
YbSJCnrxLnRGlvjzc9ZLB80=
=Gb0o
-----END PGP SIGNATURE-----

--gKMricLos+KVdGMg--
