Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275091AbTHAGTC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 02:19:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275098AbTHAGTC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 02:19:02 -0400
Received: from 202-47-55-78.adsl.gil.com.au ([202.47.55.78]:642 "HELO
	longlandclan.hopto.org") by vger.kernel.org with SMTP
	id S275091AbTHAGS6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 02:18:58 -0400
Message-ID: <3F2A064F.3070609@longlandclan.hopto.org>
Date: Fri, 01 Aug 2003 16:18:55 +1000
From: Stuart Longland <stuartl@longlandclan.hopto.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.4b) Gecko/20030507
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.6.0-test2-mm2 Still No Penguin Logo
References: <20030801005737.72096.qmail@web13301.mail.yahoo.com> <200308010124.01632.gene.heskett@verizon.net> <20030801060600.GB21437@charite.de>
In-Reply-To: <20030801060600.GB21437@charite.de>
X-Enigmail-Version: 0.75.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Ralf Hildebrandt wrote:

| * Gene Heskett <gene.heskett@verizon.net>:
|
|>On Thursday 31 July 2003 20:57, Ronald Jerome wrote:
|>
|>>Logo has dissapeared after 2.6.0-test1-mm2.
|>>
|>>I would have thought test2-mm2 would have patched the problem?
|>>
|>
|>I have a blue bar a couple of inches high with test2-mm2, but I've
|>never actually seen the logo when booting 2.6.  What options trigger
|>that properly?
|
|
| Same here. I have all the logo options activated, yet I only get a
| black bar on top of the screen when booting with a fraembuffer console.
|

I've had it work on my main machine, which uses the Radeon framebuffer,
but on my laptop, which uses the VESA framebuffer, I get the same thing.

I might try again later using the NeoMagic framebuffer and see if the
fault still exists.  If it works on the laptop using the neomagic
framebuffer, that might point to a problem with the VESA driver.

This is with Linux 2.6.0-test1.  (I wasn't aware of the existance of
2.6.0-test2 until I subscribed to this list less than 24 hours ago)

- --
+-------------------------------------------------------------+
| Stuart Longland           stuartl at longlandclan.hopto.org |
| Brisbane Mesh Node: 719             http://stuartl.cjb.net/ |
| I haven't lost my mind - it's backed up on a tape somewhere |
| Griffith Student No:           Course: Bachelor/IT (Nathan) |
+-------------------------------------------------------------+
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQE/KgZPIGJk7gLSDPcRArkfAJ9uDoKT+PosA/pRRCDD7ZXTa+xG3wCfZl0E
zRlRhA/d182U47UuIHN9ga4=
=YgA3
-----END PGP SIGNATURE-----

