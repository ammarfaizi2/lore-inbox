Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264231AbTCXOKZ>; Mon, 24 Mar 2003 09:10:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264232AbTCXOKZ>; Mon, 24 Mar 2003 09:10:25 -0500
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:29425 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP
	id <S264231AbTCXOKW>; Mon, 24 Mar 2003 09:10:22 -0500
Subject: Re: Ded-Fat 8.0 and ext3
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: root@chaos.analogic.com
Cc: Dumitru Ciobarcianu <Dumitru.Ciobarcianu@iNES.RO>,
       Linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.53.0303240909410.24249@chaos>
References: <Pine.LNX.4.53.0303211420170.13876@chaos>
	 <1048324118.3306.3.camel@LNX.iNES.RO>
	 <Pine.LNX.4.53.0303240909410.24249@chaos>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-ilpaJgqO6gXyFh4l5qO9"
Organization: Red Hat, Inc.
Message-Id: <1048515655.1636.4.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 24 Mar 2003 15:20:55 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ilpaJgqO6gXyFh4l5qO9
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2003-03-24 at 15:11, Richard B. Johnson wrote:

> I did not bother to go any further than `make oldconfig` and
> `make dep` in this "Show-and-tell". As previously reported,

as previously report to YOU: you have to do a make mrproper first.
Then it just works.

I've not received a SINGLE report where starting with make mrproper
didn't fix this issue. You can claim I ignore this issue, but I don't.
It's just not an issue at all so far!

--=-ilpaJgqO6gXyFh4l5qO9
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+fxRHxULwo51rQBIRAqWBAJ9+vRbDd7ajqIRdPiVN2yIobZq3VQCbB7kx
VrOmUFRZb8C1dCIrWPz5Q/4=
=SUOK
-----END PGP SIGNATURE-----

--=-ilpaJgqO6gXyFh4l5qO9--
