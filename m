Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264779AbSK0UlI>; Wed, 27 Nov 2002 15:41:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264785AbSK0UlI>; Wed, 27 Nov 2002 15:41:08 -0500
Received: from dhcp101-dsl-usw4.w-link.net ([208.161.125.101]:25985 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S264779AbSK0UlH>;
	Wed, 27 Nov 2002 15:41:07 -0500
Message-ID: <3DE52F8F.3090604@candelatech.com>
Date: Wed, 27 Nov 2002 12:48:15 -0800
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2a) Gecko/20020910
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Steven Timm <timm@fnal.gov>
CC: linux-kernel@vger.kernel.org
Subject: Re: Tyan 2466, 2468 BIOS setting
References: <Pine.LNX.4.31.0211271302250.5024-100000@boxer.fnal.gov>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Timm wrote:
> In a number of boards with Phoenix BIOS including
> the Tyan S2466 and S2468, there is a setting in the BIOS
> for "Large Disk Access Mode", the available settings are
> "DOS" and "Other".  Tyan docs suggest selecting "other".
> 
> These boards use the AMD 760MPX chipset. (dmesg output is below).
> My question...is anyone aware of (1) does the kernel look
> at this BIOS option at all, and if so (2) could having
> it set to DOS instead of Other lead to any
> data corruption?
> 
> Steve Timm

These settings definately make a difference, or did 6 months ago
when I was mucking with a system based on this MB.
DOS == Crash and/or file system corruption on install.

Ben

-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


