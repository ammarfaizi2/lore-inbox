Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263081AbTJUMNd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 08:13:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263088AbTJUMNc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 08:13:32 -0400
Received: from fe3-cox.cox-internet.com ([66.76.2.40]:4262 "EHLO
	fe3.cox-internet.com") by vger.kernel.org with ESMTP
	id S263081AbTJUMNa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 08:13:30 -0400
Message-ID: <3F95227C.6080601@jump.net>
Date: Tue, 21 Oct 2003 07:11:40 -0500
From: Ian <brooke@jump.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Panic with mounting CD in 2.6.0test8
X-Enigmail-Version: 0.76.7.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I'm getting a kernel panic in running 2.6.0test8 which I just compiled
today.
After chatting this up with #Kernelnewbies, erikm told me to post here.

http://www.gastronomicon.org/im003116.jpg

Attempt to mount a particular CD, which I'm thinking is just an ordinary
data CD.
It could be a VCD, but then I would suspect it would play on my DVD player.
Windows sees it as a data disk with one big AVI file on it.
Anyway, I was impressed by the magical symbol lookups in the crash dump,
but I really just want to mount my CD.

I am not subscribed to this list, so please CC me on any correspondence.
I will gladly help debug this.


Here's the output of ver_linux:

Linux narcissus.jump.net 2.6.0-test8 #1 Tue Oct 21 06:11:07 CDT 2003
i686 unknown

Gnu C                  3.3.1
Gnu make               3.80
util-linux             2.11i
mount                  2.11i
module-init-tools      0.9.15-pre2
e2fsprogs              1.26
reiserfsprogs          3.x.0j
pcmcia-cs              3.0.9
PPP                    2.4.2b3
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Linux C++ Library      5.0.5
Procps                 2.0.2
Net-tools              1.51
Console-tools          1999.03.02
Sh-utils               1.16
Modules Loaded


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQE/lSJ82zWJPZQSerIRApSDAKCMx6m+RZZgVoqE1RKokV3mNWSMRACeJyDm
TFAi1FMogSOA3rWqxRo9IrQ=
=OK7x
-----END PGP SIGNATURE-----


