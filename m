Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261812AbUKUV0w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261812AbUKUV0w (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 16:26:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261813AbUKUV0w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 16:26:52 -0500
Received: from vsmtp1alice.tin.it ([212.216.176.144]:48312 "EHLO
	vsmtp1alice.tin.it") by vger.kernel.org with ESMTP id S261812AbUKUV0u
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 16:26:50 -0500
Date: Sun, 21 Nov 2004 23:37:25 +0100
From: Luca Risolia <luca.risolia@studio.unibo.it>
To: linux-kernel@vger.kernel.org
Cc: Shawn Starr <shawn.starr@rogers.com>
Subject: Re: new pwc driver for 2.6 - Merge into -mm?
Message-ID: <20041121223725.GA6336@studio.unibo.it>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sm4nu43k4a2Rpi4c"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> Is it possible the driver can be put into -mm for testing or are there (legal)
> issues that need to be addressed in any way?

The version of the driver in the -ac's tree is not ready yet.
The decompression has to go away from the kernel.

Regards,
	Luca Risolia

--sm4nu43k4a2Rpi4c
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFBoRilmdpdKvzmNaQRAsq+AKDln18NbYp3+Qo6MZgvbaQME75pAACeKk+D
T/O70E362iyd4wSJoZ/xjqQ=
=Q32C
-----END PGP SIGNATURE-----

--sm4nu43k4a2Rpi4c--
