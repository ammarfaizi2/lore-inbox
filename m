Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262504AbVBXVoB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262504AbVBXVoB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 16:44:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262506AbVBXVoA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 16:44:00 -0500
Received: from alog0087.analogic.com ([208.224.220.102]:20352 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262503AbVBXVng
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 16:43:36 -0500
Date: Thu, 24 Feb 2005 16:42:43 -0500 (EST)
From: linux-os <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Linux 2.6.10 sleep mode
Message-ID: <Pine.LNX.4.61.0502241641460.23574@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I put Linux-2.6.10 on a COMPAQ presario 1800 (bad choice).
After a few minutes without any keyboard activity, it enters
"sleep mode" and dies. I need to remove the battery and
external power to be able to re-boot. Even after that,
it needs to be rebooted twice because it will get to
"Uncompressing Linux" and hang. An added data-point:
If I boot Linux, then properly shut down, it will
not boot Linux again unless I hit Ctrl-Alt-Del when
it hangs. The second time, it will boot okay.

The last kernel version that worked properly on
this machine was Linux-2.2.17 SuSE Linux-6.4
It had no such problems.

How do I turn this "feature" OFF?

Cheers,
Dick Johnson
Penguin : Linux version 2.6.10 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
