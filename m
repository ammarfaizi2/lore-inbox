Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267195AbUHYMGj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267195AbUHYMGj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 08:06:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267199AbUHYMGj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 08:06:39 -0400
Received: from ns1.g-housing.de ([62.75.136.201]:28049 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S267195AbUHYMGF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 08:06:05 -0400
Message-ID: <412C80A0.6030206@g-house.de>
Date: Wed, 25 Aug 2004 14:05:52 +0200
From: Christian Kujau <evil@g-house.de>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040805)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
CC: Larry McVoy <lm@bitmover.com>
Subject: Re: new bk version does not pull?
References: <4127C733.90808@g-house.de> <20040822023025.GA4579@work.bitmover.com>
In-Reply-To: <20040822023025.GA4579@work.bitmover.com>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Larry McVoy wrote:
>>a couple of days ago i updated to the latest bk version [1] when i
>>noticed today, that my repositories are not updated any more:
>>
>>evil@sheep:/usr/src/linux-2.6-BK$ bk parent
>>Parent repository is http://linux.bkbits.net/linux-2.5
>>evil@sheep:/usr/src/linux-2.6-BK$ bk pull
>>Pull http://linux.bkbits.net/linux-2.5
>>  -> file://usr/src/linux-2.6-BK
>>Nothing to pull.
>
>
> Linus is on vacation.

ah, ok. thanks. it's pulling again and nothing wrong with shiny new bk
version :-)

Christian.
- --
BOFH excuse #294:

PCMCIA slave driver
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBLICg+A7rjkF8z0wRAuoYAKCKzHj3sgVb/tuFh9g0JPAN/k2SGQCdHpTE
yJywt1H7Hq3sC9iStrVOr1c=
=Okv4
-----END PGP SIGNATURE-----
