Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266521AbUFRTIi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266521AbUFRTIi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 15:08:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266479AbUFRTEY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 15:04:24 -0400
Received: from websrv.werbeagentur-aufwind.de ([213.239.197.241]:34703 "EHLO
	websrv.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S266521AbUFRTA5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 15:00:57 -0400
Subject: Re: 2.6.7 Samba OOPS (in smb_readdir)
From: Christophe Saout <christophe@saout.de>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Brice Goglin <Brice.Goglin@ens-lyon.fr>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0406181309440.2228@montezuma.fsmlabs.com>
References: <Pine.LNX.4.58.0406152253390.6392@ppc970.osdl.org>
	 <20040618163759.GN1146@ens-lyon.fr> <20040618164125.GO1146@ens-lyon.fr>
	 <Pine.LNX.4.58.0406181309440.2228@montezuma.fsmlabs.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-szfHXPZsCXHIYF0Eq++n"
Date: Fri, 18 Jun 2004 21:00:50 +0200
Message-Id: <1087585251.13235.3.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.9.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-szfHXPZsCXHIYF0Eq++n
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Am Fr, den 18.06.2004 um 13:11 Uhr -0400 schrieb Zwane Mwaikambo:

> 	It's a known issue currently being tracked with the bugzilla entry
> at http://bugzilla.kernel.org/show_bug.cgi?id=3D1671

Hey, nice.

I've got a nearly 100% reproducability of the problem here (FAM +
nautilus + hal.hotplug or something like that, I'm always getting this
Oops in nautilus trying to do something with its trash folder when I'm
mounting a remote volume). I'll try this patch and tell you if it's
working (for me).


--=-szfHXPZsCXHIYF0Eq++n
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBA0zviZCYBcts5dM0RAgTgAKCUUQrHvcF29eD5zI9V3Mc+Q/b34wCgmnkU
6DqEXPliauIV315g+CwHJag=
=y7He
-----END PGP SIGNATURE-----

--=-szfHXPZsCXHIYF0Eq++n--

