Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268940AbRHLDue>; Sat, 11 Aug 2001 23:50:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268941AbRHLDuX>; Sat, 11 Aug 2001 23:50:23 -0400
Received: from dc-mx04.cluster0.hsacorp.net ([209.225.8.14]:55687 "EHLO
	dc-mx04.cluster1.charter.net") by vger.kernel.org with ESMTP
	id <S268940AbRHLDuQ>; Sat, 11 Aug 2001 23:50:16 -0400
Date: Sat, 11 Aug 2001 23:48:24 -0400
To: linux-kernel@vger.kernel.org
Subject: VM working much better in 2.4.8 than before
Message-ID: <20010811234822.A422@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.20i
From: <misty-@charter.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	I've said it before, I'll say it again - you guys deserve a
'this is a great thing' report once in a while. This is such a report :)
>From 2.4.7 to 2.4.8 the greatest effect I've seen so far is that my swap
use is quite minimal - This affects my 486 quite noticably, I don't have
exact figures but I'm guessing it's startup time is 1/3 of normal.
Shocked the heck out of me, and it's using only 10MB of swap when
idle where it used to use at least 15-20MB. Also I've noticed much less
swap activity during heavy use, which is really helping both my old 486
in a extremely noticable way (hard disk is a huge bottleneck on that
poor demented trashcan :) and my K6-III which has a udma 66 disk... When
it doesn't have to pay attention to writing to the swap partition, it
obviously can be doing other things. Which helps. Really! :)

Thanks for the improvements, all of you,

Tim McGrath

(formerly at tcm@nac.net)
