Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263193AbTIGNs5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 09:48:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263247AbTIGNs5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 09:48:57 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:61358 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S263193AbTIGNsz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 09:48:55 -0400
Date: Sun, 7 Sep 2003 15:48:54 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org
Subject: Re: RFC: [2.6 patch] better i386 CPU selection
Message-ID: <20030907134854.GY14376@lug-owl.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20030907112813.GQ14436@fs.tum.de> <20030907114647.GR14376@lug-owl.de> <20030907131732.GU14436@fs.tum.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YZ2gLtJL3Gv805BH"
Content-Disposition: inline
In-Reply-To: <20030907131732.GU14436@fs.tum.de>
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--YZ2gLtJL3Gv805BH
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, 2003-09-07 15:17:32 +0200, Adrian Bunk <bunk@fs.tum.de>
wrote in message <20030907131732.GU14436@fs.tum.de>:
> On Sun, Sep 07, 2003 at 01:46:47PM +0200, Jan-Benedict Glaw wrote:
> > On Sun, 2003-09-07 13:28:13 +0200, Adrian Bunk <bunk@fs.tum.de>
> > wrote in message <20030907112813.GQ14436@fs.tum.de>:
> > > There are two different needs:
> > > 1. the installation kernel of a distribution should support all CPUs=
=20
> > >    this distribution supports (perhaps starting with the 386)
> >=20
> > So far, no major distribution does support an i386. Basically, this has
> > leaked in by some broken patch to libstdc++ which was not observed for a
> > long time. To support i386, an additional emulator for additional i486
> > needs to be compiled-in, too. I had a short try to port Debian's patch
> > into 2.6.x, but it oopsed :-> If I get some time, I'll finish that.
> > Before we have thie i486-emu-for-i386 in, i386 support in the kernel
> > doesn't make *any* sense on it's own...
> >...
>=20
> This is not related to the issues my patch addresses.

This is why I wrote that I basically like the overall concept of your
patch.

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
      ret =3D do_actions((curr | FREE_SPEECH) & ~(IRAQ_WAR_2 | DRM | TCPA));

--YZ2gLtJL3Gv805BH
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/WzdGHb1edYOZ4bsRAnAbAJ4h9ucUQDcZwbEONrBnJ491LXBkZACgisg0
ygHdqquey0mbKhoveEZn8D4=
=YiUs
-----END PGP SIGNATURE-----

--YZ2gLtJL3Gv805BH--
