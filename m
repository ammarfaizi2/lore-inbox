Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272121AbRIJXPi>; Mon, 10 Sep 2001 19:15:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272122AbRIJXP2>; Mon, 10 Sep 2001 19:15:28 -0400
Received: from imap.digitalme.com ([193.97.97.75]:42574 "EHLO digitalme.com")
	by vger.kernel.org with ESMTP id <S272121AbRIJXPV>;
	Mon, 10 Sep 2001 19:15:21 -0400
Subject: Trident sound compiled in in 2.4.9 and 2.4.10-pre7
From: "Trever L. Adams" <vichu@digitalme.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-D9Y0OnooDpshmdAgAs5u"
X-Mailer: Evolution/0.13.99+cvs.2001.09.05.07.08 (Preview Release)
Date: 10 Sep 2001 19:15:16 -0400
Message-Id: <1000163728.1010.4.camel@aurora>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-D9Y0OnooDpshmdAgAs5u
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

My system crashes with an oops (haven't written it down yet).  I found
that if I compile the trident sound as a module it doesn't crash.  This
is true even after insert.  If I don't compile it as a module it oopses
on boot right before it would bring up the Networking things (after the
few lines of output are given for sound).

I just wanted to provide a heads up.  I will be trying to capture the
oops soon and sending it on.

It works fine in 2.4.8.

Trever Adams

--=-D9Y0OnooDpshmdAgAs5u
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA7nUmEnkhkvieoi8wRAulLAKCYY94bRQPIhsgYsBCkjaPD3GSXMQCeM84/
VTpVs2Yu11hVrmdl4NPAZDc=
=Y2oS
-----END PGP SIGNATURE-----

--=-D9Y0OnooDpshmdAgAs5u--

