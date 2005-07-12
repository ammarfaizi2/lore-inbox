Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262381AbVGLU3q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262381AbVGLU3q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 16:29:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262385AbVGLU3f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 16:29:35 -0400
Received: from damned.travellingkiwi.com ([81.6.239.220]:14426 "EHLO
	ballbreaker.travellingkiwi.com") by vger.kernel.org with ESMTP
	id S262381AbVGLU2F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 16:28:05 -0400
Message-ID: <42D3FDF5.4090501@travellingkiwi.com>
Date: Tue, 12 Jul 2005 18:29:25 +0100
From: Hamish Marson <hamish@travellingkiwi.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: SysKonnect ethernet support for Asus A8VE Deluxe Motherboard? 
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Hi all.

I just installed Gentoo distribution on a new PC for a friend who's
new to Linux, and discovered that although SysKonnect kindly provide
full source code drivers for their various products on their website,
that even the latest released kernel sources (i.e. 2.6.12) still don't
support the device on this motherboard (Along with a whole host of
other PCI id's that appear in the syskonnect sources).

Although it's easy enough when you fully understand what's hapening,
it a little disconcerting for the newbie user (Which my friend is)
when confronted by booting their new PC & discovereing the Linux
doesn't support their onboard ethernet card...

I've logged a bug on gentoo.org about it, but thought I'd ask, if
there's any reason that the syskonnect (sk98lin) drivers are so back
leve in the kernel sources when syskonnect seem to have published the
drivers for so many more of their devices in source...

TIA

Hamish.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFC0/30/3QXwQQkZYwRAjTrAJ4lbhuRyPyRnbw0V9GSZcdhXsTydgCggAwz
uss02KaVi1eVRyQLWdTZ0pI=
=iKsm
-----END PGP SIGNATURE-----

