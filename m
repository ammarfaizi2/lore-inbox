Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751348AbWI2T0s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751348AbWI2T0s (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 15:26:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751343AbWI2T0s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 15:26:48 -0400
Received: from mail3.uklinux.net ([80.84.72.33]:6566 "EHLO mail3.uklinux.net")
	by vger.kernel.org with ESMTP id S1751356AbWI2T0r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 15:26:47 -0400
Date: Thu, 28 Sep 2006 20:19:46 +0100
To: Randy Dunlap <rdunlap@xenotime.net>
Cc: lkml <linux-kernel@vger.kernel.org>, roger@computer-surgery.co.uk
Subject: Re: fs/bio.c - Hardcoded sector size ?
Message-ID: <20060928191946.GC4759@julia.computer-surgery.co.uk>
References: <20060928182238.GA4759@julia.computer-surgery.co.uk> <20060929113814.db87b8d5.rdunlap@xenotime.net> <20060928185820.GB4759@julia.computer-surgery.co.uk> <20060929121157.0258883f.rdunlap@xenotime.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YZ5djTAD1cGYuMQK"
Content-Disposition: inline
In-Reply-To: <20060929121157.0258883f.rdunlap@xenotime.net>
X-GPG-Fingerprint: ADAD DF3A AE05 CA28 3BDB  D352 7E81 8852 817A FB7B
X-GPG-Key: 1024D/817AFB7B (wwwkeys.uk.pgp.net)
User-Agent: Mutt/1.5.13 (2006-08-11)
From: Roger Gammans <roger@computer-surgery.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 29, 2006 at 12:11:57PM -0700, Randy Dunlap wrote:
> I don't know if or where it is documented.

Well, I've spend a good chunk of time reading round this part of
the kernel's interfaces without spotting it so another note somewhere
can't help.

> You can submit a patch for it.
> If you don't, I'll put it in my todo queue.

If I find an approriate place to put such a note I'll add it and
submit a patch, but I'm not sure where to put it , atm.

Any suggestions?

TTFN
--=20
Roger.                          Home| http://www.sandman.uklinux.net/
Master of Peng Shui.      (Ancient oriental art of Penguin Arranging)
Work|Independent Sys Consultant | http://www.computer-surgery.co.uk/
So what are the eigenvalues and eigenvectors of 'The Matrix'? --anon

--YZ5djTAD1cGYuMQK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFHCBSTryqm47jHdMRAsCUAJ4jOMD14PtrtlSsRkr12MY5n7Yb2wCguY0G
jBAISViuZr04o+htbA+fSV4=
=jfkT
-----END PGP SIGNATURE-----

--YZ5djTAD1cGYuMQK--
