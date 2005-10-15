Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751164AbVJOPFY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751164AbVJOPFY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Oct 2005 11:05:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751165AbVJOPFY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Oct 2005 11:05:24 -0400
Received: from ns2.g-housing.de ([81.169.133.75]:26292 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S1751164AbVJOPFX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Oct 2005 11:05:23 -0400
Message-ID: <43511AB1.3010608@g-house.de>
Date: Sat, 15 Oct 2005 17:05:21 +0200
From: Christian Kujau <evil@g-house.de>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051010)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
CC: Nico Schottelius <nico-kernel@schottelius.org>
Subject: Re: Some problems with 2.6.13.4
References: <20051015122131.GG8609@schottelius.org>
In-Reply-To: <20051015122131.GG8609@schottelius.org>
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: RIPEMD160

Nico Schottelius schrieb:
> The kernel configurations are used from the versions before, with running
> make oldconfig before.

so, these machines were running fine with 2.6.13.3 or .2 and stopped
working with 2.6.13.4? if yes, then perhaps you can narrow it down to one
of the changes in patch-2.6.13.3-4.gz or patch-2.6.13.2-3.gz

(from http://www.kernel.org/pub/linux/kernel/v2.6/incr/)

- --
BOFH excuse #102:

Power company testing new voltage spike (creation) equipment
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDURqx+A7rjkF8z0wRAzFvAJ9wwu3+Bc7pJK0XozM8cmPEPxv7kQCg1N8N
+1dujn/0Wb6imBoRd60lZ80=
=C8UB
-----END PGP SIGNATURE-----
