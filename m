Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268342AbRIDTqE>; Tue, 4 Sep 2001 15:46:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268432AbRIDTpy>; Tue, 4 Sep 2001 15:45:54 -0400
Received: from cs666822-222.austin.rr.com ([66.68.22.222]:20870 "EHLO
	igor.taral.net") by vger.kernel.org with ESMTP id <S268342AbRIDTpp>;
	Tue, 4 Sep 2001 15:45:45 -0400
Date: Tue, 4 Sep 2001 14:46:05 -0500
From: Taral <taral@taral.net>
To: linux-kernel@vger.kernel.org
Subject: DEVFS_FL_AUTO_DEVNUM on block devices
Message-ID: <20010904144605.A5496@taral.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HlL+5n6rz5pIUxbD"
Content-Disposition: inline
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm trying to write a device driver that dynamically creates block
devices (kind of like loop does). I'd like to use DEVFS_FL_AUTO_DEVNUM,
but it looks like devfs doesn't initialize the block queues in any
useful way. Does anyone have any code that I can use? If so, Cc: me on
replies. Thanks!

--=20
Taral <taral@taral.net>
This message is digitally signed. Please PGP encrypt mail to me.
"Any technology, no matter how primitive, is magic to those who don't
understand it." -- Florence Ambrose

--HlL+5n6rz5pIUxbD
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjuVL3wACgkQoQQF8xCPwJR8kgCcC2QcEwoxEzIhxl2UEGJ4oNxF
bb0AnAlbsAqAY1NDucOsq0LktjMvAGB3
=wZl2
-----END PGP SIGNATURE-----

--HlL+5n6rz5pIUxbD--
