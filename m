Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261607AbVCNAqB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261607AbVCNAqB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Mar 2005 19:46:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261612AbVCNAqB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Mar 2005 19:46:01 -0500
Received: from ctb-mesg3.saix.net ([196.25.240.75]:25259 "EHLO
	ctb-mesg3.saix.net") by vger.kernel.org with ESMTP id S261607AbVCNApw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Mar 2005 19:45:52 -0500
Subject: Re: OSS Audio borked between 2.6.6 and 2.6.10
From: Martin Schlemmer <azarah@nosferatu.za.org>
Reply-To: Martin Schlemmer <azarah@nosferatu.za.org>
To: Greg Stark <gsstark@mit.edu>
Cc: Patrick McFarland <pmcfarland@downeast.net>, linux-kernel@vger.kernel.org
In-Reply-To: <874qff89ob.fsf@stark.xeocode.com>
References: <87u0ng90mo.fsf@stark.xeocode.com>
	 <200503130152.52342.pmcfarland@downeast.net>
	 <874qff89ob.fsf@stark.xeocode.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-vjhUN5qHXbk46JgkADTB"
Date: Mon, 14 Mar 2005 02:48:44 +0200
Message-Id: <1110761325.9011.5.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.0 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-vjhUN5qHXbk46JgkADTB
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2005-03-13 at 17:26 -0500, Greg Stark wrote:
> Patrick McFarland <pmcfarland@downeast.net> writes:
>=20
> > On Saturday 12 March 2005 01:31 pm, Greg Stark wrote:
> > > OSS Audio doesn't work properly for Quake3 in 2.6.10 but it worked in
> > > 2.6.6. In fact I have the same problems in 2.6.9-rc1 so I assume 2.6.=
9 is
> > > affected as well. This is with the Intel i810 drivers.
> >=20
> > Why are you not using ALSA?
>=20
> Well frankly because whenever I tried it it didn't work. The i810 drivers=
 were
> *completely* broken in the 2.6 kernel I original installed, 2.6.5 I think=
.
>=20
> In any case I understood that Quake doesn't work with alsa drivers becaus=
e it
> depends on mmapped output which they don't support at all. Or something l=
ike
> that. I gave up on them when I found OSS worked reliably.
>=20

Quake3 works fine here with alsa and the oss emulation ...


--=20
Martin Schlemmer


--=-vjhUN5qHXbk46JgkADTB
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBCNN9sqburzKaJYLYRAh7UAJoD2UyTRX6LEhZecg5+o9i+ZJLIYwCfTjGd
tI0JsoSDK6wpmPWg7a6G16U=
=3WcB
-----END PGP SIGNATURE-----

--=-vjhUN5qHXbk46JgkADTB--

