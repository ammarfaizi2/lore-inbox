Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316246AbSEKSHu>; Sat, 11 May 2002 14:07:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316248AbSEKSHt>; Sat, 11 May 2002 14:07:49 -0400
Received: from ip68-3-14-32.ph.ph.cox.net ([68.3.14.32]:28594 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S316246AbSEKSHs>;
	Sat, 11 May 2002 14:07:48 -0400
Message-ID: <3CDD5DF3.8030306@candelatech.com>
Date: Sat, 11 May 2002 11:07:47 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: APM hangs during boot w/out keyboard plugged in.
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have noticed that the APM initialization always hangs when I
try to boot my various machines w/out the keyboard plugged in.

This is true of many kernels, including the one shipped with RH 7.3.

For now, I have to re-compile the kernel w/out APM support.  Is
there some fundamental problem with using APM w/out a keyboard,
or can the code be fixed?

My motherboard is Intel EEA2, 815 chipset.  If more information
will help, please let me know and I'll provide it.

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


