Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266964AbTBQKWN>; Mon, 17 Feb 2003 05:22:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266967AbTBQKWN>; Mon, 17 Feb 2003 05:22:13 -0500
Received: from [213.69.232.58] ([213.69.232.58]:60169 "HELO schottelius.net")
	by vger.kernel.org with SMTP id <S266964AbTBQKWM>;
	Mon, 17 Feb 2003 05:22:12 -0500
Date: Sat, 15 Feb 2003 16:31:55 +0100
From: Nico Schottelius <schottelius@wdt.de>
To: Torrey Hoffman <thoffman@arnor.net>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [Linux-fbdev-devel] Re: New logo code [CONFIG OPTIONS]
Message-ID: <20030215153154.GB469@schottelius.org>
References: <Pine.GSO.4.21.0302051336170.16681-100000@vervain.sonytel.be> <1044472678.1321.388.camel@rohan.arnor.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tsOsTdHNUZQcU9Ye"
Content-Disposition: inline
In-Reply-To: <1044472678.1321.388.camel@rohan.arnor.net>
User-Agent: Mutt/1.4i
X-Operating-System: Linux flapp 2.5.60
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--tsOsTdHNUZQcU9Ye
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[snipped out patch discussion]

I think if the patch and the features talked about are included in the
kernel we'll have (names are not correct)

CONFIG_LOGO=3Dy/n
CONFIG_LOGO_XRES=3D128
CONFIG_LOGO_YRES=3D64
CONFIG_LOGO_BPP=3D8
CONFIG_LOGO_PATH=3D"" # (/usr/src/linux/.../logo/tux.pnm)
CONFIG_LOGO_POS_X=3D"left|center|right"  # or absolute ?
CONFIG_LOGO_POS_Y=3D"top|center|bottom"  # like X windows +110,+200 ?
CONFIG_LOGO_BGCOL=3D#ef0000              # depends on bpp of framebuffer...=
=20

I think this would be enough for all and possible implementable for the
developers..or am I wrong ?

Greetings,

Nico

--tsOsTdHNUZQcU9Ye
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE+Tl1qtnlUggLJsX0RAoU0AJ94PeWZpsfFrToOYGOCyv2O+IzZYQCfQzps
v856NDyLp8A4vKMZjhEqrLg=
=zOUg
-----END PGP SIGNATURE-----

--tsOsTdHNUZQcU9Ye--
