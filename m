Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262731AbTLDQpB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 11:45:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262740AbTLDQpB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 11:45:01 -0500
Received: from [68.114.43.143] ([68.114.43.143]:60114 "EHLO wally.rdlg.net")
	by vger.kernel.org with ESMTP id S262731AbTLDQo6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 11:44:58 -0500
Date: Thu, 4 Dec 2003 11:44:56 -0500
From: "Robert L. Harris" <Robert.L.Harris@rdlg.net>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Where'd the .config go?
Message-ID: <20031204164455.GD16568@rdlg.net>
Mail-Followup-To: "Randy.Dunlap" <rddunlap@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20031204151852.GB16568@rdlg.net> <20031204083331.7660077a.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Ycz6tD7Th1CMF4v7"
Content-Disposition: inline
In-Reply-To: <20031204083331.7660077a.rddunlap@osdl.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Ycz6tD7Th1CMF4v7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable



Odd, it's in my 2.4.21-ac3 tree.  Guess it was in the ac for a short
durration.

Thus spake Randy.Dunlap (rddunlap@osdl.org):

> On Thu, 4 Dec 2003 10:18:52 -0500 "Robert L. Harris" <Robert.L.Harris@rdl=
g.net> wrote:
>=20
> |=20
> |=20
> | Just compiled 2.4.23-bk3 and noticed that the option to save the .config
> | somewhere in the kernel is missing.  Mistake somewhere or has this been
> | removed?
>=20
> It's never been merged in 2.4.x.  Marcelo didn't want it.
> It's in 2.6.x.
> There's a 2.4.22-pre patch in this dir that you can try:
>   http://www.xenotime.net/linux/ikconfig/
>=20
>=20
> --
> ~Randy
> MOTD:  Always include version info.

:wq!
---------------------------------------------------------------------------
Robert L. Harris                     | GPG Key ID: E344DA3B
                                         @ x-hkp://pgp.mit.edu
DISCLAIMER:
      These are MY OPINIONS ALONE.  I speak for no-one else.

Life is not a destination, it's a journey.
  Microsoft produces 15 car pileups on the highway.
    Don't stop traffic to stand and gawk at the tragedy.

--Ycz6tD7Th1CMF4v7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/z2SH8+1vMONE2jsRAuOJAJ98Har7viazwCaI/YZbLLa1J650RACeJMA6
TfiijRaZ+9mB9Hr53xyFZkU=
=pyJK
-----END PGP SIGNATURE-----

--Ycz6tD7Th1CMF4v7--
