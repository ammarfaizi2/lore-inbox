Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263185AbUDEVi2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 17:38:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263269AbUDEViT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 17:38:19 -0400
Received: from mout1.freenet.de ([194.97.50.132]:50871 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id S263185AbUDEVg2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 17:36:28 -0400
From: Michael Buesch <mbuesch@freenet.de>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: APIC error on CPU0
Date: Mon, 5 Apr 2004 23:35:59 +0200
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Message-Id: <200404052336.23585.mbuesch@freenet.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

What does this kernel message mean?

Apr  5 23:16:20 lfs kernel: APIC error on CPU0: 60(60)
Apr  5 23:16:31 lfs kernel: APIC error on CPU0: 60(60)

kernel is 2.6.5 with reiser4 patch.
I can post .config if needed, but I don't want to abuse
the list, if nobody is interrested in my configuration.

Thanks.

- -- 
Regards Michael Buesch  [ http://www.tuxsoft.de.vu ]

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAcdFWFGK1OIvVOP4RAg9JAJkBImV4TpaExUhg/AfATSzkENKxLwCdHU5a
fY7cKIaNDVYbRasKIgQODX8=
=mLkL
-----END PGP SIGNATURE-----
