Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261212AbULRSQb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261212AbULRSQb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Dec 2004 13:16:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261214AbULRSQb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Dec 2004 13:16:31 -0500
Received: from ntp.nuit.ca ([66.11.160.83]:14464 "EHLO smtp.nuit.ca")
	by vger.kernel.org with ESMTP id S261212AbULRSQ2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Dec 2004 13:16:28 -0500
Date: Sat, 18 Dec 2004 13:16:27 -0500
From: simon@nuit.ca
To: linux-kernel@vger.kernel.org
Subject: PPP woes, continued
Message-ID: <20041218181627.GA8047@nuit.ca>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/9DWx/yDrRhgMJTb"
Content-Disposition: inline
X-Operating-System: Debian GNU/Linux
X-GPG-Key-Server: x-hkp://subkeys.pgp.net
User-Agent: Mutt/1.5.6+20040907i
X-Scan-Signature: smtp.nuit.ca 1Cfj7z-00027M-Cn 2e3c26f822620af3767e81d2d0f6375a
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


hello again,

made an interesting discovery. i'm willing to bet that pppd is still
unstable as hell, *but*, i've been able to work around the problems with
ifconfig locking up the box or causing oopses by using the iproute
utils. good incentive to work exclusively with those tools, at least for
now ;).

again, please CC: me.

eric


--=20
"... being a Linux user is sort of like living in a house inhabited
by a large family of carpenters and architects. Every morning when
you wake up, the house is a little different. Maybe there is a new
turret, or some walls have moved. Or perhaps someone has temporarily
removed the floor under your bed." - Unix for Dummies, 2nd Edition

--/9DWx/yDrRhgMJTb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iQGVAwUBQcRz+mqIeuJxHfCXAQIsegv+N/SHb6n4r2Y8+/6uXG3nMj/Nb9JauMnJ
LCvTHG4F8ypdwZbDa3ucH8ZtSpl0F9SWgX9ydSHK6J263hBaOZkkxexG+Kfl9n8+
7pbFF057VXwxmPvDJKZUIrxZrwB5JljmeqdO0XTxfQFNyokT0vZDpPV/n9gTMov4
AbdJ1v64rT8rKjr1sVTK4cBrUBY8EMRJHmREImP8y5B7jZ7SJuZkyRMo5h5paane
H0h2ZETk7OaZJWgXXTNCOYhssbxNQQNxkSTLuzeazn3PYTAAo3OncDsIm6gl8eO/
kwXh9KPl+oOS1cowPGkYpnmjgxqp9Gd+LqKkKqk41y4OAN9I59QhCMdMqM/uUHUl
+RFn/SozlIAUnpU6in0BC3rvzAFDV0s3xVxD1MBG2QNLQUQ5QxodXyAhb64K6JIZ
9dvhYguWloJQkg1e/wUHt7whEwEbJROhOQ/dSgjq7tHxn2R953ME9GFih3bONsed
x8tbi8AOnzu4UWO05+ieDCLn33aO3O4f
=wcDk
-----END PGP SIGNATURE-----

--/9DWx/yDrRhgMJTb--
