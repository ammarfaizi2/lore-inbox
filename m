Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261828AbVDOOy0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261828AbVDOOy0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 10:54:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261826AbVDOOyZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 10:54:25 -0400
Received: from ns1.g-housing.de ([62.75.136.201]:56796 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S261828AbVDOOyR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 10:54:17 -0400
Message-ID: <425FD593.7080402@g-house.de>
Date: Fri, 15 Apr 2005 16:54:11 +0200
From: Christian Kujau <evil@g-house.de>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050326)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Takashi Iwai <tiwai@suse.de>
CC: linux-kernel <linux-kernel@vger.kernel.org>,
       alsa-devel@lists.sourceforge.net, juhl-lkml@dif.dk
Subject: Re: ALSA Oops (triggered by xmms)
References: <425EFB32.2010000@g-house.de>	<1113521720.19830.35.camel@mindpipe> <s5hbr8ge7yi.wl@alsa2.suse.de>
In-Reply-To: <s5hbr8ge7yi.wl@alsa2.suse.de>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Takashi Iwai wrote:
> 
> Also, the latest CVS alsa-lib checks the timer protocol version to
> avoid this Oops with the older kenel.  1.0.9-rc3 is planned to be
> released soon, so wait for a moment...

um, i'll wait for the next release as i don't track alsa-cvs. but i do
track 2.6-BK (again) and the oops is gone ;-)


Jesper Juhl wrote:
>> yeah, but the oops doesn't wrap at 80 chars itsself and often oopses
>> are hardly readable inline.
>
> I would still suggest including the info inline and then if you think
> it's needed /also/ provide the link you did - then you've covered all
> bases :)

will do, next time 8-)


thanks to all involved for all your replies,
Christian.
- --
BOFH excuse #388:

Bad user karma.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCX9WT+A7rjkF8z0wRAlp2AJ0doKLm4OsK2i8nNx6uezrcfPF15QCeNkuO
eVCEuP0U5LrUOToHXEb6cBs=
=Feow
-----END PGP SIGNATURE-----
