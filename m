Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269019AbUHMHnl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269019AbUHMHnl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 03:43:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269020AbUHMHnl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 03:43:41 -0400
Received: from mx1.redhat.com ([66.187.233.31]:41619 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S269019AbUHMHni (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 03:43:38 -0400
Subject: Re: SG_IO and security
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Jens Axboe <axboe@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Alan Cox <alan@www.pagan.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040813065902.GB2321@suse.de>
References: <1092313030.21978.34.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0408120929360.1839@ppc970.osdl.org>
	 <Pine.LNX.4.58.0408120943210.1839@ppc970.osdl.org>
	 <1092341803.22458.37.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0408121705050.1839@ppc970.osdl.org>
	 <20040813065902.GB2321@suse.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-dwJ8T2pE/L+sxvZ0c0mw"
Organization: Red Hat UK
Message-Id: <1092383006.2813.0.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 13 Aug 2004 09:43:27 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-dwJ8T2pE/L+sxvZ0c0mw
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> While that does make sense, it would be more code to fold them together
> than what is currently there. SCSI_IOCTL_SEND_COMMAND is really
> horrible, the person inventing that API should be subject to daily
> public ridicule.

sounds like deprecation of this interface should start (I suspect this
one will need ample notice of that so the sooner we do .... )

--=-dwJ8T2pE/L+sxvZ0c0mw
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBHHEexULwo51rQBIRAkfyAKCqPlRIlOflMmJrhfq7CMOWQbgh8gCeKsRs
pNWaVqBQwcN1QhBOZfwewdk=
=1b1d
-----END PGP SIGNATURE-----

--=-dwJ8T2pE/L+sxvZ0c0mw--

