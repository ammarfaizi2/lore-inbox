Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263684AbUDUUdm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263684AbUDUUdm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 16:33:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263696AbUDUUdm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 16:33:42 -0400
Received: from mxfep02.bredband.com ([195.54.107.73]:6274 "EHLO
	mxfep02.bredband.com") by vger.kernel.org with ESMTP
	id S263684AbUDUUdk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 16:33:40 -0400
Subject: Re: IO-APIC on nforce2 [PATCH] + [PATCH] for nmi_debug=1 + [PATCH]
	for idle=C1halt, 2.6.5
From: Ian Kumlien <pomac@vapor.com>
To: Len Brown <len.brown@intel.com>
Cc: Craig Bradney <cbradney@zip.com.au>, ross@datscreative.com.au,
       christian.kroener@tu-harburg.de, linux-kernel@vger.kernel.org,
       "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
       Jamie Lokier <jamie@shareable.org>,
       "Prakash K. Cheemplavam" <PrakashKC@gmx.de>,
       Daniel Drake <dan@reactivated.net>,
       Jesse Allen <the3dfxdude@hotmail.com>, a.verweij@student.tudelft.nl,
       Allen Martin <AMartin@nvidia.com>
In-Reply-To: <1082578957.16334.13.camel@dhcppc4>
References: <200404131117.31306.ross@datscreative.com.au>
	 <200404131703.09572.ross@datscreative.com.au>
	 <1081893978.2251.653.camel@dhcppc4>
	 <200404160110.37573.ross@datscreative.com.au>
	 <1082060255.24425.180.camel@dhcppc4>
	 <1082063090.4814.20.camel@amilo.bradney.info>
	 <1082578957.16334.13.camel@dhcppc4>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-ECG5U4TLHJF6lWhLAFrQ"
Message-Id: <1082579613.7714.25.camel@big>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 21 Apr 2004 22:33:33 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ECG5U4TLHJF6lWhLAFrQ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2004-04-21 at 22:22, Len Brown wrote:
> On Thu, 2004-04-15 at 17:04, Craig Bradney wrote:
> > > Got any opinions on which system to use as the example?
> > > I'll need the output from dmidecode for them.
> >=20
> > I have an A7N8X Deluxe v2 BIOS v1007 that I can give u whatever numbers
> > u need. IOAPIC and APIC are on.
>=20
> Please send me the output from dmidecode, available in /usr/sbin/, or

I sent a off ml dmidecode from my ASUS A7N8X-X 2.xx (BIOS: 1007)
Motherboard.

I have also TRIED to send some complaints to ASUS, but thats harder than
you might expect... =3DP

--=20
Ian Kumlien <pomac () vapor ! com> -- http://pomac.netswarm.net

--=-ECG5U4TLHJF6lWhLAFrQ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAhtqd7F3Euyc51N8RAh90AJ9J31cM1AknyY9pf+ph12qeT13XoQCgqVza
uHY5sV/NhrbDoaMIJJSpC6A=
=q2Xq
-----END PGP SIGNATURE-----

--=-ECG5U4TLHJF6lWhLAFrQ--

