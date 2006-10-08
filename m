Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750805AbWJHSWN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750805AbWJHSWN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 14:22:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750835AbWJHSWN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 14:22:13 -0400
Received: from lug-owl.de ([195.71.106.12]:58275 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S1750805AbWJHSWM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 14:22:12 -0400
Date: Sun, 8 Oct 2006 20:22:10 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Adrian Bunk <bunk@stusta.de>
Cc: Pekka Enberg <penberg@cs.helsinki.fi>,
       Trond Myklebust <Trond.Myklebust@netapp.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-rc1: known regressions (v2)
Message-ID: <20061008182210.GP30283@lug-owl.de>
Mail-Followup-To: Adrian Bunk <bunk@stusta.de>,
	Pekka Enberg <penberg@cs.helsinki.fi>,
	Trond Myklebust <Trond.Myklebust@netapp.com>,
	linux-kernel@vger.kernel.org
References: <EXSVLRB01xe0ymQ1WE900000265@exsvlrb01.hq.netapp.com> <20061008045522.GG29474@stusta.de> <1160283948.10192.3.camel@lade.trondhjem.org> <20061008063943.GB6755@stusta.de> <84144f020610080045s6d2d1b06o6fc78bfb8fbf4d77@mail.gmail.com> <20061008172859.GD6755@stusta.de> <20061008173445.GN30283@lug-owl.de> <20061008175908.GG6755@stusta.de> <20061008180437.GO30283@lug-owl.de> <20061008181546.GH6755@stusta.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VbXIs2ae+j0NhctA"
Content-Disposition: inline
In-Reply-To: <20061008181546.GH6755@stusta.de>
X-Operating-System: Linux mail 2.6.12.3lug-owl 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--VbXIs2ae+j0NhctA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, 2006-10-08 20:15:46 +0200, Adrian Bunk <bunk@stusta.de> wrote:
> On Sun, Oct 08, 2006 at 08:04:37PM +0200, Jan-Benedict Glaw wrote:
> > On Sun, 2006-10-08 19:59:08 +0200, Adrian Bunk <bunk@stusta.de> wrote:
> > > > Read the bug report: Seems it
> > > > was actually caused by a non-initialized variable introduced by a
> > > > patch to util-linux.
> > >=20
> > > It was the sum of two independent bugs, and one of them was a kernel =
bug.
> >=20
> > Without reading the sources but only the bug report, my impression is
> > that the kernel code is correct.
>=20
> It seems you missed Comment #1 when reading the bug report?

Indeed. I'm sorry.

MfG, JBG

--=20
      Jan-Benedict Glaw      jbglaw@lug-owl.de              +49-172-7608481
  Signature of:                        Lauf nicht vor Deinem Gl=C3=BCck dav=
on:
  the second  :                             Es k=C3=B6nnte hinter Dir stehe=
n!

--VbXIs2ae+j0NhctA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFFKUHSHb1edYOZ4bsRAjY8AKCLHCfJeQptahLpVsmvxuCn0EoDugCfTI4E
LYNteAj5PcILWA1AzMmLJ7w=
=4zXC
-----END PGP SIGNATURE-----

--VbXIs2ae+j0NhctA--
