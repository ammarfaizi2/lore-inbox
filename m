Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261156AbULZUB0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261156AbULZUB0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Dec 2004 15:01:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261155AbULZUBZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Dec 2004 15:01:25 -0500
Received: from lakermmtao04.cox.net ([68.230.240.35]:54769 "EHLO
	lakermmtao04.cox.net") by vger.kernel.org with ESMTP
	id S261153AbULZUBX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Dec 2004 15:01:23 -0500
Message-ID: <41CF188D.8090404@gmail.com>
Date: Sun, 26 Dec 2004 14:01:17 -0600
From: John <smartcat99s@gmail.com>
Reply-To: linux-kernel@vger.kernel.org
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Charles Shannon Hendrix <shannon@widomaker.com>
Subject: Re: ide-cd hang while playing a CD in 2.6.10
References: <20041225234342.GA5177@widomaker.com>
In-Reply-To: <20041225234342.GA5177@widomaker.com>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Charles Shannon Hendrix wrote:
|
| I have a repeatable problem playing music CDs with kernel 2.6.8.1 and
| 2.6.10.
|
| Running "gnome-cd" to play a CD, the drive and IDE bus flash a few times
| for about 15 seconds, and then the IDE bus light goes solid.
|
| gnome-cd is hung in the driver.
|
| /var/log/messages shows the following lines:
|
| Dec 25 16:58:57 daydream kernel: ide-cd: cmd 0x47 timed out
| Dec 25 16:59:57 daydream kernel: ide-cd: cmd 0x47 timed out
| Dec 25 17:00:56 daydream kernel: ide-cd: cmd 0x47 timed out
|
| ...and so on.  It repeats every minute.
|
| Only a reboot will fix things.
|
| Is this a known problem, or is this something I should dig deeper into?

Can you check a different IDE cable?
I remember having something like that with my hard drive.

- -John
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (MingW32)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBzxiNWW28UPiAJ/oRArXKAJ41QUc+N14VccnAt94OsNKUFO4EGwCeLPSJ
Cyr0vuntF84fvwxfAuFsNSw=
=p/1k
-----END PGP SIGNATURE-----

