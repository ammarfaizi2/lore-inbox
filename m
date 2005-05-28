Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262697AbVE1LIQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262697AbVE1LIQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 May 2005 07:08:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262698AbVE1LIQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 May 2005 07:08:16 -0400
Received: from smtp2.poczta.interia.pl ([213.25.80.232]:27036 "EHLO
	smtp.poczta.interia.pl") by vger.kernel.org with ESMTP
	id S262697AbVE1LIK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 May 2005 07:08:10 -0400
Message-ID: <4298510E.8030502@poczta.fm>
Date: Sat, 28 May 2005 13:07:58 +0200
From: Lukasz Stelmach <stlman@poczta.fm>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: pl, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Driver for MCS7780 USB-IrDA bridge chip
References: <42943CB5.50400@poczta.fm> <20050525235846.GA28644@kroah.com>
In-Reply-To: <20050525235846.GA28644@kroah.com>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigBA8A72E44CCAE38C51F78DA4"
X-EMID: a14a4138
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigBA8A72E44CCAE38C51F78DA4
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Greg KH napisa=C5=82(a):
> On Wed, May 25, 2005 at 10:52:05AM +0200, Lukasz Stelmach wrote:
>=20
>>You can download it from either:
>>http://www.ee.pw.edu.pl/~stelmacl/mcs7780-0.1alpha.1.tar.bz2
[...]
> Nice, care to make up a patch as per the Documentation/SubmittingPatche=
s
> file and send it to the linux-usb-devel mailing list so people can
> review it?

I surely will make a patch but let me at least implement the speed
changing. For without it the driver is just like a lawnmower instead of
 beeing for example a scooter ;-)

--=20
By=C5=82o mi bardzo mi=C5=82o.                    Trzecia pospolita kl=C4=
=99ska, [...]
>=C5=81ukasz<                      Ju=C5=BC nie katolicka lecz z=C5=82odz=
iejska.  (c)PP


--------------enigBA8A72E44CCAE38C51F78DA4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCmFETNdzY8sm9K9wRAstNAJ90F6PQlsP5HiRcDbogky44bgucjACcDkPK
EpY/zxyt1OTDTAK9SCGH8v4=
=BZRa
-----END PGP SIGNATURE-----

--------------enigBA8A72E44CCAE38C51F78DA4--
