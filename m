Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262303AbSLARlP>; Sun, 1 Dec 2002 12:41:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262326AbSLARlO>; Sun, 1 Dec 2002 12:41:14 -0500
Received: from tartarus.telenet-ops.be ([195.130.132.34]:15773 "EHLO
	tartarus.telenet-ops.be") by vger.kernel.org with ESMTP
	id <S262215AbSLARlN>; Sun, 1 Dec 2002 12:41:13 -0500
Date: Sun, 1 Dec 2002 18:48:47 +0100 (CET)
From: Michael De Nil <michael@aerythmic.be>
X-X-Sender: linux@lisa.flex-it.be
To: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: /proc/cpuinfo refresh ?
Message-ID: <Pine.LNX.4.50.0212011846060.7628-100000@lisa.flex-it.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hey

does /proc/cpuinfo refreshed something when the system is booted ?
I have here a laptop which should reduce it's clockspeed when the adapter
is removed, but when I look in /proc/cpuinfo it seems it's still running
at full speed.

when I boot linux with adapter disconnected, and then I check, it's ok.
but when I connect the adapter, again nothing changes ... (it stays at the
reduced speed)


thanks
	michael

-----------------------------------------------------------------------
                Michael De Nil -- michael@aerythmic.be
  Linux lisa.flex-it.be 2.4.20-rc1 #4 vr nov 1 13:13:41 CET 2002 i686
  18:46:01 up 30 days,  5:21, 13 users,  load average: 0.04, 0.01, 0.00
-----------------------------------------------------------------------
