Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286063AbRLHXXY>; Sat, 8 Dec 2001 18:23:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286061AbRLHXXP>; Sat, 8 Dec 2001 18:23:15 -0500
Received: from cmailg4.svr.pol.co.uk ([195.92.195.174]:50544 "EHLO
	cmailg4.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S286059AbRLHXXF>; Sat, 8 Dec 2001 18:23:05 -0500
Subject: APM woes: IBM T20 Thinkpad
From: Alex Hudson <home@alexhudson.com>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-m/d2Kj2m/Imbh7m+/N7C"
X-Mailer: Evolution/1.0 (Preview Release)
Date: 08 Dec 2001 23:20:34 +0000
Message-Id: <1007853635.584.0.camel@lapland>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-m/d2Kj2m/Imbh7m+/N7C
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

I'm running a self-compiled Linux 2.4.16-pre1 on a IBM-T20, and am
seeing problems with APM.

Most times I suspend (apm --suspend) I can't un-suspend successfully
(I've managed it _once_ ;). This is since upgrading - I was previously
using a Debian version of 2.4.9. I have gone down to the console,
turning off most services (e.g., ps aux is about one screen-ful) and it
still doesn't work, so it doesn't appear to be some other service.=20

When re-animating, the disks come on and the screen backlights, but
nothing much else. Disk access is non-existant (or at least,
sufficiently minimal that I can't detect it) and the network isn't
responding.=20

I've also seen a couple of other apm-wierdos - the battery being at 99%
full, for example, even after being on the charger for a while. I also
tend to see a lot of disk activity - the light flashes several times a
second - but then, I'm usually heavily into swap (running Gnome, etc..).

If someone could point out some tests I could try to pin this down, or
has some other suggestion, I would be very grateful.

Cheers,

Alex.


--=-m/d2Kj2m/Imbh7m+/N7C
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA8EqBC+gMffptpE9cRAmDeAJ9daut7F7BKIKEwg7n3bMzwULmJ8ACZAfW/
+1/KAllA9eleH1l33gmwz7I=
=dPZb
-----END PGP SIGNATURE-----

--=-m/d2Kj2m/Imbh7m+/N7C--

