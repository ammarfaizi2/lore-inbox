Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129652AbRB0RWu>; Tue, 27 Feb 2001 12:22:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129639AbRB0RWk>; Tue, 27 Feb 2001 12:22:40 -0500
Received: from mask.uits.indiana.edu ([129.79.6.184]:45584 "EHLO
	mask.uits.indiana.edu") by vger.kernel.org with ESMTP
	id <S129652AbRB0RWZ>; Tue, 27 Feb 2001 12:22:25 -0500
Date: Tue, 27 Feb 2001 12:22:23 -0500
To: linux-kernel@vger.kernel.org
Subject: Consistent hang in 2.4.2 (Screen blanking?)
Message-ID: <20010227122223.A415@indiana.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zYM0uCDKw75PZbzx"
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
From: "Scott G. Miller" <scgmille@indiana.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I'm running 2.4.2 i686 SMP, and I get a consistent (weird) hang at about
10 minutes of inactivity (right after the screen blank?).  Monitor
indicates video card producing a signal, but no key/mouse activity awakens
system.  Caps lock etc don't function, neither does Magic SysRq.  Requires
hard reset.

I thought it might be APM or ACPI, so I disabled them, but the problem
persists.  I can give you a .config if necessary, but don't want to post
here, obviously.  Any ideas?

	Scott


--zYM0uCDKw75PZbzx
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6m+JPr9IW4v3mHtQRAtcoAJ91QwYVW1UHWMHgMd8AyFmcMwyCZACZAY52
0q+f3tJrRdvQEV6nTR4CXOA=
=8vW2
-----END PGP SIGNATURE-----

--zYM0uCDKw75PZbzx--
