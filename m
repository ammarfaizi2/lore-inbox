Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264808AbUFTAko@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264808AbUFTAko (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 20:40:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264815AbUFTAko
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 20:40:44 -0400
Received: from websrv.werbeagentur-aufwind.de ([213.239.197.241]:2013 "EHLO
	websrv.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S264808AbUFTAkm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 20:40:42 -0400
Subject: Re: 2.6.7 Samba OOPS (in smb_readdir)
From: Christophe Saout <christophe@saout.de>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Brice Goglin <Brice.Goglin@ens-lyon.fr>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0406192035590.2228@montezuma.fsmlabs.com>
References: <Pine.LNX.4.58.0406152253390.6392@ppc970.osdl.org>
	 <20040618163759.GN1146@ens-lyon.fr> <20040618164125.GO1146@ens-lyon.fr>
	 <Pine.LNX.4.58.0406181309440.2228@montezuma.fsmlabs.com>
	 <1087585251.13235.3.camel@leto.cs.pocnet.net>
	 <1087586532.9085.1.camel@leto.cs.pocnet.net>
	 <Pine.LNX.4.58.0406191624430.2228@montezuma.fsmlabs.com>
	 <Pine.LNX.4.58.0406191648240.2228@montezuma.fsmlabs.com>
	 <Pine.LNX.4.58.0406191946360.2228@montezuma.fsmlabs.com>
	 <1087691335.19685.1.camel@leto.cs.pocnet.net>
	 <Pine.LNX.4.58.0406192035590.2228@montezuma.fsmlabs.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-5AJ1HQyyeswXTaRtpB6Z"
Date: Sun, 20 Jun 2004 02:40:23 +0200
Message-Id: <1087692023.20937.3.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.9.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-5AJ1HQyyeswXTaRtpB6Z
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Am Sa, den 19.06.2004 um 20:36 Uhr -0400 schrieb Zwane Mwaikambo:

> > Ha! Success! :-)
>=20
> Great, and Nautilus is happy? By the way, which OS is the SMB server?

Yes, everyone is happy now. It's a samba (3.0.4) server. NFS is
currently also broken on that machine (my fault). That server machine is
so dog slow that I'm currently not interested in rebooting it. But at
least smbfs is working now so I don't need to use rsync to access my
files anymore. ;)

Well, I tested mounting/unmounting it several times and it worked
without glitches where I had a nearly 100% chance of making it Oops
before.


--=-5AJ1HQyyeswXTaRtpB6Z
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBA1Nz2ZCYBcts5dM0RAuXDAJ45DytQKIhGd5VjuMDFxtrTlC1HWwCgp+OM
SJG5i8cS/LxLtmgj+ShPrj8=
=R9nZ
-----END PGP SIGNATURE-----

--=-5AJ1HQyyeswXTaRtpB6Z--

