Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267989AbRGVPNR>; Sun, 22 Jul 2001 11:13:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267990AbRGVPNH>; Sun, 22 Jul 2001 11:13:07 -0400
Received: from usw-sf-sshgate.sourceforge.net ([216.136.171.253]:56247 "EHLO
	usw-sf-netmisc.sourceforge.net") by vger.kernel.org with ESMTP
	id <S267989AbRGVPM6>; Sun, 22 Jul 2001 11:12:58 -0400
To: linux-kernel@vger.kernel.org
Subject: kgdb enhancements
Message-Id: <E15OKul-0001tB-00@usw-pr-shell2.sourceforge.net>
From: "Amit S. Kale" <akale@users.sourceforge.net>
Date: Sun, 22 Jul 2001 08:13:03 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hi,

I have restructured the kgdb webpage for better readability and added extensive
documentation. The documentation is still being being written.

kgdb for linux kernel 2.4.6 is available from the downloads page. It has
following improvements over kgdb for 2.4.3 and 2.4.5 kernels. 

- Enhanced kgdb with kgdb and kernel asserts. 
- Added configuration option for thread analysis. The configuration option
  enables code required for thread analysis which is disabled by default to of
  the overhead it causes. 
- Modified semaphore handling functions so that knowing where a thread is
  waiting on a semaphore is easier.

Please visit http://kgdb.sourceforge.net/ to get new kgdb.
Thanks.
--
Amit S. Kale
<akale@users.sourceforge.net>
Linux kernel source level debugger    http://kgdb.sourceforge.net/
Translation filesystem                http://trfs.sourceforge.net/ 
