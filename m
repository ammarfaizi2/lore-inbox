Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269392AbTGZUGw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 16:06:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269400AbTGZUGv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 16:06:51 -0400
Received: from mta2.srv.hcvlny.cv.net ([167.206.5.5]:10238 "EHLO
	mta2.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S269392AbTGZUGt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 16:06:49 -0400
Date: Sat, 26 Jul 2003 16:21:46 -0400
From: Jeff Sipek <jeffpc@optonline.net>
Subject: Re: [TRIVIAL] use ext2/ext3 consistently in Kconfig
In-reply-to: <20030726195722.GB16160@louise.pinerecords.com>
To: Tomas Szepe <szepe@pinerecords.com>, Linus Torvalds <torvalds@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>
Message-id: <200307261621.55553.jeffpc@optonline.net>
MIME-version: 1.0
Content-type: Text/Plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
Content-disposition: inline
Content-description: clearsigned data
User-Agent: KMail/1.5.2
References: <20030726195722.GB16160@louise.pinerecords.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Saturday 26 July 2003 15:57, Tomas Szepe wrote:
<snip>
> @@ -89,7 +89,7 @@
>         tristate "Ext3 journalling file system support"
>         help
>           This is the journaling version of the Second extended file system
> -         (often called ext3), the de facto standard Linux file system
> +         (often called ext2), the de facto standard Linux file system

The journaling version is ext3, not ext2...

>           (method to organize files on a storage device) for hard disks.
>  
>           The journaling code included in this driver means you do not have

Jeff.

- -- 
The Moon is Waning Crescent (6% of Full)
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/IuLewFP0+seVj/4RAlsDAJ9q3HWdl2aglGL04TloJYhIykuLiwCgx5RY
oSpW1bYjhdNZmnu/zHS6DjA=
=k1N2
-----END PGP SIGNATURE-----

