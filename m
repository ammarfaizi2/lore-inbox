Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261175AbVAKRuG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261175AbVAKRuG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 12:50:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261208AbVAKRsu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 12:48:50 -0500
Received: from sccrmhc13.comcast.net ([204.127.202.64]:3565 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S261175AbVAKRg0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 12:36:26 -0500
Message-ID: <41E40E9D.9090502@comcast.net>
Date: Tue, 11 Jan 2005 12:36:29 -0500
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041211)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: starting with 2.7
References: <1105096053.5444.11.camel@ulysse.olympe.o2t>	 <20050107111508.GA6667@infradead.org> <20050107111751.GA6765@infradead.org>	 <41DEC83D.30105@comcast.net>	 <1105196469.10519.3.camel@localhost.localdomain>	 <41E37DA0.80702@comcast.net> <1105456172.15742.16.camel@localhost.localdomain>
In-Reply-To: <1105456172.15742.16.camel@localhost.localdomain>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Alan Cox wrote:
| On Maw, 2005-01-11 at 07:17, John Richard Moser wrote:
|
|>Hello??
|>
|>The latest 2.0 version of the Linux kernel is:  	2.0.40 	2004-02-08
|>07:13 UTC 	F 	V 	VI 	  	Changelog
|>
|>You have FOUR.  2.6, 2.4, 2.2, 2.0
|
|
| 2.4.29 is as different from say 2.4.9 as 2.0 is from 2.2 or 2.6.9 from
| 2.6.5
|
| You have a lot more than four
|

That's not good.

2.4.29 should ideally be 2.4.9 with a buttload of bug fixes.  Same with
2.6.5/2.6.9.  Major feature differences should ideally come with majors,
i.e. 2.0->2.2->2.4->2.6

A few bugfix backports may be fine, though that's already light to fair
work (depending on how many security bugs are being found and need
backporting, versus how many can patch clean without porting); How do
you people maintain 4 ACTIVE branches?

oi, whatever.
|

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB5A6dhDd4aOud5P8RAhAtAJ9FgTkd/AyZXuI59gyiIVAJNFM9rgCdGYss
kN4m4Bc5BVeVLZbWGHIP+xg=
=hDM/
-----END PGP SIGNATURE-----
