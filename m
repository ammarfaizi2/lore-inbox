Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264261AbUEXOvy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264261AbUEXOvy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 10:51:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264274AbUEXOvy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 10:51:54 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:39102 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S264261AbUEXOvw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 10:51:52 -0400
Date: Mon, 24 May 2004 16:51:50 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6: future of UMSDOS?
Message-ID: <20040524145150.GQ1912@lug-owl.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20040519184321.GB24287@fs.tum.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="j6NQunVinLIRleuJ"
Content-Disposition: inline
In-Reply-To: <20040519184321.GB24287@fs.tum.de>
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--j6NQunVinLIRleuJ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 2004-05-19 20:43:21 +0200, Adrian Bunk <bunk@fs.tum.de>
wrote in message <20040519184321.GB24287@fs.tum.de>:
> Looking at the state of the UMSDOS code in 2.6 I'm currently wondering=20
> about it's future.
>=20
> Are there still potential users and people willing to work on getting it
> working, or should it be removed from kernel 2.6?

In my early Linux days, UMSDOS was quite a neat thing to have for
showing Linux to friends by placing a .zip'ed Linux installation on
their MS-DOS machines.

So for historic reasons, I think it would be nice to have UMSDOS around.

However, one can achieve the same (with a lot more work) by placing a
loop-mountable ext2 FS and start it from an initrd. Much more
complicated, not that flexible (loop-mounted files don't typically
grow:)

So, it's quite nice to have it (had), but there's no strong need to keep
it IMO.

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
   ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TC=
PA));

--j6NQunVinLIRleuJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAsgwGHb1edYOZ4bsRAozBAJ4/lm54pn4a1/CzzMNFBJrnqiHFyQCfTlTU
M9a9+O3PiTwl/V9VkaGv+e0=
=Kt/2
-----END PGP SIGNATURE-----

--j6NQunVinLIRleuJ--
