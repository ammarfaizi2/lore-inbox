Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265920AbUGEELa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265920AbUGEELa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jul 2004 00:11:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265922AbUGEELa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jul 2004 00:11:30 -0400
Received: from wblv-239-160.telkomadsl.co.za ([165.165.239.160]:56961 "EHLO
	gateway.lan") by vger.kernel.org with ESMTP id S265920AbUGEEL1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jul 2004 00:11:27 -0400
Subject: Re: [2.4] lockup on boot with 2.4.26
From: Martin Schlemmer <azarah@nosferatu.za.org>
Reply-To: Martin Schlemmer <azarah@nosferatu.za.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
In-Reply-To: <20040705002845.GB20847@logos.cnet>
References: <1088979352.9568.9.camel@nosferatu.lan>
	 <20040705002845.GB20847@logos.cnet>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-RZwElCCRu0VmbwfkmvN4"
Message-Id: <1089000649.9568.15.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 05 Jul 2004 06:10:50 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-RZwElCCRu0VmbwfkmvN4
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2004-07-05 at 02:28, Marcelo Tosatti wrote:
> On Mon, Jul 05, 2004 at 12:15:52AM +0200, Martin Schlemmer wrote:
> > Hi
> >=20
> > I have tried to update my gateway's kernel to 2.4.26 (Been running
> > happily on 2.4.17, but a bit _old_, so finally decided this weekend
> > to try and update it).   At boot though it only gets to:
> >=20
> > --
> > Uncompressing kernel... booting linux...
> > --
> >=20
> > and then locks hard (the capslock and scroll lock leds lids)
> >=20
> > Its an old P3 450 on an Asus P2B (BX440 chipset).  .config is pretty
> > much the same as for the 2.4.17 kernel.
> >=20
> > I did have grsecurity initially applied, but I tried on an vanilla
> > kernel as well (besides some netfiler POM patches, but they are all
> > modules).  I also tried to disable acpi.
> >=20
> > Any suggestions would be appreciated.  .config attached.
>=20
> Hi Martin,=20
>=20
> I do not know the answer for your problem but I'll try to help.
>=20
> Can you do a binary search and find out which v2.4 kernel stops working?=20
>=20
> You can start with 2.4.21, see if that works, if so, try 2.4.23, etc?=20

Sure, will do and let you know, thanks.


--=20
Martin Schlemmer

--=-RZwElCCRu0VmbwfkmvN4
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBA6NTJqburzKaJYLYRAm9cAJ9eDKq/qz6OClqJDa6A7+fnrZn5uACfVecg
V9uVVQTeHc8CxA7SlaVSVno=
=iIuK
-----END PGP SIGNATURE-----

--=-RZwElCCRu0VmbwfkmvN4--

