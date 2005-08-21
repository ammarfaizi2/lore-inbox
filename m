Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750957AbVHULbK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750957AbVHULbK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Aug 2005 07:31:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750959AbVHULbK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Aug 2005 07:31:10 -0400
Received: from mtaout3.barak.net.il ([212.150.49.173]:14177 "EHLO
	mtaout3.barak.net.il") by vger.kernel.org with ESMTP
	id S1750957AbVHULbJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Aug 2005 07:31:09 -0400
Date: Sun, 21 Aug 2005 14:30:56 +0300
From: Leonid Podolny <leonidp.lkml@gmail.com>
Subject: x86_64 vm design
To: linux-kernel@vger.kernel.org
Message-id: <430865F0.40307@gmail.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
X-Enigmail-Version: 0.91.0.0
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,
I'm trying to figure out the virtual memory manager implementation at
x86_64. I'm relatively a newbie in this part of kernel code, so I'd
rather read some document with general principles of x86_64
implementation before reading the code. Does such document (Wiki page or
mayble lkml posting I missed) exist or am I being too naive?
- --




- ------------------------------------------------------------------------
 Leonid Podolny       |   /"\
                      |   \ /     ASCII Ribbon Campaign
 leonidp(at)gmail.com |    x      Against HTML Mail
 +972-54-5696948      |   / \
- ------------------------------------------------------------------------
PGP fingerprint:      51B2 F1DB 485E 2C48 2E17  94D1 7EC4 E524 B156 B9F0
PGP key:    http://pgp.mit.edu:11371/pks/lookup?op=get&search=0xB156B9F0
- ------------------------------------------------------------------------
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFDCGXwfsTlJLFWufARAhCJAJ9ta+ieQFWSHYerNSUuh2brqQTQ/gCfT5cu
hmZ9bCMcOV0/t7ky+RCZs7Y=
=EkSE
-----END PGP SIGNATURE-----
