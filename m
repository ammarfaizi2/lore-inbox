Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263571AbTLJN4N (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 08:56:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263587AbTLJN4N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 08:56:13 -0500
Received: from ahriman.Bucharest.roedu.net ([141.85.128.71]:18578 "EHLO
	ahriman.bucharest.roedu.net") by vger.kernel.org with ESMTP
	id S263571AbTLJN4H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 08:56:07 -0500
Date: Wed, 10 Dec 2003 15:56:32 +0200 (EET)
From: Mihai RUSU <dizzy@roedu.net>
X-X-Sender: dizzy@ahriman.bucharest.roedu.net
To: Steve Lord <lord@xfs.org>
cc: linux-xfs@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at fs/xfs/support/debug.c:106!
In-Reply-To: <3FD722BC.1000205@xfs.org>
Message-ID: <Pine.LNX.4.56L0.0312101554450.17142@ahriman.bucharest.roedu.net>
References: <Pine.LNX.4.56L0.0312100953310.8346@ahriman.bucharest.roedu.net>
 <3FD722BC.1000205@xfs.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi

On Wed, 10 Dec 2003, Steve Lord wrote:

> Mihai,
> 
> You missed one thing out of your report, the console message xfs output 
> before this.

Yes you are right, I have saved it and sent it to ksymoops but it seems it 
ignored it when I fetched ksymoops output. Here its the message before 
that error

xfs_iget_core: ambiguous vns: vp/0xe5a2a640, invp/0xef6d1220

> Steve

- -- 
Mihai RUSU                                    Email: dizzy@roedu.net
GPG : http://dizzy.roedu.net/dizzy-gpg.txt    WWW: http://dizzy.roedu.net
                       "Linux is obsolete" -- AST
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/1yYSPZzOzrZY/1QRAoFZAJ9S8opBLWRVOPUbSFdHbyWIntfwDQCgxZk0
0+1DFcnfsGimM2a8LcqHM8E=
=p4X7
-----END PGP SIGNATURE-----
