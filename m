Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264372AbUBOIRX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 03:17:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264374AbUBOIRW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 03:17:22 -0500
Received: from may.nosdns.com ([207.44.240.96]:63442 "EHLO may.nosdns.com")
	by vger.kernel.org with ESMTP id S264372AbUBOIRP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 03:17:15 -0500
Date: Sun, 15 Feb 2004 01:16:47 -0700
From: Elikster <elik@webspires.com>
X-Mailer: The Bat! (v2.02.3 CE) Personal
Reply-To: Elikster <elik@webspires.com>
Organization: WebSpires Technologies
X-Priority: 3 (Normal)
Message-ID: <1693736809.20040215011647@webspires.com>
To: linux-kernel@vger.kernel.org
Subject: Re[2]: e1000 problems in 2.6.x
In-Reply-To: <402EE603.8020106@tmr.com>
References: <C6F5CF431189FA4CBAEC9E7DD5441E0102229F6F@orsmsx402.jf.intel.com>
 <20040215023226.GE1040@saturn5.com> <402EE603.8020106@tmr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - may.nosdns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - webspires.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Bill,

    You are not alone.  It happened to all boxes with Intel E1000 network cards and integrated.  It happened on 2.6.2 kernel version and I downgraded back to 2.4.24 version and it was running fine.  The problems I experienced is network lag and lot of network disconnects and such.  It is the kernel 2.6.2 that this problem showed up.

   I haven't tried the latest versions yet that Linus just released to see if they fixed that issue yet.

Saturday, February 14, 2004, 8:22:43 PM, you wrote:

BD> Steve Simitzis wrote:
>> i should have mentioned in my email that i tried every combination of
>> settings: auto-neg on the box and forced on the switch, both forced
>> (to the same settings, of course), forced on the box with auto-neg on
>> the switch, and auto-neg on both sides. in all cases, the result was
>> the same: RX packet errors and the same watchdog messages. what i thought
>> was particularly strange was that the switch refused to auto-negotiate
>> full duplex.



-- 
Best regards,
 Elikster                            mailto:elik@webspires.com

