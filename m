Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263749AbTGAU2Y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 16:28:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263765AbTGAU2X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 16:28:23 -0400
Received: from wsip-68-96-149-130.no.no.cox.net ([68.96.149.130]:42631 "EHLO
	resonant.org") by vger.kernel.org with ESMTP id S263749AbTGAU2O
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 16:28:14 -0400
Date: Tue, 1 Jul 2003 15:42:36 -0500
From: Zed Pobre <zed@resonant.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: bkbits.net is down
Message-ID: <20030701204236.GA30094@singularity.resonant.org>
Mail-Followup-To: Zed Pobre <zed@resonant.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030627165519.A1887@beaverton.ibm.com> <20030628001625.GC18676@work.bitmover.com> <20030627205140.F29149@newbox.localdomain> <20030628031920.GF18676@work.bitmover.com> <1056827655.6295.22.camel@dhcp22.swansea.linux.org.uk> <20030628191847.GB8158@work.bitmover.com> <20030628193857.GH841@gallifrey> <1056832290.6289.44.camel@dhcp22.swansea.linux.org.uk> <20030628221507.GI841@gallifrey> <1056842035.6779.13.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="EeQfGwPcQSOJBaQU"
Content-Disposition: inline
In-Reply-To: <1056842035.6779.13.camel@dhcp22.swansea.linux.org.uk>
X-No-Archive: Yes
X-GPG-Fingerprint: FF 75 8D 70 57 8D A4 7D  3A DE 6D 2F 25 C3 E6 E7
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 29, 2003 at 12:13:55AM +0100, Alan Cox wrote:
> On Sad, 2003-06-28 at 23:15, Dr. David Alan Gilbert wrote:
> > Hmm - why should it suck so badly? Shouldn't USB 2 (yes I mean the
> > 480Mbps) manage 40MByte/s+ ?
>=20
> I don't think you get the full 480Mbit/sec on a single device.
> 5Mbyte/sec is a bit low but that may be some of the remaining work on
> the USB EHCI drivers. I've not tried 2.5.x which may be way better here.

    As a random data point, we're using external USB2 Maxtor IDE
drives (they also have firewire support, but the weird grille on the
back of our server prevented the firewire plug from properly inserting
into the combo USB2/firewire card I bought) for our backups on
2.4.21-rc1-rmap15g, and I was seeing around 10Mbyte/sec when I was
monitoring it the first couple times.  It's also been much more
reliable than the tape solutions we've tried, and it's hard to beat
the price.

--=20
Zed Pobre <zed@debian.org> a.k.a. Zed Pobre <zed@resonant.org>
PGP key and fingerprint available on finger; encrypted mail welcomed.

--EeQfGwPcQSOJBaQU
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iQEVAwUBPwHyPB0207zoJUw5AQFcpgf/W8Eov64NqksgWzSXGgn1e85PI+YgYNVG
87JQDkLMkDU3j+AP0JiOigRCoFllFiw30j2mIHFBBvn+WtcvudqCsO16WaDMQViW
vTyIyuSunYOREypJT1GKvMtepz9bnm6d5h849QmLFs/3MzZURAIK4SWUc68dYU96
cb3mraXT7wychZ1iDMzBgMMPl3nNdJDSOCpc/+KKY7NZu7KwKVZnecboBrJGN8+e
bj4cK+o6LzNaeKKCrHJhjKq3HfxEcZART3kdUIyH9TcNTK5BAYm8S41mN2DTUzFJ
uSQKFvE+37GYPcddK18Au9CFObr1vGkGJzSzJ480p6ajTJ3eNNjtuw==
=EhnY
-----END PGP SIGNATURE-----

--EeQfGwPcQSOJBaQU--
