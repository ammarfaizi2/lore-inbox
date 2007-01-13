Return-Path: <linux-kernel-owner+w=401wt.eu-S1422788AbXAMWoQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422788AbXAMWoQ (ORCPT <rfc822;w@1wt.eu>);
	Sat, 13 Jan 2007 17:44:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030521AbXAMWoQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Jan 2007 17:44:16 -0500
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:40554 "EHLO
	smtp.drzeus.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030193AbXAMWoP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Jan 2007 17:44:15 -0500
X-Greylist: delayed 365 seconds by postgrey-1.27 at vger.kernel.org; Sat, 13 Jan 2007 17:44:15 EST
Message-ID: <45A95F54.3040601@drzeus.cx>
Date: Sat, 13 Jan 2007 23:38:12 +0100
From: Pierre Ossman <drzeus@drzeus.cx>
User-Agent: Thunderbird 1.5.0.9 (X11/20061223)
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=_hera.drzeus.cx-17697-1168727881-0001-2"
To: Adrian Bunk <bunk@stusta.de>
CC: Andrew Morton <akpm@osdl.org>,
       Anderson Briglia <anderson.briglia@indt.org.br>,
       linux-kernel@vger.kernel.org
Subject: Re: [-mm patch] make mmc_sysfs.c:mmc_key_type static
References: <20070111222627.66bb75ab.akpm@osdl.org> <20070113095628.GJ7469@stusta.de>
In-Reply-To: <20070113095628.GJ7469@stusta.de>
X-Enigmail-Version: 0.94.0.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_hera.drzeus.cx-17697-1168727881-0001-2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Adrian Bunk wrote:
> On Thu, Jan 11, 2007 at 10:26:27PM -0800, Andrew Morton wrote:
>> ...
>> Changes since 2.6.20-rc3-mm1:
>> ...
>>  git-mmc.patch
>> ...
>>  git trees
>> ...
>=20
>=20
> This patch makes the needlessly global struct mmc_key_type static.
>=20
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
>=20

Thanks, applied.

Rgds
Pierre



--=_hera.drzeus.cx-17697-1168727881-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFFqV9X7b8eESbyJLgRApISAJ4gnMfbRq4CMccrLa+IKPIQyIWomACfTc47
w38ijyL6U8q1XDKRBOMAmWo=
=fPWa
-----END PGP SIGNATURE-----

--=_hera.drzeus.cx-17697-1168727881-0001-2--
