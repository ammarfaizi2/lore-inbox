Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264613AbSJNKGN>; Mon, 14 Oct 2002 06:06:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264611AbSJNKGN>; Mon, 14 Oct 2002 06:06:13 -0400
Received: from c17928.thoms1.vic.optusnet.com.au ([210.49.249.29]:57729 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S264613AbSJNKEM> convert rfc822-to-8bit; Mon, 14 Oct 2002 06:04:12 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Con Kolivas <conman@kolivas.net>
To: linux-kernel@vger.kernel.org
Subject: performance patchset (-ck) update for 2.4.19
Date: Mon, 14 Oct 2002 20:07:25 +1000
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200210142007.48512.conman@kolivas.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I've updated the patchset I've put together.

- -ck9 contains:

O(1) Scheduler (with batch scheduling)
Preemptible
Low Latency
Compressed Caching
XFS
Supermount
ALSA

The choice of patches to add was based on requests and feedback. The -aa and 
- -rmap vms are not compatible with this release; but the performance of -ck9 
outperforms both of them.  XFS compiles without problems but is untested.

Get it here:
http://kernel.kolivas.net

Cheers, enjoy!
Con.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9qpdfF6dfvkL3i1gRAjEhAJ4mvihaYL619QvM/RW6ljuS4f7OMQCghfQd
PvrBdFoRJI7FFu9l9Lbe6To=
=bRzj
-----END PGP SIGNATURE-----

