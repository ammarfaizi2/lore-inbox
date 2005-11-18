Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750729AbVKRPPB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750729AbVKRPPB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 10:15:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750796AbVKRPPB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 10:15:01 -0500
Received: from mail.linicks.net ([217.204.244.146]:21941 "EHLO
	linux233.linicks.net") by vger.kernel.org with ESMTP
	id S1750729AbVKRPPA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 10:15:00 -0500
From: Nick Warne <nick@linicks.net>
To: linux-os (Dick Johnson) <linux-os@analogic.com>
Subject: Re: Compaq Presario "reboot" problems
Date: Fri, 18 Nov 2005 15:14:13 +0000
User-Agent: KMail/1.8.1
Cc: linux-kernel@vger.kernel.org, Ondrej Zary <linux@rainbow-software.org>,
       Denis Vlasenko <vda@ilport.com.ua>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511181514.13467.nick@linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Nov 2005, Denis Vlasenko wrote:

> On Thursday 17 November 2005 20:51, linux-os (Dick Johnson) wrote:
>>
>> With Linux-2.4.26 I reported that if a Compaq gets rebooted while
>> running Linux-2.4.26, it will not be able to restart Windows 2000.
>> It cam restart Linux fine. Today, I tried the same thing with
>> Linux-2.6.13.4. It fails, too.

I am following this thread and this thought just occurred to me.

A few years back I installed Linux on a Compaq box and used fdisk etc. as you 
do.  It turned out I wiped the BIOS settings, and further investigation at 
the time revealed that they use a hidden partition on the drive for the BIOS 
stuff.  I told fdisk to wipe all.

After this, the machine worked ok, just that I had no BIOS options at all - it 
beeped a bit at me at boot, but came up OK and worked for a few years until I 
binned it.

Just a thought on what is going on here.

Nick
-- 
http://sourceforge.net/projects/quake2plus/

"Person who say it cannot be done should not interrupt person doing it."
-Chinese Proverb

