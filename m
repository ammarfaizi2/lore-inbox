Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965032AbWIDXd0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965032AbWIDXd0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 19:33:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965033AbWIDXd0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 19:33:26 -0400
Received: from hentges.net ([81.169.178.128]:695 "EHLO
	h6563.serverkompetenz.net") by vger.kernel.org with ESMTP
	id S965032AbWIDXdZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 19:33:25 -0400
Subject: Re: sky2 hangs on me again: This time 200 kb/s IPv4 traffic, not
	easily reproducable
From: Matthias Hentges <oe@hentges.net>
To: shogunx <shogunx@sleekfreak.ath.cx>
Cc: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
       Stephen Hemminger <shemminger@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0609041324240.4407-100000@sleekfreak.ath.cx>
References: <Pine.LNX.4.44.0609041324240.4407-100000@sleekfreak.ath.cx>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-HJMytYN4oS6Lk1F2ndSg"
Date: Tue, 05 Sep 2006 01:34:28 +0200
Message-Id: <1157412868.18988.15.camel@mhcln03>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-HJMytYN4oS6Lk1F2ndSg
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Am Montag, den 04.09.2006, 13:24 -0400 schrieb shogunx:
> >
> > I have yet to find a reproduceable way to trigger the bug but I'll try =
a
> > few things tomorrow.
> > Currently it appears to be completely ranom. I've loaded the driver w/
> > debug=3D10, maybe it'll give some clues.
>=20
> Seen that error again?  I've done everything I can think of to get this
> interface to fail, and I just can't do it.
>=20

After running almost a full day w/o problems, it freaked out on me when
debugging was disabled after a reboot *sigh*.
--=20
Matthias 'CoreDump' Hentges=20

Webmaster of hentges.net and OpenZaurus developer.
You can reach me in #openzaurus on Freenode.

My OS: Debian SID. Geek by Nature, Linux by Choice

--=-HJMytYN4oS6Lk1F2ndSg
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBE/LgEAq2P5eLUP5IRAqfgAKCJcSvg2PnJe2qnPGXgusb6HALxMQCfYMvz
IIleZUXtZxPhAo8AXAGLNtU=
=JSEi
-----END PGP SIGNATURE-----

--=-HJMytYN4oS6Lk1F2ndSg--

