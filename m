Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267416AbUGNPvl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267416AbUGNPvl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 11:51:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267419AbUGNPvl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 11:51:41 -0400
Received: from mout1.freenet.de ([194.97.50.132]:908 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id S267416AbUGNPvh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 11:51:37 -0400
From: Michael Buesch <mbuesch@freenet.de>
To: William Stearns <wstearns@pobox.com>
Subject: Re: [Q] don't allow tmpfs to page out
Date: Wed, 14 Jul 2004 17:51:11 +0200
User-Agent: KMail/1.6.2
References: <200407141654.31817.mbuesch@freenet.de> <Pine.LNX.4.58.0407141141350.6240@sparrow>
In-Reply-To: <Pine.LNX.4.58.0407141141350.6240@sparrow>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200407141751.14292.mbuesch@freenet.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Quoting William Stearns <wstearns@pobox.com>:
> Good afternoon, Michael,

Hi William,

> 	I suspect a regular ramdisk, as opposed to tmpfs, would do what 
> you want.

No, since a regular ramdisk is static in size.

> 	Cheers,
> 	- Bill

- -- 
Regards Michael Buesch  [ http://www.tuxsoft.de.vu ]


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA9VZvFGK1OIvVOP4RAku8AJ92P7fjMBBAkf36vKTlYQvH1XluzQCfQ573
LQyLzVpA5o5UfAH/3G2Aq3s=
=jzzh
-----END PGP SIGNATURE-----
