Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263744AbTDNWlK (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 18:41:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263968AbTDNWlK (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 18:41:10 -0400
Received: from iucha.net ([209.98.146.184]:48499 "EHLO mail.iucha.net")
	by vger.kernel.org with ESMTP id S263744AbTDNWlI (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Apr 2003 18:41:08 -0400
Date: Mon, 14 Apr 2003 17:52:58 -0500
To: Greg KH <greg@kroah.com>
Cc: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: oops in bus_add_driver with 2.5.67-bk4
Message-ID: <20030414225258.GE20291@iucha.net>
References: <20030412215544.GA1663@iucha.net> <20030414183129.GB4306@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9crTWz/Z+Zyzu20v"
Content-Disposition: inline
In-Reply-To: <20030414183129.GB4306@kroah.com>
X-message-flag: Outlook: Where do you want [your files] to go today?
X-gpg-key: http://iucha.net/florin_iucha.gpg
X-gpg-fingerprint: 41A9 2BDE 8E11 F1C5 87A6  03EE 34B3 E075 3B90 DFE4
User-Agent: Mutt/1.5.3i
From: florin@iucha.net (Florin Iucha)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--9crTWz/Z+Zyzu20v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 14, 2003 at 11:31:29AM -0700, Greg KH wrote:
> Try the following patch from David Miller.

I have verified the patch works, using -bk5.

Cheers,
florin

--=20

"NT is to UNIX what a doughnut is to a particle accelerator."

--9crTWz/Z+Zyzu20v
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+mzvKNLPgdTuQ3+QRAhSeAJ9rVnMXrGyY9AL5BXGwU5mJmSEMsQCgkfXz
PznpDnbBj5pw5TEFpna+SxI=
=ALNI
-----END PGP SIGNATURE-----

--9crTWz/Z+Zyzu20v--
