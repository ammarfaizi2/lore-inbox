Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270471AbTHGTnb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 15:43:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270479AbTHGTnb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 15:43:31 -0400
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:11760 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S270471AbTHGTn3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 15:43:29 -0400
Subject: RE: [APM]  CPU idle calls causing problem with ASUS P4PE MoBo
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Kathy Frazier <kfrazier@mdc-dayton.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <PMEMILJKPKGMMELCJCIGAEADCEAA.kfrazier@mdc-dayton.com>
References: <PMEMILJKPKGMMELCJCIGAEADCEAA.kfrazier@mdc-dayton.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-J3+SmlJd3tghLDqtJO3+"
Organization: Red Hat, Inc.
Message-Id: <1060285402.24858.0.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-2) 
Date: Thu, 07 Aug 2003 21:43:23 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-J3+SmlJd3tghLDqtJO3+
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2003-08-07 at 21:46, Kathy Frazier wrote:
> >if you can mail the top part of the dmidecode output (the part that has
> >the bios idents) the machine can trivially be added to the apm idle
> >blacklist.
>=20
> Is this in the message file?  I didn't see anything with "DMI" in it.  Is
> this what you are looking for?  If not, please let me know.

dmidecode is an application that comes in the kernel-utils rpm that
dumps a bunch of BIOS information

--=-J3+SmlJd3tghLDqtJO3+
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/MqvaxULwo51rQBIRAm18AKCZyqIxdk3p6qShiaDffuOnnlhJlACgjUZP
u5HTmkis0CnBrmpadv5lOPg=
=GytV
-----END PGP SIGNATURE-----

--=-J3+SmlJd3tghLDqtJO3+--
