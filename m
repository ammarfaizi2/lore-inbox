Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265383AbUAMR4u (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 12:56:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265389AbUAMR4t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 12:56:49 -0500
Received: from mail.actcom.net.il ([192.114.47.15]:38612 "EHLO
	smtp2.actcom.co.il") by vger.kernel.org with ESMTP id S265383AbUAMR4q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 12:56:46 -0500
Date: Tue, 13 Jan 2004 19:56:38 +0200
From: Muli Ben-Yehuda <mulix@mulix.org>
To: Gene Heskett <gene.heskett@verizon.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ANother debugging Q
Message-ID: <20040113175638.GG20763@actcom.co.il>
References: <200401131243.27614.gene.heskett@verizon.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aYDVKSzuImP48n7V"
Content-Disposition: inline
In-Reply-To: <200401131243.27614.gene.heskett@verizon.net>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--aYDVKSzuImP48n7V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 13, 2004 at 12:43:27PM -0500, Gene Heskett wrote:

> Is there a way to make the app itself inherit the strace so that its=20
> errors can be located/defined and fixed?

Short answer: man strace.=20
Long answer: strace -f (or -ff).

Cheers,
Muli=20
--=20
Muli Ben-Yehuda
http://www.mulix.org | http://mulix.livejournal.com/

"the nucleus of linux oscillates my world" - gccbot@#offtopic


--aYDVKSzuImP48n7V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFABDFVKRs727/VN8sRArI1AJ9M4XnP6mR0pUiICmuknrT9qkAlOwCeLPLP
TEQSPnUp0N7d/YiEFl5wOjo=
=21h2
-----END PGP SIGNATURE-----

--aYDVKSzuImP48n7V--
