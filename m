Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264265AbUHWNj2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264265AbUHWNj2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 09:39:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264286AbUHWNj2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 09:39:28 -0400
Received: from absinthe.ifi.unizh.ch ([130.60.75.58]:7048 "EHLO
	diamond.madduck.net") by vger.kernel.org with ESMTP id S264265AbUHWNjZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 09:39:25 -0400
Date: Mon, 23 Aug 2004 15:39:20 +0200
From: martin f krafft <madduck@madduck.net>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: cx8800 log messages
Message-ID: <20040823133920.GA6239@diamond.madduck.net>
Mail-Followup-To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GvXjxJ+pjyke8COw"
Content-Disposition: inline
X-OS: Debian GNU/Linux 3.1 kernel 2.6.8-1-k7-smp i686
X-Mailer: Mutt 1.5.6+20040722i (CVS)
X-Motto: Keep the good times rollin'
X-Subliminal-Message: debian/rules!
X-Spamtrap: madduck.bogus@madduck.net
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I just upgraded to 2.6.8 (K7, SMP) using the Debian kernel. Now
I get a message from each of the two cx8800 cards in the machine
every second:

cx8800[0]: AUD_STATUS: 0xfbb2 [mono/no pilot] ctl=3DBTSC_AUTO_STEREO

What is this about? And how can I disable it?

Thanks,

--=20
martin;              (greetings from the heart of the sun.)
  \____ echo mailto: !#^."<*>"|tr "<*> mailto:" net@madduck
=20
invalid/expired pgp subkeys? use subkeys.pgp.net as keyserver!
spamtraps: madduck.bogus@madduck.net
=20
"i call christianity the one great curse, the one enormous and
 innermost perversion, the one great instinct of revenge, for which no
 means are too venemous, too underhand, too underground and too petty
 -- i call it the one immortal blemish of mankind."
                                                 - friedrich nietzsche

--GvXjxJ+pjyke8COw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBKfOIIgvIgzMMSnURAvl3AKDJ1q1VABSBKpPzPscwPFjTu8/5XQCcC7j9
D1FwRZ/bIW5apYKUzTbxq1Y=
=fusF
-----END PGP SIGNATURE-----

--GvXjxJ+pjyke8COw--
