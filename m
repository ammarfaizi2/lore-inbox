Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269261AbUJFNRQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269261AbUJFNRQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 09:17:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269265AbUJFNRQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 09:17:16 -0400
Received: from mx1.redhat.com ([66.187.233.31]:8663 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S269261AbUJFNRI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 09:17:08 -0400
Subject: Re: 'C' calling convention change.
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0410060816430.3420@chaos.analogic.com>
References: <Pine.LNX.4.61.0410060816430.3420@chaos.analogic.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-lS/plov8SUURW5JCTmOP"
Organization: Red Hat UK
Message-Id: <1097068610.2812.19.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 06 Oct 2004 15:16:50 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-lS/plov8SUURW5JCTmOP
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2004-10-06 at 14:20, Richard B. Johnson wrote:
> The new Red Hat Fedora release uses the following gcc version:
>=20
>  	gcc (GCC) 3.3.3 20040412 (Red Hat Linux 3.3.3-7)
>=20
> I have many assembly-language routines that need to interface with
> 'C' code. The new 'C' compiler is doing something different than
> gcc 3.2, previously used.

I assume you're talking about userspace code here. Why are you bringing
that up on the kernel list?
The gcc list or even a fedora(-devel) list would be far more
appropriate.

--=-lS/plov8SUURW5JCTmOP
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBY/BCpv2rCoFn+CIRAqUPAJ0VBx7l8mLGuspSUFV4TJNdPfDXiwCePwPd
X8Ses+kNXl70Kg3dpgE4sNM=
=Fhgb
-----END PGP SIGNATURE-----

--=-lS/plov8SUURW5JCTmOP--

