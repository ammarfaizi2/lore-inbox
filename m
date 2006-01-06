Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751586AbWAFXZb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751586AbWAFXZb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 18:25:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932646AbWAFXZb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 18:25:31 -0500
Received: from mail.gmx.de ([213.165.64.21]:13509 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751586AbWAFXZa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 18:25:30 -0500
X-Authenticated: #24128601
Date: Sat, 7 Jan 2006 00:25:48 +0100
From: Sebastian <sebastian_ml@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Digital Audio Extraction with ATAPI drives far from perfect
Message-ID: <20060106232522.GA31621@section_eight.mops.rwth-aachen.de>
References: <20060103222044.GA17682@section_eight.mops.rwth-aachen.de> <43BE24F7.6070901@triplehelix.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7iMSBzlTiPOCCT2k"
Content-Disposition: inline
In-Reply-To: <43BE24F7.6070901@triplehelix.org>
X-PGP-Key: http://www-users.rwth-aachen.de/sebastian.kemper/sebastian_ml_pubkey.asc
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--7iMSBzlTiPOCCT2k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all!
On Fri, Jan 06, 2006 at 12:06:15AM -0800, Joshua Kwan wrote:
> Hi Sebastian,
>=20
> On 01/03/2006 02:20 PM, Sebastian wrote:
> > The second series was ripped with deprecated ide-scsi emulation and yie=
lded the
> > same results as EAC.
>=20
> What were you using? cdparanoia? cdda2wav? (Are there actually that many
> other options on Linux?)
I use cdparanoia.
>=20
> This may well be a userspace problem, where your ripping program doesn't
> perform enough integrity checks on the data it's just read, and ide-scsi
> happens to make things slow enough for errors to not occur?
>=20
I reripped the disc with ide-cd but now with read speed reduced to 2x.
Exactly the same md5sums as with ide-cd at full velocity.
> Shooting in the dark,
>=20
> --=20
> Joshua Kwan

Sebastian

--=20
"When the going gets weird, the weird turn pro." (HST)

--7iMSBzlTiPOCCT2k
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDvvx8TWouIrjrWo4RArs7AJ9cZwKduoF7eK1lUoHff8iHO6o+jQCeOD6L
DRg9E7LbC+5SyFprKsI+/34=
=5NGM
-----END PGP SIGNATURE-----

--7iMSBzlTiPOCCT2k--

