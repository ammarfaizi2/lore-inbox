Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131974AbRDGVpt>; Sat, 7 Apr 2001 17:45:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131985AbRDGVpk>; Sat, 7 Apr 2001 17:45:40 -0400
Received: from lacrosse.corp.redhat.com ([207.175.42.154]:21822 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S131974AbRDGVp0>; Sat, 7 Apr 2001 17:45:26 -0400
Date: Sat, 7 Apr 2001 22:45:12 +0100
From: Tim Waugh <twaugh@redhat.com>
To: Gunther Mayer <Gunther.Mayer@t-online.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PATCH for Broken PCI Multi-IO in 2.4.3 (serial+parport)
Message-ID: <20010407224512.K3280@redhat.com>
In-Reply-To: <3ACECA8F.FEC9439@eunet.at> <3ACED679.7E334234@mandrakesoft.com> <20010407111419.B530@redhat.com> <3ACF5F9B.AA42F1BD@t-online.de> <20010407200340.C3280@redhat.com> <3ACF6920.465635A1@mandrakesoft.com> <3ACF76B7.44F6279@t-online.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="KaGhPsiNaI6/sRd6"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3ACF76B7.44F6279@t-online.de>; from Gunther.Mayer@t-online.de on Sat, Apr 07, 2001 at 10:21:11PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--KaGhPsiNaI6/sRd6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 07, 2001 at 10:21:11PM +0200, Gunther Mayer wrote:

> Many users will be surprised if they must load another module
> (e.g."pci_multiio") to get their parallel and serial ports working.
>=20
> Thus _must not_ happen in the stable release.

Yes, I agree.  I am planning for parport_serial.c to end up as part of
parport_pc.o for 2.4.

Tim.
*/

--KaGhPsiNaI6/sRd6
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6z4pnONXnILZ4yVIRAijtAJ9QwHwphkfjeC/KoXuKMslo5qvC7QCeI2BH
W39tdwEtcDmalLUAerMHcs8=
=/LNH
-----END PGP SIGNATURE-----

--KaGhPsiNaI6/sRd6--
