Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261199AbVEBWnu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261199AbVEBWnu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 18:43:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261201AbVEBWnu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 18:43:50 -0400
Received: from www.tuxrocks.com ([64.62.190.123]:38668 "EHLO tuxrocks.com")
	by vger.kernel.org with ESMTP id S261199AbVEBWnq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 18:43:46 -0400
Message-ID: <4276AC90.30008@tuxrocks.com>
Date: Mon, 02 May 2005 16:41:20 -0600
From: Frank Sorenson <frank@tuxrocks.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Valdis.Kletnieks@vt.edu
CC: Adrian Bunk <bunk@stusta.de>, Ed Tomlinson <tomlins@cam.org>,
       "Randy.Dunlap" <rddunlap@osdl.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc3-mm1
References: <20050429231653.32d2f091.akpm@osdl.org> <Pine.LNX.4.61.0504301700470.3559@montezuma.fsmlabs.com> <20050430161032.0f5ac973.rddunlap@osdl.org> <200505010909.38277.tomlins@cam.org>            <20050501133040.GB3592@stusta.de> <200505021528.j42FS5QJ006515@turing-police.cc.vt.edu>
In-Reply-To: <200505021528.j42FS5QJ006515@turing-police.cc.vt.edu>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Valdis.Kletnieks@vt.edu wrote:
> And even *more* importantly, note that when downloading a -mm or -rc3 patch,
> there's minimal server overhead - it opens *one* file and streams it to the
> FTP connection.  sendfile() anybody? ;)

Also, note that once I've downloaded the single .bz2 file, I can easily
copy or move it to the various computers I'll be compiling and
installing it on.  It's much easier to transfer the one file (via USB
memory  stick, SCP, CD, etc.) than a whole tree.

Frank
- --
Frank Sorenson - KD7TZK
Systems Manager, Computer Science Department
Brigham Young University
frank@tuxrocks.com
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCdqyQaI0dwg4A47wRApg8AJ46iCEvIOO+nhS9gUTMAAWQPjnq6ACfcdc3
OI0v0qRV4PgEFPRwClkVudo=
=cxYG
-----END PGP SIGNATURE-----
