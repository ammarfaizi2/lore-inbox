Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932251AbVISMV7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932251AbVISMV7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 08:21:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932263AbVISMV7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 08:21:59 -0400
Received: from mx1.redhat.com ([66.187.233.31]:40420 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932251AbVISMV6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 08:21:58 -0400
Subject: Re: [TG3]: Add AMD K8 to list of write-reorder chipsets.
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200509182159.j8ILxdDB030369@hera.kernel.org>
References: <200509182159.j8ILxdDB030369@hera.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-fmekH7vO3pPLwmzITAkz"
Organization: Red Hat, Inc.
Date: Mon, 19 Sep 2005 08:21:58 -0400
Message-Id: <1127132518.3019.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-fmekH7vO3pPLwmzITAkz
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2005-09-18 at 14:59 -0700, Linux Kernel Mailing List wrote:
> tree 1da3df4563187bae7eec7834d1fada04f8a9271b
> parent 67e6b629212fa9ffb7420e8a88a41806af637e28
> author David S. Miller <davem@davemloft.net> Sat, 17 Sep 2005 06:59:20 -0=
700
> committer David S. Miller <davem@davemloft.net> Sat, 17 Sep 2005 06:59:20=
 -0700
>=20
> [TG3]: Add AMD K8 to list of write-reorder chipsets.
>=20
> Thanks to Andy Stewart for the report and testing
> debug patches from Michael Chan.


shouldn't something like this move to generic code?
(and in this case, probably as quirk that disables the chipset
"feature" ?)


--=-fmekH7vO3pPLwmzITAkz
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDLq1mpv2rCoFn+CIRAnglAJ97f4Hw8k/CyRpCas66x76sMtIyOwCeP2hm
tW7pycRfNeQYfbl2KIIAn4M=
=K+Lo
-----END PGP SIGNATURE-----

--=-fmekH7vO3pPLwmzITAkz--

