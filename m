Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267256AbTBUJGd>; Fri, 21 Feb 2003 04:06:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267260AbTBUJGd>; Fri, 21 Feb 2003 04:06:33 -0500
Received: from node181b.a2000.nl ([62.108.24.27]:50081 "EHLO ddx.a2000.nu")
	by vger.kernel.org with ESMTP id <S267256AbTBUJGc>;
	Fri, 21 Feb 2003 04:06:32 -0500
Date: Fri, 21 Feb 2003 10:16:45 +0100 (CET)
From: stephan@a2000.nu
X-X-Sender: kernel@ddx.a2000.nu
To: linux-kernel@vger.kernel.org
Subject: uptime reset on 2.4.11/12 (and maybe newer versions?) at +/- 500
 days ?
Message-ID: <Pine.LNX.4.53.0302211004520.30745@ddx.a2000.nu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

yesterday, 2 machines went back to uptime 0 without a reboot
(think they booted arround the same time)

kernel 2.4.11 and kernel 2.4.12
(redhat 6.2 + updates)

is this a known problem that is fixed in later kernels ?

don't know the exact uptime anymore,
but i have an BitchX (irc client) running since arround the bootup

which shows :

| Client Uptime: 497d 18h 30m 20s

so maybe the uptime jumps back to zero at 497 days ?

current uptime on one machine shows :

 10:09am  up 18:24,  8 users,  load average: 0.61, 0.35, 0.23

(this machine runs 2.4.11)

the other machine (with 2.4.12) :

 10:11am  up 15:13,  2 users,  load average: 4.97, 4.84, 4.76
(load on this machine is also incorrect since yesterday (and top)

