Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267453AbTAHNPL>; Wed, 8 Jan 2003 08:15:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267457AbTAHNPK>; Wed, 8 Jan 2003 08:15:10 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:20230 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP
	id <S267453AbTAHNPK>; Wed, 8 Jan 2003 08:15:10 -0500
Date: Wed, 8 Jan 2003 08:23:45 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
X-X-Sender: root@oddball.prodigy.com
Reply-To: Bill Davidsen <davidsen@tmr.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [BUG] 2.5.52
Message-ID: <Pine.LNX.4.44.0301080820130.15749-100000@oddball.prodigy.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Running 2.5.52 (unpatched) I see these mesages on the console. I didn't 
see them right a boot time, but they are there in the morning (about 8 
hours later).

set_rtc_mmss: can't update from 1 to 56
set_rtc_mmss: can't update from 3 to 57
set_rtc_mmss: can't update from 5 to 58
set_rtc_mmss: can't update from 6 to 59

The system is running ntpd against a stratum three server, APM has system 
time in GMT, let me know if any other info is useful, I may not run this 
kernel again unless someone cares about this message.

-- 
bill davidsen <davidsen@tmr.com>
 

