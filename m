Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266483AbTGEUqL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jul 2003 16:46:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266490AbTGEUqL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jul 2003 16:46:11 -0400
Received: from mta4.srv.hcvlny.cv.net ([167.206.5.10]:36079 "EHLO
	mta4.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S266483AbTGEUqK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jul 2003 16:46:10 -0400
Date: Sat, 05 Jul 2003 16:59:05 -0400
From: Jeff Sipek <jeffpc@optonline.net>
Subject: Re: [PATCH - RFC] [1/5] 64-bit network statistics - generic net
In-reply-to: <3F0737D1.5090109@pobox.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Bernd Eckenfels <ecki@calista.eckenfels.6bone.ka-ip.net>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@digeo.com>,
       Dave Jones <davej@codemonkey.org.uk>,
       Linus Torvalds <torvalds@osdl.org>, netdev@oss.sgi.com
Message-id: <200307051700.32533.jeffpc@optonline.net>
MIME-version: 1.0
Content-type: Text/Plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
Content-disposition: inline
Content-description: clearsigned data
User-Agent: KMail/1.5.2
References: <E19YtAq-0006Xf-00@calista.inka.de>
 <200307051637.52252.jeffpc@optonline.net> <3F0737D1.5090109@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Saturday 05 July 2003 16:40, Jeff Garzik wrote:
> The net stats are already unsigned long internally.
>
> 64-bit case is handled quite nicely today, thanks :)

I wonder why jiffies are not unsigned long...the 64-bit case would have been 
handled quite nicely too... :-)

> I'm such a 64-bit bigot that "buy a 64-bit computer" is a solution I
> commonly suggest, and it seems to fit well here, too.

I wish I had the resources to get one... :-(

The thing is that x86 is here to stay for quite some time. Even if 64-bit 
processors take over the market, you will have so many "old" computers that 
can:

- - be thrown out
- - donated to some institution
- - converted to routers, and other "embedded" systems

Plus, they will be dirt cheap.

> 	Jeff, wondering if Intel will bother to compete w/ Athlon64

Intel screwed up with Itanium, if it had "legacy" support, they would have 
been better off...

Jeff.

- -- 
Defenestration n. (formal or joc.):
  The act of removing Windows from your computer in disgust, usually followed
  by the installation of Linux or some other Unix-like operating system.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/BzwdwFP0+seVj/4RAoUZAJ0dptf9cB60dDUQHU61zg6lO5CXSQCgqHWU
8VvyepQwEdTsNFYyozGedAY=
=OsNH
-----END PGP SIGNATURE-----

