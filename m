Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262781AbSIPSbu>; Mon, 16 Sep 2002 14:31:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262782AbSIPSbu>; Mon, 16 Sep 2002 14:31:50 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:8717 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S262781AbSIPSbu>; Mon, 16 Sep 2002 14:31:50 -0400
Date: Mon, 16 Sep 2002 14:29:35 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: contest@kolivas.net
cc: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Possible addition to contest
Message-ID: <Pine.LNX.3.96.1020916142511.6180C-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It would be nice to be able to add a short string to the kernel version
for identification, to differentiate between runs with the same kernel and
different tuning.

I've found that tuning often helps response, like reducing memory with
older rmap versions (ran for a while using mem=256m), or tuning bdflush
with -aa kernels, which I did after Andrea gave me some serious hints.
Just a short string added to the version would make this a bit easier to
follow after the fact.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

