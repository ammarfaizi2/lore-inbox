Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266656AbUBLXPS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 18:15:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266660AbUBLXPS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 18:15:18 -0500
Received: from legolas.restena.lu ([158.64.1.34]:43995 "EHLO smtp.restena.lu")
	by vger.kernel.org with ESMTP id S266656AbUBLXPK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 18:15:10 -0500
Subject: Re: [PATCH] 2.6, 2.4, Nforce2, Experimental idle halt workaround
	instead of apic ack delay.
From: Craig Bradney <cbradney@zip.com.au>
To: Jesse Allen <the3dfxdude@hotmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040212230456.GA911@tesore.local>
References: <200402120122.06362.ross@datscreative.com.au>
	 <Pine.LNX.4.58.0402121118490.515@gonopodium.signalmarketing.com>
	 <20040212214407.GA865@tesore.local>
	 <Pine.LNX.4.58.0402121544470.962@gonopodium.signalmarketing.com>
	 <1076623565.16585.11.camel@athlonxp.bradney.info>
	 <20040212230456.GA911@tesore.local>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Nx1Ah7y0185gVN0GS8Pe"
Message-Id: <1076627706.16600.20.camel@athlonxp.bradney.info>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 13 Feb 2004 00:15:06 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Nx1Ah7y0185gVN0GS8Pe
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2004-02-13 at 00:04, Jesse Allen wrote:
> On Thu, Feb 12, 2004 at 11:06:05PM +0100, Craig Bradney wrote:
>=20
> > so what does "My
> > Shuttle AN35N nforce2 board can run vanilla kernels with the 12-5-2003
> > dated bios version and not lock up." mean?
> >=20
>=20
> vanilla kernels =3D 2.6.0-test11 through 2.6.3-rc2 and no patches.  APIC =
is on.

and local APIC and ACPI?

> 12-5-2003 BIOS:
> http://marc.theaimsgroup.com/?l=3Dlinux-kernel&m=3D107124823504332&w=3D2
>=20
> not lock up:
> I could reproduce the lockup consistantly.  With the 12-5-2003 bios, I ca=
nnot.  Two months have passed since the original report.

If thats the case you are a lucky person!
>=20
> > Whenthis thread first(?) started way back when in Nov or Dec last year =
I
> > was pretty happy.. no lockups until the 5th day.
>=20
> The different nforce boards react differently because of different hardwa=
re an=20
> manufacterers.  But they all do have a common symptom. =20
>=20
> I don't know how to identify a fix from my bioses.  If someone has any cl=
ue, I=20
> will help out.

No idea either.. but the "uber bios"
(http://homepage.ntlworld.com/michael.mcclay/)
guy might be able to help some of us out if the changes were found... if
you trust someone other than your motherboard manufacturer writing
BIOSes.. but I guess thats the same as any OS project in some ways.

I notice ASUS have updated theri A7V8X BIOS to 1008.. maybe they will
release updates for their nForce2 boards soon too. One can only hope!

Craig

--=-Nx1Ah7y0185gVN0GS8Pe
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBALAj6i+pIEYrr7mQRAqKSAJ0WnxL6aJkogloxbY1QpQoxH7bmigCfdWXc
zF8LTpW0uLGIxgt1XPnZcWA=
=PufJ
-----END PGP SIGNATURE-----

--=-Nx1Ah7y0185gVN0GS8Pe--

