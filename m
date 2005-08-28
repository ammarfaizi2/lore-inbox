Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750781AbVH1UM4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750781AbVH1UM4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Aug 2005 16:12:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750788AbVH1UM4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Aug 2005 16:12:56 -0400
Received: from mxfep01.bredband.com ([195.54.107.70]:11235 "EHLO
	mxfep01.bredband.com") by vger.kernel.org with ESMTP
	id S1750781AbVH1UM4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Aug 2005 16:12:56 -0400
Subject: Re: Possibly wrong contact for e100 driver
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: iSteve <isteve@rulez.cz>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <43120783.7040406@rulez.cz>
References: <43120783.7040406@rulez.cz>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-PDdaCOP+xRnwJMLf1hZG"
Date: Sun, 28 Aug 2005 22:12:49 +0200
Message-Id: <1125259969.4075.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-PDdaCOP+xRnwJMLf1hZG
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2005-08-28 at 20:50 +0200, iSteve wrote:
> Greetings,
> in past few days, I've been trying to obtain certian information about=20
> behavior of e100 NIC driver with my minipci card. My first hit was the=20
> contact information mentioned in the header of e100.c, that is, "Linux=20
> NICS <linux.nics@intel.com>".
>=20
> I've sent in my mail, praying for reply. The first reply was automated=20
> response, which suggested me eg. Win 3.11 install notes. After asking=20

I once sent a patch to linux.nics@intel.com for a use-after-free bug and
the reply I got was one that asked me which operating system I was
using. But to be fair I got one additional reply one day later that
suggested me to apply the latest patch from Jeff Garziks netdriver tree.

So I just sent the patch to the maintainers of the driver (at intel) and
netdev, they picked it up. So it's probably best to mail the maintainers
and cc netdev@vger.kernel.org , other people might be interested in this
information as well.
You'll find the maintainers listed in the MAINTAINERS file.

--=20
/Martin

--=-PDdaCOP+xRnwJMLf1hZG
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDEhrBWm2vlfa207ERAnZoAKCyFN27oxAAHp0fzx8Xa6ig5QyD5wCeJUQ1
I1W4FmCN8AwN5gfFGdjBPSg=
=SX8p
-----END PGP SIGNATURE-----

--=-PDdaCOP+xRnwJMLf1hZG--

