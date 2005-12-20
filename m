Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750803AbVLTRTF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750803AbVLTRTF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 12:19:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750715AbVLTRTE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 12:19:04 -0500
Received: from ns2.g-housing.de ([81.169.133.75]:45496 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S1750803AbVLTRTE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 12:19:04 -0500
Message-ID: <43A83D03.9070705@g-house.de>
Date: Tue, 20 Dec 2005 18:18:59 +0100
From: Christian Kujau <evil@g-house.de>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Doug Thompson <norsk5@yahoo.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH]  EDAC with sysfs interface added
References: <20051220170542.60920.qmail@web50114.mail.yahoo.com>
In-Reply-To: <20051220170542.60920.qmail@web50114.mail.yahoo.com>
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: RIPEMD160

Doug Thompson schrieb:
> You reminded me that I failed to put in the summary that whitelist/blacklist ARE in this patch as
> well as the sysfs. Apply the patch, and set your white or black list with the vendor_id:device_id
> that you desire. This needs to be done after bootup.

will do, thanks!

Christian.
- --
BOFH excuse #45:

virus attack, luser responsible
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDqD0D+A7rjkF8z0wRA2lRAJ4wmCbVIn6dIkLsvAfbrwEnX1ug6gCfdEwt
AFoOtOZsfY0gFQrya9dUrvk=
=7rf7
-----END PGP SIGNATURE-----
