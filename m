Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261595AbUAFI7r (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 03:59:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261567AbUAFI7q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 03:59:46 -0500
Received: from null.rsn.bth.se ([194.47.142.3]:64446 "EHLO null.rsn.bth.se")
	by vger.kernel.org with ESMTP id S261595AbUAFI7p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 03:59:45 -0500
Subject: Re: PPTP_CONNECTRACK_NAT for latest kernel?
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: Ed Weinberg <nylug@q5comm.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1073358444.22610.126.camel@ed.q>
References: <1073358444.22610.126.camel@ed.q>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-5kcQ0cd/a84p9/hfC/Bg"
Message-Id: <1073379580.31821.27.camel@tux.rsn.bth.se>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 06 Jan 2004 09:59:40 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-5kcQ0cd/a84p9/hfC/Bg
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2004-01-06 at 04:07, Ed Weinberg wrote:
> is there a PPTP_CONNECTRACK_NAT patch for the latest 2.4 kernel?  I have
> not found one later than 2.4.22 in CVS...unless I am looking in the
> wrong place.

Please download patch-o-matic from http://netfilter.org and read the
instructions. The pptp-conntrack-nat.patch in there should work against
2.4.24 and it has the latest bugfixes (note: do _not_ apply the patch
with the 'patch' command by hand, the 'runme' script does some other
magic as well)

--=20
/Martin

--=-5kcQ0cd/a84p9/hfC/Bg
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQA/+nj8Wm2vlfa207ERAmEaAJ97bh+VflxklNwR28xRjHbf9RKxewCeMaP/
S0u4y4wC5wOk+fL5zZ2ywl0=
=lMcF
-----END PGP SIGNATURE-----

--=-5kcQ0cd/a84p9/hfC/Bg--
