Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263976AbTJFE6N (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 00:58:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263977AbTJFE6N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 00:58:13 -0400
Received: from smtp1.cwidc.net ([154.33.63.111]:16584 "EHLO smtp1.cwidc.net")
	by vger.kernel.org with ESMTP id S263976AbTJFE6J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 00:58:09 -0400
Message-ID: <3F80F67C.6070207@tequila.co.jp>
Date: Mon, 06 Oct 2003 13:58:36 +0900
From: Clemens Schwaighofer <cs@tequila.co.jp>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5a) Gecko/20030718
X-Accept-Language: en-us, en, ja
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: linux 2.6 csv from 20031006
References: <200310061242.17809.schwaigl@eunet.at>
In-Reply-To: <200310061242.17809.schwaigl@eunet.at>
X-Enigmail-Version: 0.76.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Clemens Schwaighofer wrote:

> after a clean checkout and just an load of the old config file, I get
this
> during the compile
>
> net/appletalk/aarp.c: In function `aarp_seq_start':
> net/appletalk/aarp.c:944: parse error before '<<' token
> net/appletalk/aarp.c:954: redeclaration of `iter'
> net/appletalk/aarp.c:938: `iter' previously declared here
> net/appletalk/aarp.c:959: `v' undeclared (first use in this function)
> net/appletalk/aarp.c:959: (Each undeclared identifier is reported only
once
> net/appletalk/aarp.c:959: for each function it appears in.)
> net/appletalk/aarp.c:960: `entry' undeclared (first use in this function)
> net/appletalk/aarp.c: At top level:
> net/appletalk/aarp.c:1029: `aarp_seq_next' undeclared here (not in a
function)
> net/appletalk/aarp.c:1029: initializer element is not constant
> net/appletalk/aarp.c:1029: (near initialization for `aarp_seq_ops.next')
> make[2]: *** [net/appletalk/aarp.o] Error 1
> make[1]: *** [net/appletalk] Error 2
> make: *** [net] Error 2

okay my fault, somehow the file got corrupted during the CSV update ...
sorry

- --
Clemens Schwaighofer - IT Engineer & System Administration
==========================================================
Tequila Japan, 6-17-2 Ginza Chuo-ku, Tokyo 104-8167, JAPAN
Tel: +81-(0)3-3545-7703            Fax: +81-(0)3-3545-7343
http://www.tequila.jp
==========================================================
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQE/gPZ8jBz/yQjBxz8RAg/PAKC9BrH3kuTaDocMHVI0UejkqgDtYgCgv48x
7pCe4XyiAV5ne9KbH3j4AyY=
=sMCe
-----END PGP SIGNATURE-----

