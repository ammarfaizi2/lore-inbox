Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272234AbTHDUYY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 16:24:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272235AbTHDUYY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 16:24:24 -0400
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:31739 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S272234AbTHDUYT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 16:24:19 -0400
Subject: RE: your HOWTO "2.6.0-test1 on RH90" - question
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: wsong@ece.uci.edu
Cc: Stefan Winter <mail@stefan-winter.de>, linux-kernel@vger.kernel.org
In-Reply-To: <MEEKIEPDOBGHADOEHGGOCELECBAA.wsong@ece.uci.edu>
References: <MEEKIEPDOBGHADOEHGGOCELECBAA.wsong@ece.uci.edu>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-BvDTa348Bf08KYqw0be9"
Organization: Red Hat, Inc.
Message-Id: <1060028643.5291.3.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 (1.4.3-3) 
Date: 04 Aug 2003 22:24:03 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-BvDTa348Bf08KYqw0be9
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2003-08-04 at 22:02, Song Wang wrote:
> Hi,
>=20
> There is dependency between "Input device support" and virtul terminal.
> In order to be able to see 'Virutal Terminal' in Character devices,
> you have to set the 'Input devices (needed for keyboard, mouse,...)' from
> 'M' to 'Y' under  "Input device support".
>=20
> I have updated my mini-how for this
> (http://www.ags.uci.edu/~songw/kernel2.6-rh90-howto.txt)

you can also point to http://people.redhat.com/arjanv/2.5
for prebuild rpms (and rpms with example configs)


--=-BvDTa348Bf08KYqw0be9
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/LsDjxULwo51rQBIRAuS2AJ9eLKqD/gfFpSishYGVZnJ4dnhupQCgmnWu
1/uof2H46pJUUGLtpLkVp2k=
=Wxua
-----END PGP SIGNATURE-----

--=-BvDTa348Bf08KYqw0be9--
