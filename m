Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262438AbUJ0Nsg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262438AbUJ0Nsg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 09:48:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262440AbUJ0Nsg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 09:48:36 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:10717 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S262438AbUJ0NsI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 09:48:08 -0400
Message-ID: <417FA711.90700@comcast.net>
Date: Wed, 27 Oct 2004 09:48:01 -0400
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 0.8 (X11/20041022)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: Willy Tarreau <willy@w.ods.org>, Rik van Riel <riel@redhat.com>,
       "Marcos D. Marado Torres" <marado@student.dei.uc.pt>,
       Ed Tomlinson <edt@aei.ca>, Massimo Cetra <mcetra@navynet.it>,
       "'Chuck Ebbert'" <76306.1226@compuserve.com>,
       "'Bill Davidsen'" <davidsen@tmr.com>,
       "'linux-kernel'" <linux-kernel@vger.kernel.org>
Subject: Re: My thoughts on the "new development model"
References: <Pine.LNX.4.61.0410270402340.20284@student.dei.uc.pt> <Pine.LNX.4.44.0410270027110.21548-100000@chimarrao.boston.redhat.com> <20041027051342.GK19761@alpha.home.local> <20041027052321.GT15367@holomorphy.com>
In-Reply-To: <20041027052321.GT15367@holomorphy.com>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



William Lee Irwin III wrote:
| On Wed, Oct 27, 2004 at 12:29:10AM -0400, Rik van Riel wrote:
|
|>>While a 2.7 series might provide developers with an "outlet"
|>>for their creativity, it does not give users the availability
|>>of the features they need.
|
|
| On Wed, Oct 27, 2004 at 07:13:42AM +0200, Willy Tarreau wrote:
|
|>Rik, "new features" are what causes the kernel to be in permanent
development
|>mode. It happened to all of us that a new feature broke compatability
with a
|>patch or even caused a side effect. Users don't "need" new features, they
|>*want* them. This is what makes them upgrade to the new release in a fast
|>release model. If 2.4 had been released sooner, USB would never have made
|>it in 2.2, and 2.2 users would have switched faster. I know people who
still
|>use 2.2 only on their dev systems because they don't need any upgrade.
|
|
| The new features you're complaining about are astoundingly not the
| causes of any of the bugs cited as critical issues in this thread.
|

I for one don't give a damn.  Bugs and how fast this development model
fix them aren't a concern to me; although I'd never slow down the bug
fixing process.  My concern is getting a real stable tree for various
maintainers to base on, so that various patches for drivers, security
enhancements, and other things aren't scattered across versions and
impossible to patch together even when they're noninvasive to eachother.

Have you stopped to consider that the features that are critical to me
are also holding me back from upgrading to the newer kernels?
Ironically, these are security features, and the newer kernels have
newer security fixes aside from new schedulers and other toys I could
really enjoy having around.

| It also appears that you have forgotten early 2.4 at the very least...
|
|
| -- wli
| -
| To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
| the body of a message to majordomo@vger.kernel.org
| More majordomo info at  http://vger.kernel.org/majordomo-info.html
| Please read the FAQ at  http://www.tux.org/lkml/
|

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBf6cPhDd4aOud5P8RAhWIAJ4u8W+KobiYoGKhsXEqw5TL+zUIggCaAueL
AWGds1692rVAhFb/+KHiyvM=
=jB3R
-----END PGP SIGNATURE-----
