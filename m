Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263350AbSJFHed>; Sun, 6 Oct 2002 03:34:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263351AbSJFHed>; Sun, 6 Oct 2002 03:34:33 -0400
Received: from ip45.usw1.rb1.pdx.nwlink.com ([207.202.132.45]:44008 "EHLO
	consumption.net") by vger.kernel.org with ESMTP id <S263350AbSJFHed>;
	Sun, 6 Oct 2002 03:34:33 -0400
Date: Sun, 6 Oct 2002 00:58:59 -0700 (PDT)
From: <crozierm@consumption.net>
To: linux-kernel@vger.kernel.org
Subject: keyboard/mouse "freeze" with uhci error in logs
Message-ID: <Pine.LNX.4.21.0210060052510.31233-100000@consumption.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

I'm trying 2.5.40 and frequently my keyboard and mouse are "freezing",
usually accompanying a change in the console (exiting xfree86 or
switching virtual consoles).  Otherwise everything is fine, I can telnet
in and reboot.

This is the message that I found in the logs:

kernel: uhci-hcd.c: ef80: host controller process error. something bad
happened

kernel: uhci-hcd.c: ef80: host controller halted. very bad


If I can provide more information, please email me directly as I'm not on 
the list.

-Michael

-- 


