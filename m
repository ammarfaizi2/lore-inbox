Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318203AbSIBBuT>; Sun, 1 Sep 2002 21:50:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318205AbSIBBuT>; Sun, 1 Sep 2002 21:50:19 -0400
Received: from oak.sktc.net ([208.46.69.4]:26765 "EHLO oak.sktc.net")
	by vger.kernel.org with ESMTP id <S318203AbSIBBuT>;
	Sun, 1 Sep 2002 21:50:19 -0400
Message-ID: <3D72C4E7.9050809@sktc.net>
Date: Sun, 01 Sep 2002 20:54:47 -0500
From: "David D. Hagood" <wowbagger@sktc.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020830
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: O(1) & preempt & XFS & new IDE for 2.4.19
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Does anyone have a good patchset that has
XFS
O(1)
Preempt (preferably with lockbreak or low-latency)
IDE drivers for the new ATA-133 and 48bit addressing IDE cards?

Other toys, like rmap and such would be fun as well.

I've tried applying O(1) and preempt to the SGI CVS, but it didn't go 
cleanly. More like "it went like a politician mud-wrestling a 
televangelist while a daytime talkshow host and a sleazy lawyer looked on".


