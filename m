Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262254AbUKQJav@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262254AbUKQJav (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 04:30:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262252AbUKQJ3s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 04:29:48 -0500
Received: from armagnac.ifi.unizh.ch ([130.60.75.72]:51353 "EHLO
	albatross.madduck.net") by vger.kernel.org with ESMTP
	id S262248AbUKQJ2s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 04:28:48 -0500
Date: Wed, 17 Nov 2004 10:28:47 +0100
From: martin f krafft <madduck@madduck.net>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: about /proc/*/stat
Message-ID: <20041117092847.GA961@cirrus.madduck.net>
Mail-Followup-To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/04w6evG8XlLl3ft"
Content-Disposition: inline
X-OS: Debian GNU/Linux 3.1 kernel 2.6.8-cirrus i686
X-Mailer: Mutt 1.5.6+20040907i (CVS)
X-Motto: Keep the good times rollin'
X-Subliminal-Message: debian/rules!
X-Spamtrap: madduck.bogus@madduck.net
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

If I look at /proc/meminfo, I see each number prefixed with a short
identifying name. Looking at /proc/*/stat, however, I have to count
fields to get to the field I want. I realise that it's probably not
possible to change the format of this file (since it's read by
ps(1), among others), but I wonder if you have any tools that parse
it, similar to /proc/meminfo -- i.e. primarily for debugging?

If not, I have a shell script that works well and which I would then
publicise. I just don't want to push yet another software doing
The Same Thing out there...

--=20
martin;              (greetings from the heart of the sun.)
  \____ echo mailto: !#^."<*>"|tr "<*> mailto:" net@madduck
=20
invalid/expired pgp subkeys? use subkeys.pgp.net as keyserver!
spamtraps: madduck.bogus@madduck.net
=20
"no, 'eureka' is greek for 'this bath is too hot.'"
                                                            -- dr. who

--/04w6evG8XlLl3ft
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBmxnPIgvIgzMMSnURArVvAKCx+mbySGPr4z9rTabWCf0B6CXCNwCfXHHz
Vu7Neq6ii9TQQl+zDq1r45A=
=4uUY
-----END PGP SIGNATURE-----

--/04w6evG8XlLl3ft--
