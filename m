Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267856AbUH2NqM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267856AbUH2NqM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 09:46:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267840AbUH2NqM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 09:46:12 -0400
Received: from ctb-mesg1.saix.net ([196.25.240.73]:6595 "EHLO
	ctb-mesg1.saix.net") by vger.kernel.org with ESMTP id S267835AbUH2NqA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 09:46:00 -0400
Subject: Re: [UPDATED PATCH 1/2] export module parameters in sysfs for
	modules _and_ built-in code [u]
From: "Martin Schlemmer [c]" <azarah@nosferatu.za.org>
Reply-To: azarah@nosferatu.za.org
To: Dominik Brodowski <linux@dominikbrodowski.de>
Cc: Rusty Russell <rusty@rustcorp.com.au>, Greg KH <greg@kroah.com>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040829131438.GF17032@dominikbrodowski.de>
References: <20040801165407.GA8667@dominikbrodowski.de>
	 <1091426395.430.13.camel@bach> <20040802214710.GB7772@dominikbrodowski.de>
	 <1092858948.8998.47.camel@nosferatu.lan>
	 <20040829131438.GF17032@dominikbrodowski.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-7STgKytV47NNXU6gWRaX"
Message-Id: <1093787383.27951.3.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 29 Aug 2004 15:49:43 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-7STgKytV47NNXU6gWRaX
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2004-08-29 at 15:14, Dominik Brodowski wrote:
> On Wed, Aug 18, 2004 at 09:55:49PM +0200, Martin Schlemmer wrote:
> > On Mon, 2004-08-02 at 23:47, Dominik Brodowski wrote:
> >=20
> > I know its tainted (nvidia), but this is difficult to test,
> > as it usually only happens if the box have been up for a while
> > and I modprobe something (ext2 in most of the cases).
>=20
> Sorry for the delay, was on vacations... Which variant of the patch were =
you
> using? Did it already shuffle the section of kernel_param around? If not,
> that's the cause -- and that patch has reached Linus' tree by now.
>=20

Hmm, I cant remember if it was you second last, or last version.  I
dropped it for the time being, and have not yet checked through my
patches for 2.6.9-rc1 - hopefully will get time next week, and if the
problem persist, I will let you know (should be 2.6.9-rc1-bk_something_,
so I assume your last stuff would have gone in already if it went to
Linus ...).


Thanks,

--=20
Martin Schlemmer

--=-7STgKytV47NNXU6gWRaX
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBBMd72qburzKaJYLYRAjzEAJ9QeAeSNiCN2FjhNjQutBeJjogobgCeJLXb
b1PdhXBTMfeeDNkm6S1Q+mE=
=3LjV
-----END PGP SIGNATURE-----

--=-7STgKytV47NNXU6gWRaX--

