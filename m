Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267941AbUHRW1K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267941AbUHRW1K (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 18:27:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267947AbUHRW1K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 18:27:10 -0400
Received: from box.punkt.pl ([217.8.180.66]:10002 "HELO box.punkt.pl")
	by vger.kernel.org with SMTP id S267941AbUHRW1H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 18:27:07 -0400
From: Mariusz Mazur <mmazur@kernel.pl>
To: linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] linux-libc-headers 2.6.8.0
Date: Thu, 19 Aug 2004 00:26:52 +0200
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200408190026.52885.mmazur@kernel.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Available at http://ep09.pld-linux.org/~mmazur/linux-libc-headers/
Changes:
- updated to 2.6.8
- readded ucontext.h - originally thought glibc could handle that, but doesn't 
seem that way (newest hddtemp builds)
- readded unaligned.h (and cleaned it up) - reiserfsprogs' developers found a 
use for it in userland (newest reiserfsprogs builds)
- added and cleaned up (more or less) the sh64 arch
- tried to add missing arm subarch - needs testing I guess
- minor fixes (some ia64 and x86_64 userland conflicts)


This release should have been here a day or two ago weren't it for Murphy's 
laws (the machine that I use for llh development 'broke' yesterday... after 4 
months of uptime :).

Enjoy.


-- 
In the year eighty five ten
God is gonna shake his mighty head
He'll either say,
"I'm pleased where man has been"
Or tear it down, and start again
