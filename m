Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932164AbWAARti@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932164AbWAARti (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jan 2006 12:49:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932168AbWAARti
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jan 2006 12:49:38 -0500
Received: from moutng.kundenserver.de ([212.227.126.186]:17622 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S932164AbWAARth (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jan 2006 12:49:37 -0500
From: Prakash Punnoor <prakash@punnoor.de>
To: "Alexander E. Patrakov" <patrakov@gmail.com>
Subject: Re: MPlayer broken under 2.6.15-rc7-rt1?
Date: Sun, 1 Jan 2006 18:50:28 +0100
User-Agent: KMail/1.9
Cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org
References: <20051231202933.4f48acab@galactus.example.org> <1136114772.17830.20.camel@laptopd505.fenrus.org> <43B7E576.6000004@gmail.com>
In-Reply-To: <43B7E576.6000004@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2857211.bSJb8e7YKc";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200601011850.29155.prakash@punnoor.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:cec1af1025af73746bdd9be3587eb485
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2857211.bSJb8e7YKc
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Am Sonntag Januar 1 2006 15:21 schrieb Alexander E. Patrakov:
> Arjan van de Ven wrote:
> > What you have here is a bit of a gray area; you're using one of the
> > maybe-illegal binary modules that has a really long history of
> > introducing bugs that, just from the oops, may appear unrelated to this
> > module, and you can't reproduce it without. Just not because the bug
> > won't happen, but because you state that the application that triggers
> > it won't run without it.
>
> Wrong. The "nv" driver supports xvideo, and does this better than the
> official "nvidia" driver. When I had a GeForce 2 MX 200 (now this card
> is dead), my computer was was fast enough to play DVDs with
> deinterlacing with the "nv" driver, but not with "nvidia". Probably due
> to improper MTRR setup done by the "nvidia" driver.

It depends on what you call "better". If you want to watch HD resolution=20
videos w/o stutters, you need the Nvidia one, as the nv one just wastes CPU=
=20
cycles.

=2D-=20
(=B0=3D                 =3D=B0)
//\ Prakash Punnoor /\\
V_/                 \_V

--nextPart2857211.bSJb8e7YKc
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBDuBZlxU2n/+9+t5gRAjZXAJ9j70tf9ZEGYuT56e6ZR79pwYuPlgCg19xD
DWxi6Du+47KskFp4AGk2yTs=
=bdIK
-----END PGP SIGNATURE-----

--nextPart2857211.bSJb8e7YKc--
