Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263085AbUFBOWH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263085AbUFBOWH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 10:22:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262974AbUFBOWH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 10:22:07 -0400
Received: from ns1.g-housing.de ([62.75.136.201]:11140 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S262972AbUFBOVk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 10:21:40 -0400
Message-ID: <40BDE26A.1090708@g-house.de>
Date: Wed, 02 Jun 2004 16:21:30 +0200
From: Christian Kujau <evil@g-house.de>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040528)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Mikael Pettersson <mikpe@csd.uu.se>
Subject: Re: unable to compile 2.4 with gcc-3.4.0
References: <200405301314.i4UDEXW8005730@harpo.it.uu.se>
In-Reply-To: <200405301314.i4UDEXW8005730@harpo.it.uu.se>
X-Enigmail-Version: 0.83.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Mikael Pettersson wrote:
| On Sun, 30 May 2004 12:49:51 +0200, Christian Kujau wrote:
|
|>reading the thread "Recommended compiler version" i don't know if it
|>states wether this is a known issue or not, so here, and for the record:
|>
|>i'm unable to compile a recent 2.4 kernel (BK) with gcc-3.4.0.
|
|
| This has been discussed on LKML recently. Get
|
http://www.csd.uu.se/~mikpe/linux/patches/2.4/patch-gcc340-fixes-2.4.27-pre3
| and try again.

[ *really* sorry for the delay ]

yes, it seems to be fixed now and it's copiling now.


Thank you,
Christian.
- --
BOFH excuse #377:

Someone hooked the twisted pair wires into the answering machine.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFAveJq+A7rjkF8z0wRAgpoAKCW26P8wxHV/uZaggYsJC1U3FeLsQCgkGSR
Deht/5OmJfJshzuUlwTE9aw=
=1rsf
-----END PGP SIGNATURE-----
