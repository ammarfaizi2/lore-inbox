Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265219AbUFMRKN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265219AbUFMRKN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jun 2004 13:10:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265222AbUFMRKN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jun 2004 13:10:13 -0400
Received: from rrcs-se-24-123-177-110.biz.rr.com ([24.123.177.110]:11392 "EHLO
	nibbler") by vger.kernel.org with ESMTP id S265219AbUFMRKI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jun 2004 13:10:08 -0400
Subject: Re: Badness in local_bh_enable with eciadsl driver and kernel 2.6
From: areversat <areversat@tuxfamily.org>
Reply-To: areversat@tuxfamily.org
To: arjanv@redhat.com
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <1087146428.22276.0.camel@laptop.fenrus.com>
References: <1087145610.2266.1.camel@hosts>
	 <1087146428.22276.0.camel@laptop.fenrus.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-pNJs1A71jhJgw4QahOhi"
Message-Id: <1087146612.2266.5.camel@hosts>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 13 Jun 2004 19:10:12 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-pNJs1A71jhJgw4QahOhi
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

Oups yes sorry you can find it (i also forgot to say it's a usermode
driver) at http://eciadsl.flashtux.org

Le dim 13/06/2004 =E0 19:07, Arjan van de Ven a =E9crit :
> On Sun, 2004-06-13 at 18:53, areversat wrote:
> > Hi,
> > here is what most users get when running our driver (usb adsl modem
> > driver) with kernel 2.6.x. I'd like to know if it is a kernel bug or if
> > it has something to do with our driver.
>=20
> I think you forgot to attach your driver (or an URL for it)....
--=20
Pour trouver les limites du possible il faut tenter l'impossible.

--=-pNJs1A71jhJgw4QahOhi
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Ceci est une partie de message
	=?ISO-8859-1?Q?num=E9riquement?= =?ISO-8859-1?Q?_sign=E9e=2E?=

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAzIpzuGdEvqsgTTURAps0AKCGj60rsCbBCCq36Io6Qes7AEHvpgCfdIQC
BIxQthQ+L1ATVEkTVzBubWE=
=Kmmr
-----END PGP SIGNATURE-----

--=-pNJs1A71jhJgw4QahOhi--
