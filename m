Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262072AbUKKAlP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262072AbUKKAlP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 19:41:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262151AbUKKAlP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 19:41:15 -0500
Received: from ns1.g-housing.de ([62.75.136.201]:20127 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S262072AbUKKAlL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 19:41:11 -0500
Message-ID: <4192B523.9090507@g-house.de>
Date: Thu, 11 Nov 2004 01:41:07 +0100
From: Christian Kujau <evil@g-house.de>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040926)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
CC: sfrench@samba.org
Subject: Oops with CIFS (2.6.10-rc1-BK)
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

hi,

using smb mounts fairly seldom i only mount them with -t smb. today i
mounted the share with -t cifs. the share was mounted successfully, i
could use it and then the oops occured. i could not reproduce it up to now
but i thought perhaps the output could be useful somehow. here it goes:

http://nerdbynature.de/bits/prinz/cifs/dmesg.txt
http://nerdbynature.de/bits/prinz/cifs/config.txt

thanks,
Christian.
- --
BOFH excuse #108:

The air conditioning water supply pipe ruptured over the machine room
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBkrUj+A7rjkF8z0wRAihRAJ9sewwky182IxXaEF8tWclKaIdZ8wCg0Fvb
2izQr8cfCTEfwnD3nVe1BCE=
=fehY
-----END PGP SIGNATURE-----
