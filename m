Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268274AbUJJMV5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268274AbUJJMV5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Oct 2004 08:21:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268271AbUJJMV5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Oct 2004 08:21:57 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:23236 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S268275AbUJJMVI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Oct 2004 08:21:08 -0400
Message-ID: <4169293B.3020502@comcast.net>
Date: Sun, 10 Oct 2004 08:21:15 -0400
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20041001)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sven-Thorsten Dietrich <sdietrich@mvista.com>
CC: linux-kernel@vger.kernel.org,
       Alexander Batyrshin <abatyrshin@ru.mvista.com>,
       "Amakarov@Ru. Mvista. Com" <amakarov@ru.mvista.com>,
       Daniel Walker <dwalker@mvista.com>,
       "Eugeny S. Mints" <emints@ru.mvista.com>,
       "Ext-Rt-Dev@Mvista. Com" <ext-rt-dev@mvista.com>,
       New Zhang Haitao <hzhang@ch.mvista.com>,
       "Yyang@Ch. Mvista. Com" <yyang@ch.mvista.com>
Subject: Re: [ANNOUNCE] Linux 2.6 Real Time Kernel
References: <41677E4D.1030403@mvista.com>
In-Reply-To: <41677E4D.1030403@mvista.com>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Sven-Thorsten Dietrich wrote:
|
| Announcing the availability of prototype real-time (RT)
| enhancements to the Linux 2.6 kernel.
|
| We will submit 3 additional emails following this one, containing
| the remaining 3 patches (of 4) inline, with their descriptions.
|
| Download:
|
| Patches against the Linux-2.6.9-rc3 kernel are available at:
|
| ftp://source.mvista.com/pub/realtime/Linux-2.6.9-rc3-RT_irqthreads.patch
| ftp://source.mvista.com/pub/realtime/Linux-2.6.9-rc3-RT_mutex.patch
| ftp://source.mvista.com/pub/realtime/Linux-2.6.9-rc3-RT_spinlock1.patch
| ftp://source.mvista.com/pub/realtime/Linux-2.6.9-rc3-RT_spinlock2.patch
|
| The patches are to be applied to the linux-2.6.9-rc3 kernel in the
| order listed above.

Does any of this 'work' on x86_64 yet?  I heard that Ingo's voluntary
pre-empt was x86 only and didn't work on amd64; this stuff's kinda new,
does it work outside x86 yet?

I'd like to see what these kinds of things do.  :)

[...]

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBaSk6hDd4aOud5P8RAotcAJ9GgA3P1mAG/CpdlJDknGK6zwA92QCePZi4
AyNDvW6urtDNdvJAPDMZZfk=
=gVeZ
-----END PGP SIGNATURE-----
