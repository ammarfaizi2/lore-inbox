Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287106AbSBKEA6>; Sun, 10 Feb 2002 23:00:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287002AbSBKEAt>; Sun, 10 Feb 2002 23:00:49 -0500
Received: from ip68-3-104-241.ph.ph.cox.net ([68.3.104.241]:4480 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S287045AbSBKEAd>;
	Sun, 10 Feb 2002 23:00:33 -0500
Message-ID: <3C6741DF.6040100@candelatech.com>
Date: Sun, 10 Feb 2002 21:00:31 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.4.18-pre9 insmod problems.
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm in the process of bringing my new Tyan Tiger MP machine online.
I compiled 2.4.18-pre9 (Athlon, SMP), and it seemed to go ok.  However, I get
lots of unknown symbol errors when booting.

insmod eepro100 gives:
unresolved symbol del_timer_sync
unresolved symbol synchronize_irq

The USB stuff didn't load either.

Is this a known problem, or do I need to give more details?

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


