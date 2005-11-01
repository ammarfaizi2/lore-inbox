Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751148AbVKATM5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751148AbVKATM5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 14:12:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751140AbVKATM5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 14:12:57 -0500
Received: from mout0.freenet.de ([194.97.50.131]:7623 "EHLO mout0.freenet.de")
	by vger.kernel.org with ESMTP id S1751148AbVKATM4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 14:12:56 -0500
From: Michael Buesch <mbuesch@freenet.de>
To: "Jeff V. Merkey" <jmerkey@utah-nac.org>
Subject: Re: Would I be violating the GPL?
Date: Tue, 1 Nov 2005 20:12:32 +0100
User-Agent: KMail/1.8
References: <5449aac20511010949x5d96c7e0meee4d76a67a06c01@mail.gmail.com> <200511012000.21176.mbuesch@freenet.de> <4367A990.2040301@utah-nac.org>
In-Reply-To: <4367A990.2040301@utah-nac.org>
Cc: alex@alexfisher.me.uk, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1666839.jg0po5jVg0";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200511012012.32995.mbuesch@freenet.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1666839.jg0po5jVg0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tuesday 01 November 2005 18:44, you wrote:
> No, don't take the code without the suppliers permission.=20

I interpreted his text as if he already has permission to use the code.

> It contains =20
> trade secrets and you can get into a ot of trouble if there's an=20
> agreement between the two of you.  Contact the supplier.  Tell them to=20
> abstract away thre kernel headers, or rewrite to remove them, or grant=20
> you persmission to open source the driver.

I did not say he should open source the driver. That will give trouble.
I suggested to write a _device_ specification. Driver specific things do not
care.

> The UK is the land of =20
> frivilous lawsuits (I should know a lot about this :-)  ), so don;t=20
> expose yourself and breach any agreements.=20

Sure.

> Jeff
>=20
>=20
> Michael Buesch wrote:
>=20
> >On Tuesday 01 November 2005 18:49, Alexander Fisher wrote:
> > =20
> >
> >>Hello.
> >>
> >>A supplier of a PCI mezzanine digital IO card has provided a linux 2.4
> >>driver as source code.  They have provided this code source with a
> >>license stating I won't redistribute it in anyway.
> >>My concern is that if I build this code into a module, I won't be able
> >>to distribute it to customers without violating either the GPL (by not
> >>distributing the source code), or the proprietary source code license
> >>as currently imposed by the supplier.
> >>From what I have read, this concern is only valid if the binary module
> >>is considered to be a 'derived work' of the kernel.  The module source
> >>directly includes the following kernel headers :
> >>   =20
> >>
> >
> >Take the code and write a specification for the device.
> >Should be fairly easy.
> >Someone else will pick up the spec and write a clean GPLed driver.
> >
> >Like these, without the reverse engineering part:
> >http://en.wikipedia.org/wiki/Clean_room_design
> >http://en.wikipedia.org/wiki/Chinese_wall#Computer_science
> >
> > =20
> >
>=20
>=20
>=20

=2D-=20
Greetings Michael.

--nextPart1666839.jg0po5jVg0
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBDZ74glb09HEdWDKgRAvyJAJwI1Fbigfe9xJVGzY1O09mVN9YHFgCfbNXA
hbVw3Q53DPfFSWvMm//LHLg=
=bt26
-----END PGP SIGNATURE-----

--nextPart1666839.jg0po5jVg0--
