Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315951AbSEGT1Z>; Tue, 7 May 2002 15:27:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315952AbSEGT1Y>; Tue, 7 May 2002 15:27:24 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:58378 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id <S315951AbSEGT1Y>;
	Tue, 7 May 2002 15:27:24 -0400
Date: Tue, 7 May 2002 21:27:23 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: pfn-Functionset out of order for sparc64 in current Bk tree?
Message-ID: <20020507192722.GD25874@lug-owl.de>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <61DB42B180EAB34E9D28346C11535A783A75DF@nocmail101.ma.tmpw.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bjuZg6miEcdLYP6q"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux mail 2.4.18 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--bjuZg6miEcdLYP6q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 2002-05-07 14:12:29 -0500, Holzrichter, Bruce <bruce.holzrichter@mo=
nster.com>
wrote in message <61DB42B180EAB34E9D28346C11535A783A75DF@nocmail101.ma.tmpw=
.net>:
> >  - pfn_to_page(pfn) is declared as (mem_map + (pfn)) for=20

[ pfn stuff removed ]

Well, the pfn stuff is 100 rifle shots into feet. It broke so far all
architectures (not only Sparc64), but also Alpha and all the others.
It would have been nice if they were worked out and submitted with the
initial patch...

MfG, JBG

--=20
Jan-Benedict Glaw   .   jbglaw@lug-owl.de   .   +49-172-7608481
	 -- New APT-Proxy written in shell script --
	   http://lug-owl.de/~jbglaw/software/ap2/

--bjuZg6miEcdLYP6q
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjzYKpoACgkQHb1edYOZ4bvs6QCbBQymyMBTmV6uigUoGgwfoTPf
OscAn147fLEujBr/qjBzIEb7mRj7GkN8
=Ktu7
-----END PGP SIGNATURE-----

--bjuZg6miEcdLYP6q--
