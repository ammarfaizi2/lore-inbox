Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263343AbTI2NXw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 09:23:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263344AbTI2NXw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 09:23:52 -0400
Received: from h80ad2481.async.vt.edu ([128.173.36.129]:25542 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S263343AbTI2NXu (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 09:23:50 -0400
Message-Id: <200309291323.h8TDNXtH020029@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: John Bradford <john@grabjohn.com>
Cc: Larry McVoy <lm@bitmover.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: log-buf-len dynamic 
In-Reply-To: Your message of "Mon, 29 Sep 2003 12:24:47 BST."
             <200309291124.h8TBOlam000872@81-2-122-30.bradfords.org.uk> 
From: Valdis.Kletnieks@vt.edu
References: <m1n0csiybu.fsf@ebiederm.dsl.xmission.com> <20030925122838.A16288@discworld.dyndns.org> <20030925182921.GA18749@work.bitmover.com> <200309290356.27600.rob@landley.net>
            <200309291124.h8TBOlam000872@81-2-122-30.bradfords.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1758464220P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 29 Sep 2003 09:23:32 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1758464220P
Content-Type: text/plain; charset=us-ascii

On Mon, 29 Sep 2003 12:24:47 BST, John Bradford <john@grabjohn.com>  said:

> It could be argued that what we really need is enhanced versions of
> diff and patch that actually understand C constructs and are able to
> make intellegent decisions about merging two pieces of code, even
> without knowledge of other merges.

So what you're saying is that diff and patch should drag along all the BK
functionality, databases, and so forth.....

%  ls -l /usr/bin/diff /usr/bin/patch
-rwxr-xr-x    1 root     root        64540 Jun  5 14:57 /usr/bin/diff
-rwxr-xr-x    1 root     root        83828 Jun  5 22:41 /usr/bin/patch
% man diff | wc -l
    310
% man patch | wc -l
    675

Larry, how big is the BK binary for an x86? And how big are the docs?



--==_Exmh_1758464220P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/eDJUcC3lWbTT17ARAtwMAKCjNeROHn25bURVgp5HUb4/iSMS6gCgxn/3
Nh2EPTe3j7SioGO3tzleuyQ=
=tG9n
-----END PGP SIGNATURE-----

--==_Exmh_1758464220P--
