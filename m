Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262687AbTENBT1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 21:19:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262329AbTENBT1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 21:19:27 -0400
Received: from smtp1.cwidc.net ([154.33.63.111]:9697 "EHLO smtp1.cwidc.net")
	by vger.kernel.org with ESMTP id S262687AbTENBTZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 21:19:25 -0400
Message-ID: <3EC19C9B.3030609@tequila.co.jp>
Date: Wed, 14 May 2003 10:32:11 +0900
From: Clemens Schwaighofer <cs@tequila.co.jp>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.4b) Gecko/20030506
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rick Lindsley <ricklind@us.ibm.com>
CC: "Randy.Dunlap" <rddunlap@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: Missing disc io stats in /proc/stat in 2.5.69?
References: <200305132110.h4DLAkT02067@owlet.beaverton.ibm.com>
In-Reply-To: <200305132110.h4DLAkT02067@owlet.beaverton.ibm.com>
X-Enigmail-Version: 0.75.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Rick Lindsley wrote:

I didn't know they appeared in the sysfs, I actually paid no attention
to it, nor did I know it appeared :) or so ...

> Since apparently the interest in this trivia :) continues, I'll bump the
> priority and submit a file for Documentation/ by the end of the week.
> Clemens, if your need is urgent, drop me a line and I can send you a
> less polished description sooner.

No its not urgent. It all just started because I lost some devices in
2.4.20 in the /proc/stat on a completly different system, so I looked in
the 2.5er on my test machine and compared to the 2.4er on the same box,
and I just thought it might be a similar bug/problem.

- --
Clemens Schwaighofer - IT Engineer & System Administration
==========================================================
Tequila Japan, 6-17-2 Ginza Chuo-ku, Tokyo 104-8167, JAPAN
Tel: +81-(0)3-3545-7703            Fax: +81-(0)3-3545-7343
http://www.tequila.jp
==========================================================
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQE+wZyajBz/yQjBxz8RAsXHAKDLXyNJkbrnWJIZHo2h22N45iS6cQCffKbg
+pVYJ1DDWMfxN7VQecvrtb0=
=AyTk
-----END PGP SIGNATURE-----

