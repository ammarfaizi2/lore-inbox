Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266023AbUAEXkm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 18:40:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266020AbUAEXh6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 18:37:58 -0500
Received: from sccrmhc12.comcast.net ([204.127.202.56]:59385 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S266023AbUAEXgD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 18:36:03 -0500
Message-ID: <3FF9F4C2.5040306@eglifamily.dnsalias.net>
Date: Mon, 05 Jan 2004 16:35:30 -0700
From: Dan Egli <dan@eglifamily.dnsalias.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: James Simmons <jsimmons@infradead.org>
CC: Thomas Molina <tmolina@cablespeed.com>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0401052334110.7347-100000@phoenix.infradead.org>
In-Reply-To: <Pine.LNX.4.44.0401052334110.7347-100000@phoenix.infradead.org>
X-Enigmail-Version: 0.82.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Subject: Re: Blank Screen in 2.6.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Mail-From: dan@eglifamily.dnsalias.net
X-SA-Exim-Scanned: No; SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

James Simmons wrote:
|>|>The decision to release 2.6.0 with the same broken vga= option that was
|>|>reported many times in 2.6.0-test* makes me think that vga= is not
|>intended
|>|>to work.
|>|
|>|
|>| Maybe it has something to do with RedHat 7.3.  I've used RH8, RH9, and
|>| Fedora Core 1 and haven't had a problem with vga= in any of them during
|>| the 2.5/2.6 series, right up through the current one.  I've got
|>| framebuffer support as a module.
|>|
|>
|>
|>Not RedHat 9 issue because I'm using RH 9 and I am the one that started
|>this thread.
|
|
| Its a bug in the kernel. Fixed in latest tree.
|
| http://phoenix.infradead.org/~jsimmons/fbdev.diff.gz
|
|
|
Cool. When the 2.6.1 comes out (I'm assuming that this means it will be
in 2.6.1), I'll d/l it and try it out.

- --- Dan
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (MingW32)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQE/+fTCtwT22Jak4/4RAroCAJkBU2goo0OYMSgRZAo25/zvdpUp+QCfZlLh
H9y/WAT8t/hBONnhJ+U6k2I=
=1H0b
-----END PGP SIGNATURE-----

