Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136496AbREDUB2>; Fri, 4 May 2001 16:01:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136494AbREDUBS>; Fri, 4 May 2001 16:01:18 -0400
Received: from bitmover.com ([207.181.251.162]:14864 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S136492AbREDUBG>;
	Fri, 4 May 2001 16:01:06 -0400
Date: Fri, 4 May 2001 13:01:03 -0700
From: Larry McVoy <lm@bitmover.com>
To: linux-kernel@vger.kernel.org
Subject: 3ware 6410 RAID 10 performance?
Message-ID: <20010504130103.T22922@work.bitmover.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm looking for people who know about the 3ware 6410 driver.  I've got one
of these and sometimes it goes fast and sometimes it doesn't.  The bad 
case seems to happen after memory has a lot of cached blocks in it.

I've tried 2.2.15, 2.4.4, and 2.4.3-ac9 and they all behave pretty similarly.

I'm most interested in seeing this fixed in the 2.4 series so if there is
someone who wants to go into a test/debug cycle with me, speak up.  I'd
really like this thing to work well.

hardware config:

K7 @ 750Mhz
ASUS K7V motherboard
512MB
4x 3c905
boot disk on the motherboard
4 WD 40GB 7200 drives on one 3ware 6410
matrox g200 AGP
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
