Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261418AbUEVOgr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261418AbUEVOgr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 May 2004 10:36:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261416AbUEVOgr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 May 2004 10:36:47 -0400
Received: from lakermmtao10.cox.net ([68.230.240.29]:38637 "EHLO
	lakermmtao10.cox.net") by vger.kernel.org with ESMTP
	id S261418AbUEVOgh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 May 2004 10:36:37 -0400
Message-ID: <32847.192.168.0.243.1085236590.squirrel@webmail.rtwsecurenet.com>
Date: Sat, 22 May 2004 09:36:30 -0500 (CDT)
Subject: 2.6 high CPU utilization with multimedia apps {Scanned}
From: rettw@rtwnetwork.com
To: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.2
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
Importance: Normal
X-rtwnetwork.com-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

I have noticed and have read several reports on the net
regarding CPU utilization differences (top displays) when
running multimedia apps on 2.6 versus late 2.4 kernels. 
2.6 running xine/mplayer/vlc etc uses 2-4 times more CPU
than 2.4.24 running the very same applications/media. 
Some of the CPU appears tied up in the "X" process (I am
using the xvideo extension), the rest in the app itself. 
I have seen this on every machine I have tested 2.6 on,
all with 2Ghz+ CPUs.  I have tested 2.6.4, 2.6.5, 2.6.6
vanilla kernels from kernel.org

Is this by design?  It seems strange that these apps
should use so much more CPU power, and honestly it could
make older platforms less capable of playing some media
types than they could before 2.6 without issues.

No one on the X lists, or the lists for the apps
themselves has any input on this, so I figured I would ask
at the source.

Thanks,

Rett Walters

Please CC me directly, as I am not subscribed to the list.
