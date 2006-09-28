Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161363AbWI2AG6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161363AbWI2AG6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 20:06:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161412AbWI2AG6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 20:06:58 -0400
Received: from ozlabs.org ([203.10.76.45]:5266 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1161363AbWI2AG5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 20:06:57 -0400
Subject: Re: [RFC/PATCH 7/7] Preliminary MPIC MSI backend
From: Michael Ellerman <michael@ellerman.id.au>
Reply-To: michael@ellerman.id.au
To: linux-kernel@vger.kernel.org
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, linuxppc-dev@ozlabs.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Jake Moilanen <moilanen@austin.ibm.com>
In-Reply-To: <20060928215349.45C0667C47@ozlabs.org>
References: <20060928215349.45C0667C47@ozlabs.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-zN0IEaP9Pia3hDl6kWKc"
Date: Fri, 29 Sep 2006 09:37:41 +1000
Message-Id: <1159486661.25820.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-zN0IEaP9Pia3hDl6kWKc
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2006-09-29 at 07:53 +1000, Michael Ellerman wrote:
> A pretty hackish MPIC backend, just enough to flesh out the design.
> Based on code from Segher.
>=20
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>

Missing a quilt ref, new one coming RSN.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-zN0IEaP9Pia3hDl6kWKc
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBFHFzFdSjSd0sB4dIRAltiAKCg4iQh2gLc18fHgImsjjqTYsYPfQCcD4cK
eGhleY1TWWUOf30IuVwlzDs=
=ouha
-----END PGP SIGNATURE-----

--=-zN0IEaP9Pia3hDl6kWKc--

