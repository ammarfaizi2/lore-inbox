Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261638AbUDOTUp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 15:20:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262339AbUDOTUp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 15:20:45 -0400
Received: from legolas.restena.lu ([158.64.1.34]:13971 "EHLO smtp.restena.lu")
	by vger.kernel.org with ESMTP id S261638AbUDOTUm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 15:20:42 -0400
Subject: RE: IO-APIC on nforce2 [PATCH]
From: Craig Bradney <cbradney@zip.com.au>
To: Allen Martin <AMartin@nvidia.com>
Cc: ross@datscreative.com.au, Len Brown <len.brown@intel.com>,
       Christian =?ISO-8859-1?Q?Kr=F6ner?= 
	<christian.kroener@tu-harburg.de>,
       Linux-Nforce-Bugs <Linux-Nforce-Bugs@exchange.nvidia.com>,
       linux-kernel@vger.kernel.org, "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
In-Reply-To: <DCB9B7AA2CAB7F418919D7B59EE45BAF49FB9D@mail-sc-6-bk.nvidia.com>
References: <DCB9B7AA2CAB7F418919D7B59EE45BAF49FB9D@mail-sc-6-bk.nvidia.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-FCuKV4wR57wIOJRoMHO3"
Message-Id: <1082056834.4827.13.camel@amilo.bradney.info>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 15 Apr 2004 21:20:34 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-FCuKV4wR57wIOJRoMHO3
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2004-04-15 at 20:33, Allen Martin wrote:
> > True it is a bios thing but I have yet to see an nforce2 MOBO=20
> > that is not=20
> > routed in this way. I am thinking it is internal to the=20
> > chipset. I have seen
> > none route it into io-apic pin2.
>=20
> It was a bug in our original nForce reference BIOS that we gave out to ve=
ndors.  Since then we fixed the reference BIOS, but since it was after prod=
ucts shipped, most of the motherboard vendors won't pick up the change unle=
ss they get complaints from customers.
>=20
> We've fixed it for our reference BIOS for future products though.

Would it not be worth Nvidia advising the vendors (possibly already
done) that there are nForce BIOS issues causing reproducable hard
crashes with their existing BIOS versions with relation to the issue
here? I realise that these manufacturers (in my case ASUS) may have no
obligation and have their own product schedules of course.

There would seem to be many people puchasing nForce based systems and
many will not find out how or why there is the problem.

I for one, will not be buying another nForce based motherboard until I'm
sure this issue is sorted properly. Yes, I will probably find issues on
other boards, but I have no such hard crashes on an old P3 Sis chipset
board, a VIA KT Abit Duron board, nor on this P4 board with the very
same kernel source.

While my single purchases make no difference in the scheme of things,
the lack of support from the various manufacturers given to the kernel
developers  (I refer in this case to Ross Dickson trying to get help
from Nvidia and another, I think AMD) is turning me away (back to Intel
CPUs).

Of course, I am very happy to finally see a response from someone from
Nvidia now.

With best regards
Craig Bradney



--=-FCuKV4wR57wIOJRoMHO3
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAfuCCi+pIEYrr7mQRApFKAJ4wBhMGITHv36qSo2GYH3iVvEAUrQCdEbP6
6TFGgduprcwu/da3ozHpgg4=
=cxov
-----END PGP SIGNATURE-----

--=-FCuKV4wR57wIOJRoMHO3--

