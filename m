Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266596AbUFRTsb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266596AbUFRTsb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 15:48:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265263AbUFRTpg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 15:45:36 -0400
Received: from websrv.werbeagentur-aufwind.de ([213.239.197.241]:13969 "EHLO
	websrv.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S266712AbUFRTWS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 15:22:18 -0400
Subject: Re: 2.6.7 Samba OOPS (in smb_readdir)
From: Christophe Saout <christophe@saout.de>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Brice Goglin <Brice.Goglin@ens-lyon.fr>, linux-kernel@vger.kernel.org
In-Reply-To: <1087585251.13235.3.camel@leto.cs.pocnet.net>
References: <Pine.LNX.4.58.0406152253390.6392@ppc970.osdl.org>
	 <20040618163759.GN1146@ens-lyon.fr> <20040618164125.GO1146@ens-lyon.fr>
	 <Pine.LNX.4.58.0406181309440.2228@montezuma.fsmlabs.com>
	 <1087585251.13235.3.camel@leto.cs.pocnet.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-PLTZJ5tZUIcpn9QchnxC"
Date: Fri, 18 Jun 2004 21:22:12 +0200
Message-Id: <1087586532.9085.1.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.9.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-PLTZJ5tZUIcpn9QchnxC
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Am Fr, den 18.06.2004 um 21:00 Uhr +0200 schrieb Christophe Saout:

> > 	It's a known issue currently being tracked with the bugzilla entry
> > at http://bugzilla.kernel.org/show_bug.cgi?id=3D1671
>=20
> Hey, nice.
>=20
> I've got a nearly 100% reproducability of the problem here (FAM +
> nautilus + hal.hotplug or something like that, I'm always getting this
> Oops in nautilus trying to do something with its trash folder when I'm
> mounting a remote volume). I'll try this patch and tell you if it's
> working (for me).

Well, it's not. :(

The oops is gone but the processes are still hanging. I'm posting the
SysRq-T trace on bugzilla. Hope it helps. If you need some help
debugging the problem, please tell me if I can do something.


--=-PLTZJ5tZUIcpn9QchnxC
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBA00DjZCYBcts5dM0RAumSAJ47wAIvFkVXIRqGJywSjIwP7+tipgCdFlKH
+CX4u5r0DppULwYE0ph5IDs=
=iBaP
-----END PGP SIGNATURE-----

--=-PLTZJ5tZUIcpn9QchnxC--

