Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266529AbRGDHt5>; Wed, 4 Jul 2001 03:49:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266530AbRGDHtr>; Wed, 4 Jul 2001 03:49:47 -0400
Received: from blackhole.adamant.net ([212.26.128.69]:2320 "EHLO
	blackhole.adamant.net") by vger.kernel.org with ESMTP
	id <S266529AbRGDHtn>; Wed, 4 Jul 2001 03:49:43 -0400
Date: Wed, 4 Jul 2001 10:52:20 +0300
From: Alexander Trotsai <mage@adamant.net>
To: linux-kernel@vger.kernel.org
Subject: 2.4.5-ac23 locks
Message-ID: <20010704105220.C1215@blackhole.adamant.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
Organization: Adamant ISP
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

I have IDE CDRW drive and write discs over IDE-SCSI emulation
With ac22 annd OK but with ac23 when I try write disc kernel locks after 20-30
MB wrote and could be rebooted only with magic key. I can't see nothing becose
wrote disc in X but in my syslog I can't see nothing also.

-- 
UaNic: MAGE1-UANIC, RIPE: MAGE-RIPE, InterNic: AT2963, ICQ: 18035130
PGP: ftp://blackhole.adamant.net/pgp/mykey.pgp.asc
Trouble of the day: Support staff hung over, send aspirin and come back LATER.
