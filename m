Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266330AbSK1RLx>; Thu, 28 Nov 2002 12:11:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266487AbSK1RLx>; Thu, 28 Nov 2002 12:11:53 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:16397 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S266330AbSK1RLv>; Thu, 28 Nov 2002 12:11:51 -0500
Date: Thu, 28 Nov 2002 12:17:58 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Paolo Ciarrocchi <ciarrocchi@linuxmail.org>
cc: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Benchmark] AIM results
In-Reply-To: <r1_20021125114124.13129.qmail@linuxmail.org>
Message-ID: <Pine.LNX.3.96.1021128121311.12997C-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Nov 2002, Paolo Ciarrocchi wrote:

> I can run it for every 2.5.* linus will release. 
> Do you think it is a good idea or just a waste of time ?

As someone who worries about IPC latency (more than speed) I think these
are useful numbers, if only to give some suggestions to kernel developers
who want to get the last bit out and will take them as a challenge. 

The VM stuff in 2.5 is slightly slower, not much to be done there,
hopefully in the real world balanced by more stable performance under
heavy load. 

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

