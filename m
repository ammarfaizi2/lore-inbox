Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135763AbRAGGCn>; Sun, 7 Jan 2001 01:02:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135766AbRAGGCd>; Sun, 7 Jan 2001 01:02:33 -0500
Received: from vitelus.com ([64.81.36.147]:19468 "EHLO vitelus.com")
	by vger.kernel.org with ESMTP id <S135763AbRAGGCT>;
	Sun, 7 Jan 2001 01:02:19 -0500
Date: Sat, 6 Jan 2001 22:02:14 -0800
From: Aaron Lehmann <aaronl@vitelus.com>
To: "D. Jeff Dionne" <jeff@lineo.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: uClinux 2.4.0.0pre0 released.
Message-ID: <20010106220214.C7874@vitelus.com>
In-Reply-To: <Pine.LNX.4.21.0101060009550.10613-100000@mail.lineo.ca>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NU0Ex4SbNnrxsi6C"
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <Pine.LNX.4.21.0101060009550.10613-100000@mail.lineo.ca>; from jeff@lineo.ca on Sat, Jan 06, 2001 at 12:25:36AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--NU0Ex4SbNnrxsi6C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jan 06, 2001 at 12:25:36AM -0500, D. Jeff Dionne wrote:
> uClinux 2.4.0.0pre0 is out.  It is on www.uclinux.org and cvs.uclinux.org

I don't think this matters much, but I noticed that several of the
features available in the kernel configuration aren't relevent to 68k.
For example, in arch/m68knommu/config.in:

bool 'SGI Visual Workstation support' CONFIG_VISWS
bool 'PCI support' CONFIG_PCI
bool 'MCA support' CONFIG_MCA
bool 'Power Management support' CONFIG_PM


--NU0Ex4SbNnrxsi6C
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6WAZmdtqQf66JWJkRAiwhAKCJ1HddXgOcz8i3wRiKG8l/IdnUTgCgtMcO
6Lfh0/r3EoLCPAmCOFl7vUs=
=Ztyo
-----END PGP SIGNATURE-----

--NU0Ex4SbNnrxsi6C--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
