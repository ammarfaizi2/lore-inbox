Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263366AbVCKPNd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263366AbVCKPNd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 10:13:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263364AbVCKPNc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 10:13:32 -0500
Received: from ns1.g-housing.de ([62.75.136.201]:51342 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S263350AbVCKPLU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 10:11:20 -0500
Message-ID: <4231B4E9.3080005@g-house.de>
Date: Fri, 11 Mar 2005 16:10:33 +0100
From: Christian Kujau <evil@g-house.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050212)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
CC: Coywolf Qi Hunt <coywolf@gmail.com>
Subject: Re: oom with 2.6.11
References: <422DC2F1.7020802@g-house.de> <2cd57c9005031102595dfe78e6@mail.gmail.com>
In-Reply-To: <2cd57c9005031102595dfe78e6@mail.gmail.com>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Coywolf Qi Hunt wrote:
> In file mm/oom_kill.c, uncomment line 24: /* #define DEBUG */. 
> And next time when oom happens again, we'll see the badness.

oh, good hint. will do this before the next reboot (in a few hours i guess)


thanks,
Christian.

- --
BOFH excuse #134:

because of network lag due to too many people playing deathmatch
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCMbTj+A7rjkF8z0wRAmdAAJ4sCIaUqZaKn7gGtkpN7Wb47acFiACgrOSe
DpT3tE1/4zfPIDueDwBMhDU=
=o6Lr
-----END PGP SIGNATURE-----

-- 
BOFH excuse #37:

heavy gravity fluctuation, move computer to floor rapidly
