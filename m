Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262592AbUJ1A0T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262592AbUJ1A0T (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 20:26:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262576AbUJ1AZM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 20:25:12 -0400
Received: from ns1.g-housing.de ([62.75.136.201]:42474 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S262688AbUJ1ARp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 20:17:45 -0400
Message-ID: <41803AA3.3020500@g-house.de>
Date: Thu, 28 Oct 2004 02:17:39 +0200
From: Christian Kujau <evil@g-house.de>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040926)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Oops in 2.6.10-rc1 (upon loading sound?)
References: <417F9961.70306@g-house.de>
In-Reply-To: <417F9961.70306@g-house.de>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Christian Kujau wrote:
> hi,
> 
> yesterday i was updating to recent 2.6.10-rc1-BK and booting gives:

updating to an even more recent (read: updated now) does not help and the
problem is really triggered when loading snd_ens1371. well, the only
"problem" is the oops and i have no sound :-(

just strange that nobody else cries out loud. or am i just lacking enough
information? ok, this is debian/unstable (i386), gcc3.4.2, libc2.3.2, pls
tell me if you need more information.

thank you,
Christian.
- --
BOFH excuse #404:

Sysadmin accidentally destroyed pager with a large hammer.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBgDqj+A7rjkF8z0wRAqoQAJ4l3MrUrx/1ZsWB4lHCdkGGyNCCcgCbB7l1
pHcIS9yABHYcDk2Ym5l83MU=
=CCbA
-----END PGP SIGNATURE-----
