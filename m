Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262328AbTHaBbP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Aug 2003 21:31:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262350AbTHaBbP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Aug 2003 21:31:15 -0400
Received: from 200-55-45-156-tntats2.dial-up.net.ar ([200.55.45.156]:61149
	"EHLO smtp.bensa.ar") by vger.kernel.org with ESMTP id S262328AbTHaBbN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Aug 2003 21:31:13 -0400
From: Norberto BENSA <nbensa@gmx.net>
Organization: BENSA.ar
To: Marcelo Tosatti <marcelo@parcelfarce.linux.theplanet.co.uk>,
       "J.A. Magallon" <jamagallon@able.es>
Subject: Re: [PATCH] check_gcc for i386
Date: Sat, 30 Aug 2003 20:20:45 -0300
User-Agent: KMail/1.5.3
Cc: <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0308301957440.20117-100000@logos.cnet>
In-Reply-To: <Pine.LNX.4.44.0308301957440.20117-100000@logos.cnet>
X-PGP-Key: http://pgp.mit.edu:11371/pks/lookup?op=get&search=0x49664BBE
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_NFTU/PcqmPPIzeG";
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200308302020.45564.nbensa@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_NFTU/PcqmPPIzeG
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Description: signed data
Content-Disposition: inline

Marcelo Tosatti wrote:
> On Sun, 31 Aug 2003, J.A. Magallon wrote:
> > +CFLAGS +=3D $(call check_gcc,-march=3Dpentium4,-march=3Di686)
> >  endif
> >
>
> OK, I forgot what that does. Can you please explain in detail what
> check_gcc does.

Hmmm... Parhaps it checks if gcc supports those command line parameters (ju=
st=20
a wild guess)? Marcelo, do you need a break? :-)

With best regards,
Norberto

--Boundary-02=_NFTU/PcqmPPIzeG
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/UTFNFXVF50lmS74RAtZuAKCCnXyRpt3RJz1YuWRcoZfJ5QVK+wCeMH1c
puqEwH/Ml1D7jCjuOopX+74=
=+80/
-----END PGP SIGNATURE-----

--Boundary-02=_NFTU/PcqmPPIzeG--

