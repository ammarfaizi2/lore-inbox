Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261290AbTBVOAb>; Sat, 22 Feb 2003 09:00:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261295AbTBVOAb>; Sat, 22 Feb 2003 09:00:31 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:640 "EHLO bilbo.tmr.com")
	by vger.kernel.org with ESMTP id <S261290AbTBVOAa>;
	Sat, 22 Feb 2003 09:00:30 -0500
Date: Sat, 22 Feb 2003 09:10:34 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
X-X-Sender: root@bilbo.tmr.com
Reply-To: Bill Davidsen <davidsen@tmr.com>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: [2.4.21-pre4-ac5] Extreme odd sym53c8xx loading
Message-ID: <Pine.LNX.4.44.0302220904180.1310-100000@bilbo.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dmesg output follows, tail laft few lines are the result of a *manual* 
load of the module. During boot the modules was loaded twice and unloaded 
after some reset actions, dropping all devices. This was after I 
disconnected the tape drive (yes termination was okay, 2.4.19 and 
2.5.61-ac1 have no proble with the CD).

System is RH7.3 install with Rusty modutils 0.9.9pre. Stable with 2.4.19 
or 2.5.{59,61-ac1}.

-- 
bill davidsen, CTO TMR Associates, Inc <davidsen@tmr.com>
  Having the feature freeze for Linux 2.5 on Hallow'een is appropriate,
since using 2.5 kernels includes a lot of things jumping out of dark
corners to scare you.


