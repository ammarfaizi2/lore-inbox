Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264419AbUAHNnI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 08:43:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264446AbUAHNnI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 08:43:08 -0500
Received: from absinthe.ifi.unizh.ch ([130.60.75.58]:8617 "EHLO
	diamond.madduck.net") by vger.kernel.org with ESMTP id S264419AbUAHNnE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 08:43:04 -0500
Date: Thu, 8 Jan 2004 14:43:03 +0100
From: Martin F Krafft <krafft@ailab.ch>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: RAID 5 from 2.4.24 to 2.6.0
Message-ID: <20040108134303.GA3288@piper.madduck.net>
Mail-Followup-To: Martin F Krafft <krafft@ailab.ch>,
	linux kernel mailing list <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dDRMvlgZJXvWKvBx"
Content-Disposition: inline
Organization: AILab, IFI, University of Zurich
X-OS: Debian GNU/Linux testing/unstable kernel 2.6.0-diamond i686
X-Mailer: Mutt 1.5.4i (2003-03-19)
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Due to stability problems with the RAID code in 2.4 (detaailed
message forthcoming), I would like to try 2.6.0 on one of our
servers. However, anticipating problems, I want to make sure that
this change is not irreversible.

Can I mount RAID 1 and 5 partitions in 2.6.0 and 2.4.24
interchangeably?

Thanks,

--=20
Martin F. Krafft                Artificial Intelligence Laboratory
Ph.D. Student                   Department of Information Technology
Email: krafft@ailab.ch          University of Zurich
Tel: +41.(0)1.63-54323          Andreasstrasse 15, Office 2.20
http://ailab.ch/people/krafft   CH-8050 Zurich, Switzerland
=20
Invalid/expired PGP subkeys? Use subkeys.pgp.net as keyserver!
=20
one has to multiply thoughts to the point
where there aren't enough policemen to control them.
                                               -- stanislaw jerzey lec

--dDRMvlgZJXvWKvBx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE//V5nIgvIgzMMSnURAl50AJwNPkOgHoSqp2sY248h0nhdRwj34wCZAUE2
XLOu++1m61XMJC21Ho8fju8=
=Ckze
-----END PGP SIGNATURE-----

--dDRMvlgZJXvWKvBx--
