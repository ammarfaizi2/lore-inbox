Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263338AbUDOAaQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 20:30:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262864AbUDOAaP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 20:30:15 -0400
Received: from legolas.restena.lu ([158.64.1.34]:47235 "EHLO smtp.restena.lu")
	by vger.kernel.org with ESMTP id S263338AbUDOAaF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 20:30:05 -0400
Subject: Re: IO-APIC on nforce2 [PATCH]
From: Craig Bradney <cbradney@zip.com.au>
To: Peter Clifton <pcjc2@cam.ac.uk>
Cc: linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>,
       "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>, ross@datscreative.com.au
In-Reply-To: <1081989304.7831.8.camel@pcjc2>
References: <200404142301.33153.christian.kroener@tu-harburg.de>
	 <1081989304.7831.8.camel@pcjc2>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-lwlAsNuPrzaxnBFd/5rn"
Message-Id: <1081988997.4724.2.camel@amilo.bradney.info>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 15 Apr 2004 02:29:57 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-lwlAsNuPrzaxnBFd/5rn
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2004-04-15 at 02:35, Peter Clifton wrote:
> Sorry Christian, meant to send to the list rather than just you.
>=20
> I'm watching this thread with interest, I've got an ASUS A7N8X board,
> and have had annoying lockups with most kernels I've compiled myself
> from 2.4 upwards. Some luck caused me to try turning APIC off, and the
> system hasn't crashed since.
>=20
> Is there any reason why turning APIC off reduces performance?
>=20
> I'd be happy to provide another person to test patches (with the proviso
> that if you want detailed debugging information, you'd have to suggest
> how to obtain it, since when it locks up, it tends to lock good!)
>=20
> I'm currently running 2.6.3-gentoo-r1 (Although I can't see a list of
> what patches they have already applied).
>=20
> I'd be happy to try a vanilla kernel with whatever patches if that would
> help out solving the problem.

Peter, I have 2.6.3gentoo r1 on my box with a A7N8X Deluxe v2 with Ross
Dicksons 2.6.3 idlec1halt patches and its as stable as a rock. I've left
it on that kernel as there are still many discussions recently posted re
2.6.5. My 3 other PCs are on gentoo dev source 2.6.5 and are solid, but
I've left the Athlon on 2.6.3 due to the fact its working just fine now

Craig

--=-lwlAsNuPrzaxnBFd/5rn
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAfdeEi+pIEYrr7mQRAlgIAJ92H9MxNQieDr73TZkPwzDyy+rdvQCgjtaP
A1onBMu50137YPl9sqJpUFs=
=No5E
-----END PGP SIGNATURE-----

--=-lwlAsNuPrzaxnBFd/5rn--

