Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267278AbSKPO6X>; Sat, 16 Nov 2002 09:58:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267282AbSKPO6X>; Sat, 16 Nov 2002 09:58:23 -0500
Received: from marcie.netcarrier.net ([216.178.72.21]:61202 "HELO
	marcie.netcarrier.net") by vger.kernel.org with SMTP
	id <S267278AbSKPO6X>; Sat, 16 Nov 2002 09:58:23 -0500
Message-ID: <3DD66036.3129FF70@compuserve.com>
Date: Sat, 16 Nov 2002 10:11:50 -0500
From: Kevin Brosius <cobra@compuserve.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.16-4GB i586)
X-Accept-Language: en
MIME-Version: 1.0
To: kernel <linux-kernel@vger.kernel.org>, David Crooke <dave@convio.com>
Subject: Re: Dual athlon XP 1800 problems
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> 8. Rebooted again, now it's up and running and appears stable (still 1 
> CPU), so I took it up to full init 5 and it stayed up (and so I'm 
> writing this email :-)  Once or twice seemed to stall again for 1-2 
> seconds (interrupt storm ???) but recovered.
> 
> Anyone have suggestions? I'm thinking to leave it running and see if it 
> stays up. Smells of a hardware issue, but also the BIOS seems a bit 
> funny (there is a message in the Help which says "this setting for debug 
> only - remove for production" !!)


I've noticed some oddities on 2.4.19 with a dual Athlon Tyan S2462 that
look like stalls under heavy load.  If you're really curious, you might
try 2.4.18, as this was not a problem there. (I'm running SuSE kernels
shipped with SuSE 8.0 and 8.1, although I saw similar trouble with a
stock 2.4.19 build and stopped using it.  The stalls are only minor
though, so I haven't investigated.  Maybe they are worse on that
motherboard.)

-- 
Kevin
