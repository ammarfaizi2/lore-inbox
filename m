Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262055AbTK2LZw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Nov 2003 06:25:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262190AbTK2LZw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Nov 2003 06:25:52 -0500
Received: from adsl-67-121-153-191.dsl.pltn13.pacbell.net ([67.121.153.191]:41608
	"EHLO triplehelix.org") by vger.kernel.org with ESMTP
	id S262055AbTK2LZu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Nov 2003 06:25:50 -0500
Date: Sat, 29 Nov 2003 03:25:49 -0800
To: Christopher Sawtell <csawtell@paradise.net.nz>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: bug in -test11 make xconfig
Message-ID: <20031129112549.GD15782@triplehelix.org>
Mail-Followup-To: joshk@triplehelix.org,
	Christopher Sawtell <csawtell@paradise.net.nz>,
	linux-kernel mailing list <linux-kernel@vger.kernel.org>
References: <200311292325.44935.csawtell@paradise.net.nz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PHCdUe6m4AxPMzOu"
Content-Disposition: inline
In-Reply-To: <200311292325.44935.csawtell@paradise.net.nz>
User-Agent: Mutt/1.5.4i
From: Joshua Kwan <joshk@triplehelix.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--PHCdUe6m4AxPMzOu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 29, 2003 at 11:25:44PM +1300, Christopher Sawtell wrote:
>   I have noticed that it is not possible to configure the kernel to use t=
he=20
> xfs file system using the 'make xconfig' command.
>   'make menuconfig' and 'make gconfig' appear to work correctly.

I assume this is a 2.5 or 2.6 kernel source you are talking about,
since gconfig is unavailable in 2.4. Could you be more precise?

With 2.6.0-test11 I'm able to enable XFS support through xconfig.

>  No need to reply, & I'm not worth to be be subscribed because of insuffi=
cient> knowledge.

If you didn't want anyone to reply you wouldn't have posted this message
to begin with.

And sometimes it's a curse to be subscribed to linux-kernel. There's
lots to read all the time. :)

--=20
Joshua Kwan

--PHCdUe6m4AxPMzOu
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iQIVAwUBP8iCPKOILr94RG8mAQLHgBAApoU0quKFMEzJMNN7N4FcCY286PWO1lBJ
L02Wl/Myy2DCSfyX93GOKr7PpEJM79laIZVKbWqr9zxrGByryimWAUlbxVZcI02z
dXS13z02gINawcMPQTcKkW4jtCQACywVHXnnml1qX0RE+2C5WBBSta53WM16i0OI
51WGoUIZBeHB+KJwk0GSCuU9Ohs7Sth2cZGpbuGlHkL9ypcfMisiMR+DPw/iXRlp
inNdpPg/fHrf3t7qQWm296luzetl+JxuvHVLSnqTLGYP41tK7gBG8sRuKrIl+KGr
kTy6vAeCDRpJqt9/MZzQaIFqdAdVxVKzJtrUP7/i/5x4Mu+cBd+ednJf8ptxdEdW
L93Xjxv0XPWomNJbFufIEQYiriKDtyiBgfOJEkd5ef+5l56372k3/tDPN64/F3Y2
OcS2BMz5XVE6xHWZV0XLVfvlZFE/cD4Z2pt9UO2ClpqjkAfHLReJLV1fnEqJx9pU
d//Dj3xzwFt65WjI5t0meEZfBMcqSXE+s6W2FGUixPNECy1XTe63Uvqs6pwclDR+
ncVhk6NlOe92W81x1w0ELK06Qtyf/DW6U0G072hRcyfpXlUrevCX/Z3n7QJmI/4p
0x1wL+VRAXjSY79e8HbVMaalgbtp3H5dO8pFvKQT8k1ZoLgrZ4OMucEQFKNaEWZP
QzW3dWzSiM8=
=tC14
-----END PGP SIGNATURE-----

--PHCdUe6m4AxPMzOu--
