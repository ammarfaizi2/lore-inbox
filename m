Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269501AbUI3VCI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269501AbUI3VCI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 17:02:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269474AbUI3VCI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 17:02:08 -0400
Received: from mh57.com ([217.160.185.21]:54461 "EHLO mithrin.mh57.de")
	by vger.kernel.org with ESMTP id S269520AbUI3U64 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 16:58:56 -0400
Date: Thu, 30 Sep 2004 22:58:51 +0200
From: Martin Hermanowski <martin@mh57.de>
To: Roland Dreier <roland.list@gmail.com>
Cc: linux-thinkpad@linux-thinkpad.org, linux-kernel@vger.kernel.org
Subject: Re: Hard lockup on IBM ThinkPad T42
Message-ID: <20040930205851.GA6911@mh57.de>
References: <f8ca0a1504093011206230ddea@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="X1bOJ3K7DJ5YkBrT"
Content-Disposition: inline
In-Reply-To: <f8ca0a1504093011206230ddea@mail.gmail.com>
User-Agent: Mutt/1.5.6+20040722i
X-Broken-Reverse-DNS: no host name found for IP address 2001:8d8:81:4d0:8000::1
X-Spam-Score: -2.5 (--)
X-Authenticated-ID: martin
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 30, 2004 at 11:20:17AM -0700, Roland Dreier wrote:
> Hi, I just got an IBM ThinkPad T42 (model 2378FVU) with
> Centrino/Pentium M 735 and a Radeon 9600.  I'm running 2.6.9-rc3 (with
> ipw2200 0.9 wireless drivers) and I've experienced several hard
> lockups over the past few days.
>=20
> The system seems to be completely unresponsive to keyboard and
> network, and even "nmi_watchdog=3D2" didn't produce anything.  I'm not
> sure what triggers the lockup -- I've had them happen while the system
> was idle running an X screensaver, and also while I've been on the
> console (non-X) doing nothing but typing through an ssh connection.=20
> Generally it takes a couple of hours for the lockup to happen.

I have lockups in X running xlock with my T41p about once a month,
running 2.6.7-rc3-mm1 with atheros and the XFree4.3 radeon driver.

The only thing I noticed is that the hdd-led is constantly on when this
happens.

LLAP, Martin

--X1bOJ3K7DJ5YkBrT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBXHOLmGb6Npij0ewRAmDFAJ9w1YTqkYGFXdKAkb3Cbqnl2mSM0gCeNby7
h2usi7mw5j3ZlTh1nrrfXog=
=xfD/
-----END PGP SIGNATURE-----

--X1bOJ3K7DJ5YkBrT--
