Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261439AbUCKP5I (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 10:57:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261437AbUCKP5I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 10:57:08 -0500
Received: from ns1.g-housing.de ([62.75.136.201]:3534 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S261439AbUCKP4s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 10:56:48 -0500
Message-ID: <40508C31.5040505@g-house.de>
Date: Thu, 11 Mar 2004 16:56:33 +0100
From: Christian Kujau <evil@g-house.de>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040306)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kalle Lundgren <kalle@netzorz.se>
CC: linux-kernel@vger.kernel.org
Subject: Re: Spelling Error.
References: <20040311092851.6CE3A15646@texi.yes.nu>
In-Reply-To: <20040311092851.6CE3A15646@texi.yes.nu>
X-Enigmail-Version: 0.83.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------030203080400010601080007"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030203080400010601080007
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

oh well, arch.i386.Kconfig-defalut.diff was diff'ed vice-versa, here is
it again.

- --
BOFH excuse #310:

asynchronous inode failure
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFAUIwx+A7rjkF8z0wRAgBBAJ0SND4hNMoNzd2clnLAJyOJOqOAmQCePkEn
9G3pQaPGX1xT2CCHjAEEdv8=
=ZRoB
-----END PGP SIGNATURE-----

--------------030203080400010601080007
Content-Type: text/plain;
 name="arch.i386.Kconfig-defalut.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="arch.i386.Kconfig-defalut.diff"

--- linux-2.6/arch/i386/Kconfig.orig	2004-03-11 16:54:37.000000000 +0100
+++ linux-2.6/arch/i386/Kconfig	2004-03-11 16:54:51.000000000 +0100
@@ -831,7 +831,7 @@
 	depends on SMP && X86_IO_APIC
 	default y
 	help
- 	  The defalut yes will allow the kernel to do irq load balancing.
+ 	  The default yes will allow the kernel to do irq load balancing.
 	  Saying no will keep the kernel from doing irq load balancing.
 
 config HAVE_DEC_LOCK

--------------030203080400010601080007--
