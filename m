Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264649AbUEENLr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264649AbUEENLr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 09:11:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264664AbUEENLr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 09:11:47 -0400
Received: from mxfep01.bredband.com ([195.54.107.70]:7354 "EHLO
	mxfep01.bredband.com") by vger.kernel.org with ESMTP
	id S264649AbUEENIH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 09:08:07 -0400
Subject: Re: IO-APIC on nforce2 [PATCH] + [PATCH] for nmi_debug=1 + [PATCH]
	for idle=C1halt, 2.6.5
From: Ian Kumlien <pomac@vapor.com>
To: ross@datscreative.com.au
Cc: Allen Martin <AMartin@nvidia.com>, linux-kernel@vger.kernel.org,
       Len Brown <len.brown@intel.com>, Jesse Allen <the3dfxdude@hotmail.com>,
       "Prakash K. Cheemplavam" <PrakashKC@gmx.de>,
       Craig Bradney <cbradney@zip.com.au>, christian.kroener@tu-harburg.de,
       "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
       Jamie Lokier <jamie@shareable.org>, Daniel Drake <dan@reactivated.net>
In-Reply-To: <200405052252.29359.ross@datscreative.com.au>
References: <DCB9B7AA2CAB7F418919D7B59EE45BAF49FC2D@mail-sc-6-bk.nvidia.com>
	 <200405052124.55515.ross@datscreative.com.au>
	 <1083759539.2797.24.camel@big>
	 <200405052252.29359.ross@datscreative.com.au>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-4d0206BzBFNee4nUAPRR"
Message-Id: <1083762481.2797.49.camel@big>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 05 May 2004 15:08:01 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-4d0206BzBFNee4nUAPRR
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2004-05-05 at 14:52, Ross Dickson wrote:
> On Wednesday 05 May 2004 22:18, Ian Kumlien wrote:
> > On Wed, 2004-05-05 at 13:24, Ross Dickson wrote:
> > <snip>
> > > They can't see through their Windows.??!@@#$$%%&*&
> > >=20
> > > ML1-0505-19 Re: Cause of lockups with KM-18G Pro is incorrect pci reg=
 values in bios -please update bios
> > >=20
> > > From:=20
> > > "dr.pro" <dr.pro@albatron.com.tw>
> > >=20
> > > To:=20
> > > <ross@datscreative.com.au>
> > >=20
> > > Date:=20
> > > Today 17:38:08
> > >=20
> > >   Dear Ross,
> > >=20
> > >   Thank you very much for contacting Albatron technical support.
> > >=20
> > >   KM18G Pro has been proved under Windows 98SE/ME/2000/XP but Linux, =
so you
> > > may encounter problems with it under Linux. We suggest you use Window=
s
> > > 98SE/ME/2000/XP for the stable performance. Sorry for the inconvenien=
ce and
> > > please kindly understand it.
> > >=20
> > >   Please let us know if you have any question.
> >=20
> > Please kindly understand it? I wouldn't... I'm about to bash asus, so..=
.
> > This information gets me in the moood to do some real bashing =3D)
> >=20
> > Btw, does windows do a C1 disconnect? And if so how often?
>=20
> I think it does as temps are lower then linux without disconnect.
> Here are some temperatures from my machine read from the bios on reboot.
> I gave it minimal activity for the minutes prior to reboot.
>=20
>  Win98, 47C
>  XPHome, 42C
>  Patched Linux 2.4.24 (1000Hz), 40C
>  Linux 2.6.3-rc1-mm1, 53C  with no disconnect
> =20
> I think the disconnect happens for less time percentage. With slower
> ticks one might assume less often than linux.=20
> -Ross

Which means that the problem isn't as likely to occur under Windows,
which also explains why mb-manuf ppl are lazy =3DP.
=20
--=20
Ian Kumlien <pomac () vapor ! com> -- http://pomac.netswarm.net

--=-4d0206BzBFNee4nUAPRR
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAmOcx7F3Euyc51N8RAurUAJwNJASNaCwHVY2MU97wqOFEZKHUVQCfbyfc
py4q+PKlKxTynkFmi6gIrJ8=
=8IUG
-----END PGP SIGNATURE-----

--=-4d0206BzBFNee4nUAPRR--

