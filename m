Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265098AbSLRNuo>; Wed, 18 Dec 2002 08:50:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267253AbSLRNuo>; Wed, 18 Dec 2002 08:50:44 -0500
Received: from c16688.thoms1.vic.optusnet.com.au ([210.49.244.54]:48286 "EHLO
	mail.kolivas.net") by vger.kernel.org with ESMTP id <S265098AbSLRNum>;
	Wed, 18 Dec 2002 08:50:42 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Con Kolivas <conman@kolivas.net>
Reply-To: conman@kolivas.net
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: 2.4.20-ck2
Date: Thu, 19 Dec 2002 00:58:25 +1100
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200212190058.39029.conman@kolivas.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Updated my patchset

Includes:
O(1) scheduler with batch scheduling
Preemptible - updated
Low Latency - updated
AA vm addons
or
Rmap15b - updated
Read latency2 - added
ALSA 0.90rc2
Supermount
XFS 1.2pre3
ACPI - updated
Variable Hz - added


added extras available by request but not in the default patch (less tested 
and tuning changes):

Tuning - added
1000Hz with autoregulated timeslice - updated/resync
Compressed Caching 0.24pre5 - updated - *still not safe with preempt*

Get it here:
http://kernel.kolivas.net

Cheers,
Con

P.S. feel free to contact me with comments, suggestions, patches or questions.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE+AH8DF6dfvkL3i1gRAj6DAKCDXYmsUWUEDm/QNGlnE0R+XWmFigCfYL7L
6uuEedutsFDS/CKdkq1q8PY=
=f/3S
-----END PGP SIGNATURE-----
