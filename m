Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262418AbUCHHUg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 02:20:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262420AbUCHHUg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 02:20:36 -0500
Received: from mx1.actcom.co.il ([192.114.47.13]:33422 "EHLO
	smtp1.actcom.co.il") by vger.kernel.org with ESMTP id S262418AbUCHHUb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 02:20:31 -0500
Date: Mon, 8 Mar 2004 09:16:43 +0200
From: Muli Ben-Yehuda <mulix@mulix.org>
To: "YOSHIFUJI Hideaki / ?$B5HF#1QL@" <yoshfuji@linux-ipv6.org>
Cc: marcelo.tosatti@cyclades.com, bunk@fs.tum.de, degger@fhm.edu,
       linux-kernel@vger.kernel.org, jgarzik@pobox.com,
       linux-net@vger.kernel.org
Subject: Re: [2.4 patch] MAINTAINERS: remove LAN media entry
Message-ID: <20040308071642.GL877@mulix.org>
References: <20040307155008.GM22479@fs.tum.de> <Pine.LNX.4.44.0403080221520.2604-100000@dmt.cyclades> <20040308.150402.86498894.yoshfuji@linux-ipv6.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="l3ej7W/Jb2pB3qL2"
Content-Disposition: inline
In-Reply-To: <20040308.150402.86498894.yoshfuji@linux-ipv6.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--l3ej7W/Jb2pB3qL2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 08, 2004 at 03:04:02PM +0900, YOSHIFUJI Hideaki / ?$B5HF#1QL@ w=
rote:
> In article <Pine.LNX.4.44.0403080221520.2604-100000@dmt.cyclades> (at Mon=
, 8 Mar 2004 02:22:36 -0300 (BRT)), Marcelo Tosatti <marcelo.tosatti@cyclad=
es.com> says:

> > LANMEDIA WAN CARD DRIVER
> > S: UNMAINTAINED
> >=20
> > Thoughts?=20

Agreed. It's the easiest way to know that something is not
maintained.=20
=20
> "S" is one of the following (from MAINTAINERS):
>=20
>         Supported:      Someone is actually paid to look after this.

Then we should add 'unmaintained'... something like this:=20

--- linux-2.4/MAINTAINERS.orig	2004-03-08 09:15:19.000000000 +0200
+++ linux-2.4/MAINTAINERS	2004-03-08 09:15:29.000000000 +0200
@@ -69,6 +69,7 @@
 	Obsolete:	Old code. Something tagged obsolete generally means
 			it has been replaced by a better system and you
 			should be using that.
+        Unmaintained:	Nobody is taking care of it. Maybe you want to?
=20
 3C359 NETWORK DRIVER
 P:	Mike Phillips
@@ -1078,10 +1079,7 @@
 S:	Maintained
=20
 LANMEDIA WAN CARD DRIVER
-P:      Andrew Stanley-Jones
-M:      asj@lanmedia.com
-W:      http://www.lanmedia.com/
-S:      Supported
+S:      Unmaintained
 =20
 LAPB module
 P:	Henner Eisen

Cheers,=20
Muli=20
--=20
Muli Ben-Yehuda
http://www.mulix.org | http://mulix.livejournal.com/


--l3ej7W/Jb2pB3qL2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFATB3aKRs727/VN8sRAlyRAJsGIsBbm8PhzCL39BEAmVMDaz3CQwCfbA9X
ljek53LQglOWZwNZqhwV20A=
=71EO
-----END PGP SIGNATURE-----

--l3ej7W/Jb2pB3qL2--
