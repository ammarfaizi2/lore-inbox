Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262821AbVAQSOc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262821AbVAQSOc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 13:14:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262820AbVAQSMD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 13:12:03 -0500
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:57825 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S262821AbVAQSGn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 13:06:43 -0500
Message-ID: <41EBFEB5.5080807@comcast.net>
Date: Mon, 17 Jan 2005 13:06:45 -0500
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041211)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux Kernel Audit Project?
References: <41EB6691.10905@comcast.net> <20050117073217.GC13827@redhat.com> <41EB6D94.9040500@comcast.net> <20050117123813.GO4274@stusta.de>
In-Reply-To: <20050117123813.GO4274@stusta.de>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Adrian Bunk wrote:
> On Mon, Jan 17, 2005 at 02:47:32AM -0500, John Richard Moser wrote:
> 

[...]

> 
> What exactly do you want to audit for?
> 

Security holes

> If it's only for "ordinary" bugs, that's simply not feasible.
> The amount of patches going into 2.6 is currently at about 3 MB every 
> week. You can hardly keep up with all of that - and even if you were 
> able to do so, some theoretically correct patch might break in practice 
> due to hardware bugs or bugs in some toolchain.
> 

Understood.

> Regarding security audits:
> They aren't a bad idea, and not bound to new patches - much legacy code 
> in the kernel has for sure more bugs than new code. The linus-kernel way 
> for such a project is not to scream "We need SOMETHING" - the 
> linux-kernel way is that you start with the work to get the ball rolling 
> (and if other people are interested to work in the same area, give them 
> some guidance).
> 

I'm nowhere near being able to actually do a security audit.  I
understand what an audit is, I understand what causes vulnerabilities,
but I'd probably only be able to see the most obvious things (like
strcpy(a,"Aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa") into a[4]).

If I had a few more years of experience, college out of the way, a good
job, and had some of my other projects moving along, maybe. . . .

> cu
> Adrian
> 

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB6/61hDd4aOud5P8RAiTiAJ4jUrPCHj3f+NT5RsgKUGUXO4PSGQCfXW3E
SWJkAfcoqcbW9hD2Ew33R18=
=hnty
-----END PGP SIGNATURE-----
