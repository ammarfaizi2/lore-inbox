Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264233AbTDPF5h (for <rfc822;willy@w.ods.org>); Wed, 16 Apr 2003 01:57:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264235AbTDPF5h 
	(for <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 01:57:37 -0400
Received: from iucha.net ([209.98.146.184]:52012 "EHLO mail.iucha.net")
	by vger.kernel.org with ESMTP id S264233AbTDPF5g 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 01:57:36 -0400
Date: Wed, 16 Apr 2003 01:09:28 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: Kernels since 2.5.60 upto 2.5.67 freeze when X server terminates
Message-ID: <20030416060928.GE29143@iucha.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20030415133608.A1447@cuculus.switch.gts.cz> <20030415125507.GA29143@iucha.net> <3E9C03DD.3040200@oracle.com> <20030415164435.GA6389@rivenstone.net> <20030415182057.GC29143@iucha.net> <20030416044144.GA32400@rivenstone.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VdOwlNaOFKGAtAAV"
Content-Disposition: inline
In-Reply-To: <20030416044144.GA32400@rivenstone.net>
X-message-flag: Outlook: Where do you want [your files] to go today?
X-gpg-key: http://iucha.net/florin_iucha.gpg
X-gpg-fingerprint: 41A9 2BDE 8E11 F1C5 87A6  03EE 34B3 E075 3B90 DFE4
User-Agent: Mutt/1.5.3i
From: florin@iucha.net (Florin Iucha)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--VdOwlNaOFKGAtAAV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 16, 2003 at 12:41:48AM -0400, Joseph Fannin wrote:
> > I have a Radeon 8500 and AGP 4x is enabled in BIOS. The motherboard is
> > ECS K7S5A (SIS 735 chipset).
>=20
>     Except that I'm seeing the very same sort of freeze on with a
>  Rage128 card with XFree86 4.2.1.
>=20
>     Are we all Debian sid users, perhaps?

I am, indeed.

>     Or maybe the Rage128 needs a similar patch to the Radeon one you
> posted.

Try with AGP disabled. It worked for me, but glxgears suck :(

florin

--=20

"NT is to UNIX what a doughnut is to a particle accelerator."

--VdOwlNaOFKGAtAAV
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+nPOYNLPgdTuQ3+QRAmrGAJ9s9/GYXpUNpWdXxXg6UGv70M0uJACeLGBm
vTmf5Y31z/TDoIOmiiJUYeU=
=8NSx
-----END PGP SIGNATURE-----

--VdOwlNaOFKGAtAAV--
