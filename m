Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281506AbRKMLOC>; Tue, 13 Nov 2001 06:14:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281511AbRKMLNo>; Tue, 13 Nov 2001 06:13:44 -0500
Received: from [206.46.170.189] ([206.46.170.189]:27836 "EHLO
	smtp010pub.verizon.net") by vger.kernel.org with ESMTP
	id <S281506AbRKMLNf>; Tue, 13 Nov 2001 06:13:35 -0500
Message-Id: <200111131114.fADBEC805094@smtp010pub.verizon.net>
Date: Tue, 13 Nov 2001 06:19:23 -0500
From: Skip Ford <skip.ford@verizon.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Changed message for GPLONLY symbols
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <10444.1005619809@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="opJtzjQTFsWo+cga"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <10444.1005619809@kao2.melbourne.sgi.com>; from kaos@ocs.com.au on Tue, Nov 13, 2001 at 01:50:09PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Keith Owens wrote:
> When insmod detects a non-GPL module with unresolved symbols it
> currently says:
>=20
> Note: modules without a GPL compatible license cannot use GPLONLY_ symbols
>=20
> I thought that hint was self-explanatory, obviously it was not clear.
> Never underestimate the ability of lusers to misread a message.  insmod
> 2.4.12 will say
>=20
> Hint: You are trying to load a module without a GPL compatible license
>       and it has unresolved symbols.  The module may be trying to access
>       GPLONLY symbols but the problem is more likely to be a coding or
>       user error.  Contact the module supplier for assistance.
>=20
> Does anyone think that this message can be misunderstood by anybody
> with the "intelligence" of the normal Windoze user?

How about 'Error: unresolved symbols (incorrect module/kernel version?)'

It's pointless to state the license type if all symbols can't be resolved.

--=20
Skip  ID: 0x7EDDDB0A

--opJtzjQTFsWo+cga
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----

iEYEARECAAYFAjvxAbkACgkQBMKxVH7d2wq79gCbBH085vBLVoy9JfouVrQpGYSb
J8UAoOfsFVyV+Wsbu4FR1mESEMJJN+G+
=zfv0
-----END PGP SIGNATURE-----

--opJtzjQTFsWo+cga--
