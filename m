Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964800AbVHaNeV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964800AbVHaNeV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 09:34:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964805AbVHaNeV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 09:34:21 -0400
Received: from rudy.mif.pg.gda.pl ([153.19.42.16]:19345 "EHLO
	rudy.mif.pg.gda.pl") by vger.kernel.org with ESMTP id S964800AbVHaNeU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 09:34:20 -0400
Date: Wed, 31 Aug 2005 15:34:18 +0200 (CEST)
From: =?ISO-8859-2?Q?Tomasz_K=B3oczko?= <kloczek@rudy.mif.pg.gda.pl>
To: linux-kernel@vger.kernel.org
cc: Linus Torvalds <torvalds@osdl.org>
Subject: empty patch-2.6.13-git? patches on ftp.kernel.org
Message-ID: <Pine.BSO.4.62.0508311527340.10416@rudy.mif.pg.gda.pl>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="0-1127851226-1125494876=:10416"
Content-ID: <Pine.BSO.4.62.0508311528150.10416@rudy.mif.pg.gda.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-1127851226-1125494876=:10416
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-2; FORMAT=flowed
Content-Transfer-Encoding: 8BIT
Content-ID: <Pine.BSO.4.62.0508311528151.10416@rudy.mif.pg.gda.pl>


Seems patches stored on ftp://ftp.kernel.org/pub/linux/kernel/v2.6/snapshots
are empty (only logs are correct):

$ lftp ftp://ftp.kernel.org/pub/linux/kernel/v2.6/snapshots
cd ok, cwd=/pub/linux/kernel/v2.6/snapshots
lftp ftp.kernel.org:/pub/linux/kernel/v2.6/snapshots> ls patch-2.6.13-git*
-rw-r--r--    1 536      536            14 Aug 30 09:01 patch-2.6.13-git1.bz2
-rw-r--r--    1 536      536           248 Aug 30 09:01 patch-2.6.13-git1.bz2.sign
-rw-r--r--    1 536      536            20 Aug 30 09:01 patch-2.6.13-git1.gz
-rw-r--r--    1 536      536           248 Aug 30 09:01 patch-2.6.13-git1.gz.sign
-rw-r--r--    1 536      536            41 Aug 30 09:01 patch-2.6.13-git1.id
-rw-r--r--    1 536      536        302049 Aug 30 09:01 patch-2.6.13-git1.log
-rw-r--r--    1 536      536           248 Aug 30 09:01 patch-2.6.13-git1.sign
-rw-r--r--    1 536      536            14 Aug 31 09:01 patch-2.6.13-git2.bz2
-rw-r--r--    1 536      536           248 Aug 31 09:01 patch-2.6.13-git2.bz2.sign
-rw-r--r--    1 536      536            20 Aug 31 09:01 patch-2.6.13-git2.gz
-rw-r--r--    1 536      536           248 Aug 31 09:01 patch-2.6.13-git2.gz.sign
-rw-r--r--    1 536      536            41 Aug 31 09:01 patch-2.6.13-git2.id
-rw-r--r--    1 536      536        395585 Aug 31 09:01 patch-2.6.13-git2.log
-rw-r--r--    1 536      536           248 Aug 31 09:01 patch-2.6.13-git2.sign

Also it will be good move all patch-2.6.12* and patch-2.6.13-rc* files 
from this directory to old subdirectory.

kloczek
-- 
-----------------------------------------------------------
*Ludzie nie maj± problemów, tylko sobie sami je stwarzaj±*
-----------------------------------------------------------
Tomasz K³oczko, sys adm @zie.pg.gda.pl|*e-mail: kloczek@rudy.mif.pg.gda.pl*
--0-1127851226-1125494876=:10416--
