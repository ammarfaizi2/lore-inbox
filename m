Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318016AbSHVXGs>; Thu, 22 Aug 2002 19:06:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318018AbSHVXGs>; Thu, 22 Aug 2002 19:06:48 -0400
Received: from adsl-64-175-242-3.dsl.sntc01.pacbell.net ([64.175.242.3]:992
	"HELO laura.worldcontrol.com") by vger.kernel.org with SMTP
	id <S318016AbSHVXGr>; Thu, 22 Aug 2002 19:06:47 -0400
From: brian@worldcontrol.com
Date: Thu, 22 Aug 2002 16:10:34 -0700
To: linux-kernel@vger.kernel.org
Subject: 3Ware ok 2.4.19, dies 2.4.19-ac4
Message-ID: <20020822231034.GA4538@top.worldcontrol.com>
Mail-Followup-To: Brian Litzinger <brian@top.worldcontrol.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-No-Archive: yes
X-Noarchive: yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I upgraded a machine with a 3ware RAID controller running 2.2.20 to 
2.4.19-ac1.  The next day it lay dead.  On the screen was a
message about 3ware: AEN overflow.

I upgraded to 2.4.19-ac4.  24 hours later the same message was on
the screen.

I downgraded to 2.4.19 and have had 7 days of uptime.

The load on the machine is very constant.

I've can't say I've done enough testing to confirm that its an ac
issue.  Just something I came across.

-- 
Brian Litzinger
