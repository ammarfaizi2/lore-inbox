Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266596AbUBLXui (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 18:50:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266609AbUBLXui
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 18:50:38 -0500
Received: from legolas.restena.lu ([158.64.1.34]:57063 "EHLO smtp.restena.lu")
	by vger.kernel.org with ESMTP id S266596AbUBLXuc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 18:50:32 -0500
Subject: Re: [PATCH] 2.6, 2.4, Nforce2, Experimental idle halt workaround
	instead of apic ack delay.
From: Craig Bradney <cbradney@zip.com.au>
To: Jesse Allen <the3dfxdude@hotmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040212233752.GA1479@tesore.local>
References: <200402120122.06362.ross@datscreative.com.au>
	 <Pine.LNX.4.58.0402121118490.515@gonopodium.signalmarketing.com>
	 <20040212214407.GA865@tesore.local>
	 <Pine.LNX.4.58.0402121544470.962@gonopodium.signalmarketing.com>
	 <1076623565.16585.11.camel@athlonxp.bradney.info>
	 <20040212230456.GA911@tesore.local>
	 <1076627706.16600.20.camel@athlonxp.bradney.info>
	 <20040212233752.GA1479@tesore.local>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-21c8CY/VFzkcAYawDMWy"
Message-Id: <1076629833.16585.25.camel@athlonxp.bradney.info>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 13 Feb 2004 00:50:33 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-21c8CY/VFzkcAYawDMWy
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2004-02-13 at 00:37, Jesse Allen wrote:
> On Fri, Feb 13, 2004 at 12:15:06AM +0100, Craig Bradney wrote:
> > On Fri, 2004-02-13 at 00:04, Jesse Allen wrote:
> > > vanilla kernels =3D 2.6.0-test11 through 2.6.3-rc2 and no patches.  A=
PIC is=20
> > > on.
> >=20
> > and local APIC and ACPI?
>=20
> Yes.
>=20
> > > 12-5-2003 BIOS:
> > > http://marc.theaimsgroup.com/?l=3Dlinux-kernel&m=3D107124823504332&w=
=3D2
> > >=20
> > > not lock up:
> > > I could reproduce the lockup consistantly.  With the 12-5-2003 bios, =
I=20
> > > cannot.  Two months have passed since the original report.
> >=20
> > If thats the case you are a lucky person!
>=20
> I know =3D)
>=20
> > > I don't know how to identify a fix from my bioses.  If someone has an=
y=20
> > > clue, I will help out.
> >=20
> > No idea either.. but the "uber bios"
> > (http://homepage.ntlworld.com/michael.mcclay/)
> > guy might be able to help some of us out if the changes were found... i=
f
> > you trust someone other than your motherboard manufacturer writing
> > BIOSes.. but I guess thats the same as any OS project in some ways.
> >=20
>=20
> What we need is a kernel patch, because it will be difficult to produce b=
ios=20
> fixes for each bios iteration.  If he can identify what the changes are i=
n my=20
> bios and identify a bug, then a sufficiently talented kernel hacker can p=
roduce
> the work-around for other buggy bioses.

I dont know the guy myself, but maybe as you can hand him two BIOS
files, he might be able to work out the difference for us if you sent
him an email?

Craig

--=-21c8CY/VFzkcAYawDMWy
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBALBFJi+pIEYrr7mQRAqa/AKChrmoLsQVcA+mJ/fMOeLv3U7ZEjgCfSYBp
9yUH2dbBy1x6cSu3Ch+J/wk=
=rEq9
-----END PGP SIGNATURE-----

--=-21c8CY/VFzkcAYawDMWy--

