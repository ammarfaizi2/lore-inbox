Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932202AbWCTXTq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932202AbWCTXTq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 18:19:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932204AbWCTXTq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 18:19:46 -0500
Received: from smtp06.auna.com ([62.81.186.16]:1986 "EHLO smtp06.retemail.es")
	by vger.kernel.org with ESMTP id S932202AbWCTXTp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 18:19:45 -0500
Date: Tue, 21 Mar 2006 00:19:40 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fix console utf8 composing (F)
Message-ID: <20060321001940.098331ad@werewolf.auna.net>
In-Reply-To: <Pine.LNX.4.61.0603202048350.14231@yvahk01.tjqt.qr>
References: <Pine.LNX.4.61.0603202048350.14231@yvahk01.tjqt.qr>
X-Mailer: Sylpheed-Claws 2.0.0cvs158 (GTK+ 2.8.16; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_e_gr/bLxOIesVxu.DzDaICq";
 protocol="application/pgp-signature"; micalg=PGP-SHA1
X-Auth-Info: Auth:LOGIN IP:[83.138.210.119] Login:jamagallon@able.es Fecha:Tue, 21 Mar 2006 00:19:41 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_e_gr/bLxOIesVxu.DzDaICq
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 20 Mar 2006 20:54:08 +0100 (MET), Jan Engelhardt <jengelh@linux01.g=
wdg.de> wrote:

> Hello Alexander, Linus, LKML,
>=20
>=20
>=20
> can we have the patch[2] from this[1] thread merged? I have not yet heard=
 back
> from Alexander since [3]. Plus we're lacking a Signed-off-by so far for [=
2].
> What to do?
>=20
>=20
> [1] http://lkml.org/lkml/2005/12/25/2
> [2] http://www.linuxfromscratch.org/~alexander/patches/linux-2.6.14-utf8_=
input-1.patch
> [3] http://lkml.org/lkml/2006/1/30/50
>=20

+1

Whith this I can type accented chars in console.

Just a note. Is this also needed ?

http://marc.theaimsgroup.com/?l=3Dlinux-kernel&m=3D114104232611272&w=3D2

--
J.A. Magallon <jamagallon()able!es>     \               Software is like se=
x:
werewolf!able!es                         \         It's better when it's fr=
ee
Mandriva Linux release 2006.1 (Cooker) for i586
Linux 2.6.15-jam20 (gcc 4.0.3 (4.0.3-1mdk for Mandriva Linux release 2006.1=
))

--Sig_e_gr/bLxOIesVxu.DzDaICq
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFEHziMRlIHNEGnKMMRAuf4AKCtQVb5uhxACsk6QjNhSo8t5XXKqgCffj5+
SEnlcTAuNYEhIfRf3nqSl2Y=
=Wr1n
-----END PGP SIGNATURE-----

--Sig_e_gr/bLxOIesVxu.DzDaICq--
