Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262040AbSLIBMp>; Sun, 8 Dec 2002 20:12:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262067AbSLIBMp>; Sun, 8 Dec 2002 20:12:45 -0500
Received: from main.gmane.org ([80.91.224.249]:35032 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id <S262040AbSLIBMo>;
	Sun, 8 Dec 2002 20:12:44 -0500
To: linux-kernel@vger.kernel.org
X-Injected-Via-Gmane: http://gmane.org/
Path: not-for-mail
From: John Byrnes <jb1@alfred.edu>
Subject: 2.5.50 performance, mouse control, music, and X
Date: Sun, 08 Dec 2002 20:09:11 -0500
Message-ID: <at0qld$jhu$1@main.gmane.org>
NNTP-Posting-Host: parkst098.alfred.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Trace: main.gmane.org 1039396333 20030 149.84.168.98 (9 Dec 2002 01:12:13 GMT)
X-Complaints-To: usenet@main.gmane.org
NNTP-Posting-Date: Mon, 9 Dec 2002 01:12:13 +0000 (UTC)
User-Agent: KNode/0.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello all,

I'm not quite sure if this is the right newsgroup to post this in, but I
have a few comments/bug reports about the beta kernel 2.5.50.

First off, general X performance is vastly improved. However, when compiling
something (I use Gentoo), I've noticed that the system hangs a little, and
the mouse acts strangely.  It appears to register mouse clicks when I
havent clicked anything.  It especially likes to register the mouse wheel
scroll as a paste operation.  

Under the same circumstances as before, my sound (ARtS and ALSA) is jumpy.  

I didn't notice any of these problems under 2.4.19.

BTW, I compiled with gcc3.2.

Thanks,

John
- -- 
Freedom is nothing else but the chance to do better.
                -- Camus

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE98+1FooWIgRUk5UwRAiC9AJ4yY6nu8ymnfUKwYmGA3dv3+MqmmwCgrxOE
Ktx0nPam7D6JSXD6NDU/hjQ=
=FDYY
-----END PGP SIGNATURE-----


