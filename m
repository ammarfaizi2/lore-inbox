Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262963AbUKTOps@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262963AbUKTOps (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 09:45:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262969AbUKTOps
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 09:45:48 -0500
Received: from ns.schottelius.org ([213.146.113.242]:21633 "HELO
	scice.schottelius.org") by vger.kernel.org with SMTP
	id S262963AbUKTOpk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 09:45:40 -0500
Date: Sat, 20 Nov 2004 15:46:17 +0100
From: Nico Schottelius <nico-kernel@schottelius.org>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: ITE8212 - iteraid inclusion | general ide raid question
Message-ID: <20041120144617.GB2286@schottelius.org>
Mail-Followup-To: Nico Schottelius <nico-kernel@schottelius.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eJnRUKwClWJh1Khz"
Content-Disposition: inline
User-Agent: echo $message | gpg -e $sender  -s | netcat mailhost 25
X-Linux-Info: http://linux.schottelius.org/
X-Operating-System: Linux 2.6.9-cLinux
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--eJnRUKwClWJh1Khz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello!

I am wondering, whether support for the ide atapi (raid/normal)
controllers will be merged into 2.6?

ITE offers GPLed source code from their website, so their should be no
problem imho.

Another question: Why are the IDE Raids listed below
SCSI support in menuconfig? Doesn't it make sense to
open a new point 'IDE Raid Controller' or add them to
the general ide section?

And why are ide raid controllers using scsi namespace /dev/sd*?

I am a bit confused about that.

Thanks for any information,

Nico

--eJnRUKwClWJh1Khz
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iQIVAwUBQZ9YtrOTBMvCUbrlAQKL3g//ckNH/FWh4T7vuREmwBuIF3yS88M3SSM7
dk7hd/gXueSBUY/uW3gxsH6M3exgaadpJWVSfYNq+cgiAGL5goOCbUv/b6INQL9N
KtMP8t5c8TWaUTsxhbSu7XijjEQjyxpxxQBbku6i7pAbKzozaK7nh+GeaY35aE+h
sRvxRQugntTxcTF6ucVAyW0tPNaGRLSaUfn7MWh6eZOGO8AYTy3mCRuFslUIfPPq
vb5YA1hfoXt6vqBmuZTXNfO7nfw+k3BsTijw6S5b8x+OwbyaL638HqkZzGY+csD5
k3ZUf6DN2iOFuqT4291EHM8zf9Y65MDA52fMFKi2iSbAXcJPwW7TS7dYEbL4d2is
AWlr9vMBDzyCVyMyv9wX9BHVbMpRMy/xD+zXMDwxl/DB10CoCdHj5hZpSz9ZAgsL
WlV6wABarA1CidxCPV+79ae94+OrFQZQg2MvqhKfd4XnoKZx52SH/n1dpAMztB5Z
HvWRIhOLVZnR9I/vkwUtKs4BE8nu3yswzVYemXOARxJRMJfIT1U0ZN1TNY5PeqTc
RuxWKrHgzfCXDlhJQLy0sxCEodQCuZDyApfhxdmmcMIjzvsw75rKkJeVrBcQdHah
mdyvitW3x3zysbfZ4ZwdcIMoRDEMU56MYYcYDwdzlpo1rf6MXaxsfB/HAFV1dulf
7o3zB3k+a64=
=x+WY
-----END PGP SIGNATURE-----

--eJnRUKwClWJh1Khz--
