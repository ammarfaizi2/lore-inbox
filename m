Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261291AbULMRzR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261291AbULMRzR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 12:55:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261298AbULMRzR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 12:55:17 -0500
Received: from mout0.freenet.de ([194.97.50.131]:2204 "EHLO mout0.freenet.de")
	by vger.kernel.org with ESMTP id S261291AbULMRzK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 12:55:10 -0500
From: Michael Buesch <mbuesch@freenet.de>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: dynamic-hz
Date: Mon, 13 Dec 2004 18:53:40 +0100
User-Agent: KMail/1.7.1
References: <20041211142317.GF16322@dualathlon.random> <1102949565.2687.2.camel@localhost.localdomain> <20041213162355.E24748@flint.arm.linux.org.uk>
In-Reply-To: <20041213162355.E24748@flint.arm.linux.org.uk>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Stefan Seyfried <seife@suse.de>,
       Con Kolivas <kernel@kolivas.org>, Pavel Machek <pavel@suse.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrea Arcangeli <andrea@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1134658.ALeuCqehnc";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200412131853.47652.mbuesch@freenet.de>
X-Warning: freenet.de is listed at abuse.rfc-ignorant.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1134658.ALeuCqehnc
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Quoting Russell King <rmk+lkml@arm.linux.org.uk>:
> the system is idle.  So far, in all my Linux kernel experience, I've
> yet to see a kernel where it's possible to stay in the idle thread
> for more than half a second.  (The ARM kernels I run are always
> configured with IDLE LED support, so I can _see_ when it gets kicked
> out of the idle thread.)

I guess IDLE LED support is not in mainline kernel, is it?
Where can I get it?

=2D-=20
Regards Michael Buesch  [ http://www.tuxsoft.de.vu ]



--nextPart1134658.ALeuCqehnc
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBvdcrFGK1OIvVOP4RAiohAKCXCjppjRwS5GfBE5GrfaPGGtZ5JwCghadq
Ql9z7lk9aiVdry0N2sh+zFQ=
=e3/0
-----END PGP SIGNATURE-----

--nextPart1134658.ALeuCqehnc--
