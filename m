Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262571AbTFBQJU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 12:09:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262577AbTFBQJT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 12:09:19 -0400
Received: from mx02.qsc.de ([213.148.130.14]:60058 "EHLO mx02.qsc.de")
	by vger.kernel.org with ESMTP id S262571AbTFBQJR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 12:09:17 -0400
Date: Mon, 2 Jun 2003 18:24:48 +0200
From: Wiktor Wodecki <wodecki@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Re: weird keyboard with 2.5.70
Message-ID: <20030602162447.GD3237@gmx.de>
Reply-To: Wiktor Wodecki <wodecki@gmx.net>
References: <3ED7BECC.1000109@g-house.de> <20030531151615.GA13051@sexmachine.doom> <1054570309.1208.8.camel@andyp.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ReaqsoxgOBHFXBhH"
Content-Disposition: inline
In-Reply-To: <1054570309.1208.8.camel@andyp.pdx.osdl.net>
X-message-flag: Linux - choice of the GNU generation
X-Operating-System: Linux 2.5.70 i686
X-PGP-KeyID: 182C9783
X-Info: X-PGP-KeyID, send an email with the subject 'public key request' to wodecki@gmx.de
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 02, 2003 at 09:11:49AM -0700, Andy Pfiffer wrote:
> On Sat, 2003-05-31 at 08:16, Konstantin Kletschke wrote:
>=20
> > Sometime a key is very fast repeated 10 to 20 times after pressed only
> > one.
>=20
> I have seen this on one of two systems connected to a 4-port KVM
> switch.  I started seeing it in 2.5.68 or 2.5.69.  The other system has
> not demonstrated the super-fast repeat.

I see this on my ibm thinkpad T20 with 2.5.69. I manually raised my
kbdrate(1) settings and that helps. However when switching between X
and text-consoles it gets worse after a while.

--=20
Regards,

Wiktor Wodecki

--ReaqsoxgOBHFXBhH
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+23pP6SNaNRgsl4MRAqYOAJ0bjV7ECHJS4n219xqdH07W/wbKhQCaAt77
mJkGilcvVNb4LR8F55zcTEk=
=iCK3
-----END PGP SIGNATURE-----

--ReaqsoxgOBHFXBhH--
