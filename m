Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284484AbRLEQvy>; Wed, 5 Dec 2001 11:51:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284487AbRLEQvo>; Wed, 5 Dec 2001 11:51:44 -0500
Received: from marsh-49.owlnet.rice.edu ([128.42.49.222]:42735 "EHLO
	marsh.owlnet.rice.edu") by vger.kernel.org with ESMTP
	id <S284484AbRLEQvd>; Wed, 5 Dec 2001 11:51:33 -0500
Subject: "NETDEV WATCHDOG eth0 transmit timeout" fun with ne2k-pci
From: Joshua Adam Ginsberg <rainman@owlnet.rice.edu>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-BALnPoxz9rgql02Cuh+C"
X-Mailer: Evolution/1.0 (Preview Release)
Date: 05 Dec 2001 10:50:44 -0600
Message-Id: <1007571044.26591.7.camel@stud-assoc-pc2.rice.edu>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-BALnPoxz9rgql02Cuh+C
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

In browsing this group's archives, I've found tons of people having
problems with their ethernet seemingly going dead and their
/var/log/messages filled with "kernel: NETDEV WATCHDOG: eth0: transmit
timed out" over and over and over again...

I'm having that problem running a Winbond 89c940 (which I could swear is
on a Linksys card) using the ne2k-pci drivers on the 2.4.7-10 that ships
with RH7.2...

Any hope in an easy resolution to this?

Thanks!

-jag


--=20
--------------------------------------------------------
Joshua Ginsberg                 rainman@owlnet.rice.edu
Director of Technology          dirtech@sa.rice.edu
Student Association             AIM: L0stInTheDesert
Rice University, Houston, TX    Cellphone: 713.478.1769
-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
"Programming today is a race between software engineers
striving to build bigger and better idiot-proof programs
and the Universe trying to produce bigger and better
idiots. So far, the Universe is winning." -Rich Cook
--------------------------------------------------------

--=-BALnPoxz9rgql02Cuh+C
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEABECAAYFAjwOUGQACgkQtPt+7vptHHik8ACguNV/fFTiD+kZ8UPcLjF0l35R
aygAoIIAl1O17OR2JxjfKTTaWGT1coa+
=1LkX
-----END PGP SIGNATURE-----

--=-BALnPoxz9rgql02Cuh+C--

