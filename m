Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264173AbTDPAeG (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 20:34:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264174AbTDPAeG 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 20:34:06 -0400
Received: from iucha.net ([209.98.146.184]:13864 "EHLO mail.iucha.net")
	by vger.kernel.org with ESMTP id S264173AbTDPAeE 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Apr 2003 20:34:04 -0400
Date: Tue, 15 Apr 2003 19:45:56 -0500
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org, davej@codemonkey.org.uk
Subject: Re: Kernels since 2.5.60 upto 2.5.67 freeze when X server terminates
Message-ID: <20030416004556.GD29143@iucha.net>
Mail-Followup-To: Andrew Morton <akpm@digeo.com>,
	linux-kernel@vger.kernel.org, davej@codemonkey.org.uk
References: <20030415133608.A1447@cuculus.switch.gts.cz> <20030415125507.GA29143@iucha.net> <3E9C03DD.3040200@oracle.com> <20030415164435.GA6389@rivenstone.net> <20030415182057.GC29143@iucha.net> <20030415154355.08ef6672.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mSxgbZZZvrAyzONB"
Content-Disposition: inline
In-Reply-To: <20030415154355.08ef6672.akpm@digeo.com>
X-message-flag: Outlook: Where do you want [your files] to go today?
X-gpg-key: http://iucha.net/florin_iucha.gpg
X-gpg-fingerprint: 41A9 2BDE 8E11 F1C5 87A6  03EE 34B3 E075 3B90 DFE4
User-Agent: Mutt/1.5.3i
From: florin@iucha.net (Florin Iucha)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--mSxgbZZZvrAyzONB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 15, 2003 at 03:43:55PM -0700, Andrew Morton wrote:
> florin@iucha.net (Florin Iucha) wrote:
> >
> > I think it has to do with the interaction between XFree86 4.3.0 and
> > the AGP code.
>=20
> Has anyone tried disabling kernel AGP support and retesting?

Now that you suggested it, I disabled kernel AGP support and 4.3.0
(Daniel Stone Debian packages) works fine so far.

Thanks,
florin

--=20

"NT is to UNIX what a doughnut is to a particle accelerator."

--mSxgbZZZvrAyzONB
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+nKfENLPgdTuQ3+QRAtzzAJ45iMnsIG9eAg1P/TmruTtNMn2p1wCfdqJY
5Uat1MmTK8A2Jr7WtbRA8uw=
=2aty
-----END PGP SIGNATURE-----

--mSxgbZZZvrAyzONB--
