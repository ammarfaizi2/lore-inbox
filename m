Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265269AbUFHSFn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265269AbUFHSFn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 14:05:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265278AbUFHSFm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 14:05:42 -0400
Received: from [196.25.168.8] ([196.25.168.8]:65174 "EHLO lbsd.net")
	by vger.kernel.org with ESMTP id S265277AbUFHSFc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 14:05:32 -0400
Date: Tue, 8 Jun 2004 20:05:09 +0200
From: Nigel Kukard <nkukard@lbsd.net>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SMBFS crash
Message-ID: <20040608180508.GI14247@lbsd.net>
References: <20040608123656.GG14247@lbsd.net> <Pine.LNX.4.58.0406081259570.1838@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8MD1ZCO3r6aZNHwn"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0406081259570.1838@montezuma.fsmlabs.com>
User-Agent: Mutt/1.4.1i
X-PHP-Key: http://www.lbsd.net/~nkukard/keys/gpg_public.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--8MD1ZCO3r6aZNHwn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Thanks man, will test it out

-Nigel

On Tue, Jun 08, 2004 at 01:06:23PM -0400, Zwane Mwaikambo wrote:
> On Tue, 8 Jun 2004, Nigel Kukard wrote:
>=20
> > I get the following error trying to access a mounted smb filesystem.
> > 100% reproducable on my sytem.
> >
> > Please let me know if you require anymore info.
>=20
> A known issue, there is also a bugzilla entry at the following URL with a
> temporary fix (needs a bit of work to satisfy the maintainer, which i'll
> get round to one of these evenings).
>=20
> http://bugme.osdl.org/show_bug.cgi?id=3D1671
>=20
> Feel free to add yourself to the Cc list.

--8MD1ZCO3r6aZNHwn
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFAxf/UKoUGSidwLE4RAnwBAJ9k5MYrel6Eq49br3e0mSuM7qRGggCcDFzL
XXruAnDNc55n5ImreT8KhOc=
=p4DI
-----END PGP SIGNATURE-----

--8MD1ZCO3r6aZNHwn--
