Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262955AbTGZSRx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 14:17:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267186AbTGZSRw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 14:17:52 -0400
Received: from mx02.qsc.de ([213.148.130.14]:15249 "EHLO mx02.qsc.de")
	by vger.kernel.org with ESMTP id S262955AbTGZSRR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 14:17:17 -0400
Date: Sat, 26 Jul 2003 20:32:24 +0200
From: Wiktor Wodecki <wodecki@gmx.de>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Cc: Con Kolivas <kernel@kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>, akpm@osdl.org
Subject: Re: [PATCH] O9int for interactivity
Message-ID: <20030726183224.GA789@gmx.de>
References: <200307270306.47363.kernel@kolivas.org> <1059243458.575.1.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="T4sUOijqQbZv57TR"
Content-Disposition: inline
In-Reply-To: <1059243458.575.1.camel@teapot.felipe-alfaro.com>
X-message-flag: Linux - choice of the GNU generation
X-Operating-System: Linux 2.6.0-test1-mm2-O9 i686
X-PGP-KeyID: 182C9783
X-Info: X-PGP-KeyID, send an email with the subject 'public key request' to wodecki@gmx.de
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 26, 2003 at 08:17:38PM +0200, Felipe Alfaro Solana wrote:
> On Sat, 2003-07-26 at 19:06, Con Kolivas wrote:
>=20
> > Patch applies on top of 2.6.0-test1-mm2 + O8int. A patch against vanilla
> > 2.6.0-test1 is also available on my website.
>=20
> patch-test1-O9 contains some differences with respect to patch-O9 for
> the -mm kernels. In the patch-test1-O9, MAX_SLEEP_AVG and
> STARVATION_LIMIT are both set to (10*HZ), while in patch-O9-mm2 they are
> set to (HZ).
>=20
> Is this intentional?

probably yes, since vanilla runs on HZ=3D1000 and -mm on HZ=3D100

--=20
Regards,

Wiktor Wodecki

--T4sUOijqQbZv57TR
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/Isk46SNaNRgsl4MRAkSPAKCOV7KaJHibDHG7ptbqT8mfrFrE7QCdFQ7T
Mv68j4dDUkTq85lYqiVwhkg=
=4FsJ
-----END PGP SIGNATURE-----

--T4sUOijqQbZv57TR--
