Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751177AbVJOPlF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751177AbVJOPlF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Oct 2005 11:41:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751178AbVJOPlF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Oct 2005 11:41:05 -0400
Received: from wg.technophil.ch ([213.189.149.230]:32230 "HELO
	hydrogenium.schottelius.org") by vger.kernel.org with SMTP
	id S1751177AbVJOPlC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Oct 2005 11:41:02 -0400
Date: Sat, 15 Oct 2005 17:40:48 +0200
From: Nico Schottelius <nico-kernel@schottelius.org>
To: Christian Kujau <evil@g-house.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
       Nico Schottelius <nico-kernel@schottelius.org>,
       Daniel Aubry <kernel-obri@chaostreff.ch>
Subject: Re: Some problems with 2.6.13.4
Message-ID: <20051015154048.GK8609@schottelius.org>
Mail-Followup-To: Nico Schottelius <nico-kernel@schottelius.org>,
	Christian Kujau <evil@g-house.de>,
	LKML <linux-kernel@vger.kernel.org>,
	Daniel Aubry <kernel-obri@chaostreff.ch>
References: <20051015122131.GG8609@schottelius.org> <43511AB1.3010608@g-house.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4wkndigzIeYF6Hbg"
Content-Disposition: inline
In-Reply-To: <43511AB1.3010608@g-house.de>
User-Agent: echo $message | gpg -e $sender  -s | netcat mailhost 25
X-Linux-Info: http://linux.schottelius.org/
X-Operating-System: Linux 2.6.13.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--4wkndigzIeYF6Hbg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Christian Kujau [Sat, Oct 15, 2005 at 05:05:21PM +0200]:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: RIPEMD160
>=20
> Nico Schottelius schrieb:
> > The kernel configurations are used from the versions before, with runni=
ng
> > make oldconfig before.
>=20
> so, these machines were running fine with 2.6.13.3 or .2 and stopped
> working with 2.6.13.4? if yes, then perhaps you can narrow it down to one
> of the changes in patch-2.6.13.3-4.gz or patch-2.6.13.2-3.gz
>=20
> (from http://www.kernel.org/pub/linux/kernel/v2.6/incr/)

Sorry, I sent the message before inserting this info:

- ibm tp runs with 2.6.12.5
- dell latitude runs with 2.6.10

I personally have access to the ibm tp and I'll test 2.6.13.3 in some hours
(which it nees to compile it).

I'll report more info than. Perhaps Daniel Aubry can test on his dell, too.

Nico

--=20
Latest project: cconfig (http://nico.schotteli.us/papers/linux/cconfig/)
Open Source nutures open minds and free, creative developers.

--4wkndigzIeYF6Hbg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iQIVAwUBQ1Ei/7OTBMvCUbrlAQKABA//V3D/TtU8VNEr5o0jl5Qg57XvXU/k0d8W
xtvm7NybH9CSPEEJpUmO5fOZxTjz9w09nvzFEDvmabAH6S3LivSg2pncaAFdxs45
IBmTGSWI/qEsaHV3zDK0xfEQF3GMZGdCXI56uvRdxp8mKahvBBivnTvsPvyNrg8z
kpiOHY+V4u5IDhTj2XEn3wjUvSGjhIpf1OaC/KSOkOH5CAVR8QbJiV8to/dBTrYw
vdYQwp5KcCO0JCxz+jFVZqfQ2jHIfwGr4ocCE5Mv/FzC0KsVHdXfe2Z3rM+Ijw4Q
aWUkm18fIQxuHQFu4tMM48lOFJ6/m5hEceuHJQEjCgWNKRbuPn+Z/DWkI9v8tN7M
oAdFlOS2KHdtDGrawJe2Sx02NkFwNsuaC+f7tKgVmh/EfXJWclRQeZQ+hBWr1Na6
xbb+PSr7DUsb6M8FIHDWmyt+wRhwcK8dwVg6jlTJWlMMZG7h6WD+7Eq//c5fql/V
G4F7uy4g6wDH1hAjw5vWjjYzacUNKMD9ycPanR95Mu0oNafqSapKroC+L05WfSfK
qwB4sdxmt8Pz1/bV5hdi09TEEeIW8JHyWHaFLGwJSpKwED62TtoiPZLdyJ47lIZQ
Cr+QkTD/n2Q3S8HXhFwq2Z6At66dy9XI8cRK5erlIqyXy7GUjd4TTDQNUv5Yuf6M
QsQTAeQvuBM=
=t3CT
-----END PGP SIGNATURE-----

--4wkndigzIeYF6Hbg--
