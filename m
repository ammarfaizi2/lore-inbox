Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268533AbUHaOKn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268533AbUHaOKn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 10:10:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268580AbUHaOKn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 10:10:43 -0400
Received: from brmea-mail-3.Sun.COM ([192.18.98.34]:33415 "EHLO
	brmea-mail-3.sun.com") by vger.kernel.org with ESMTP
	id S268533AbUHaOKW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 10:10:22 -0400
Date: Tue, 31 Aug 2004 10:09:52 -0400
From: Mike Waychison <Michael.Waychison@Sun.COM>
Subject: Re: silent semantic changes in reiser4 (brief attempt to document the
 idea of what reiser4 wants to do with metafiles and why
In-reply-to: <41323AD8.7040103@namesys.com>
To: Hans Reiser <reiser@namesys.com>
Cc: Andrew Morton <akpm@digeo.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, reiserfs-list@namesys.com
Message-id: <413486B0.4050101@sun.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Enigmail-Version: 0.83.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
References: <41323AD8.7040103@namesys.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hans Reiser wrote:

>
> Why Openat Sucks:
>
> because you can't go cat filenameA/metas/permissions >
> filenameB/permissions
>
> If cat doesn't work, then we are suffering exactly the problem with
> namespace fragmentation that this whole scheme was invented to avoid.
>

Sure you can.  All you need to do is fix your shell.

- --
Mike Waychison
Sun Microsystems, Inc.
1 (650) 352-5299 voice
1 (416) 202-8336 voice
http://www.sun.com

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
NOTICE:  The opinions expressed in this email are held by me,
and may not represent the views of Sun Microsystems, Inc.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBNIavdQs4kOxk3/MRAmvAAJ9sZfEgIOfINZsT23pa+Y3nQ4lfMACgmN3q
sdgPzBUg9i/c+roWDrXq5BI=
=poSJ
-----END PGP SIGNATURE-----
