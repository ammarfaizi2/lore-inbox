Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277798AbRKNVMV>; Wed, 14 Nov 2001 16:12:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277738AbRKNVML>; Wed, 14 Nov 2001 16:12:11 -0500
Received: from ns.snowman.net ([63.80.4.34]:40715 "EHLO ns.snowman.net")
	by vger.kernel.org with ESMTP id <S277782AbRKNVMH>;
	Wed, 14 Nov 2001 16:12:07 -0500
Date: Wed, 14 Nov 2001 16:10:04 -0500
From: Stephen Frost <sfrost@snowman.net>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Alastair Stevens <alastair.stevens@mrc-bsu.cam.ac.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: Athlon SMP blues - kernels 2.4.[9 13 15-pre4]
Message-ID: <20011114161004.P481@ns>
Mail-Followup-To: Herbert Xu <herbert@gondor.apana.org.au>,
	Alastair Stevens <alastair.stevens@mrc-bsu.cam.ac.uk>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.33.0111141421230.14971-100000@gurney> <E1646xi-00015T-00@gondolin.me.apana.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="buDNgeHiu+HCsDEc"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E1646xi-00015T-00@gondolin.me.apana.org.au>; from herbert@gondor.apana.org.au on Thu, Nov 15, 2001 at 07:48:46AM +1100
X-Editor: Vim http://www.vim.org/
X-Info: http://www.snowman.net
X-Operating-System: Linux/2.2.16 (i686)
X-Uptime: 4:09pm  up 7 days, 18:32, 13 users,  load average: 1.00, 1.02, 1.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--buDNgeHiu+HCsDEc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Herbert Xu (herbert@gondor.apana.org.au) wrote:
> Alastair Stevens <alastair.stevens@mrc-bsu.cam.ac.uk> wrote:
>=20
> > I installed Red Hat 7.2 and the machine boots fine, using SMP or UP
> > kernels (Red Hat 2.4.9-7), but totally HANGS at the login prompt. Can't
> > type, can't reboot, can't do anything. Single user mode _does_ let me
> > in, however, and this is the only progress so far.
>=20
> Try plugging in a mouse or stop running gpm.

	Yeah, and make sure that silly "PCI Interrupts in MP table" or
	whatever in your BIOS is on or you may have other problems.

		Stephen

--buDNgeHiu+HCsDEc
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE78t2srzgMPqB3kigRAsotAJsEnYx5lWJG0sn/gr8rInQDIbkGDACfWYYH
pDS8LBL+18VvDymtAufx0D0=
=5oy8
-----END PGP SIGNATURE-----

--buDNgeHiu+HCsDEc--
