Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266487AbSK1Upk>; Thu, 28 Nov 2002 15:45:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266728AbSK1Upk>; Thu, 28 Nov 2002 15:45:40 -0500
Received: from attila.bofh.it ([213.92.8.2]:17357 "EHLO attila.bofh.it")
	by vger.kernel.org with ESMTP id <S266487AbSK1Upj>;
	Thu, 28 Nov 2002 15:45:39 -0500
Date: Thu, 28 Nov 2002 21:52:47 +0100
From: "Marco d'Itri" <md@Linux.IT>
To: Gerd Knorr <kraxel@bytesex.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
Subject: Re: [RELEASE] module-init-tools 0.8
Message-ID: <20021128205247.GA4135@wonderland.linux.it>
References: <20021128023017.91FAC2C250@lists.samba.org> <200211281616.gASGGOE6012229@bytesex.org> <200211281823.gASINAuN014312@bytesex.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="y0ulUmNC+osPPQO6"
Content-Disposition: inline
In-Reply-To: <200211281823.gASINAuN014312@bytesex.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Nov 28, Gerd Knorr <kraxel@bytesex.org> wrote:

 >login as user (with $HOME at nfs).  Various modules still fail to
 >load (bttv driver, matroxfb):
 >
 >WARNING: Error inserting v4l2_common (/lib/modules/2.5.50/kernel/v4l2-com=
mon.o): Invalid module format
 >WARNING: Error inserting video_buf (/lib/modules/2.5.50/kernel/video-buf.=
o): Invalid module format
 >FATAL: Error inserting bttv (/lib/modules/2.5.50/kernel/bttv.o): Unknown =
symbol in module

I experience the same problem (with saa7134) since 2.5.49.
2.5.48 worked.

This happens both with module-init-tools 0.7 and 0.8.

--=20
ciao,
Marco

--y0ulUmNC+osPPQO6
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE95oIfFGfw2OHuP7ERAieIAJ9xL7LbBRiD5zGi59/Umm7eDRp1jQCfVuMF
aM7mEbeCTZbnQS+3ItsvSes=
=ePcB
-----END PGP SIGNATURE-----

--y0ulUmNC+osPPQO6--
