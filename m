Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267253AbTAPT5s>; Thu, 16 Jan 2003 14:57:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267255AbTAPT5s>; Thu, 16 Jan 2003 14:57:48 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:30226 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S267253AbTAPT5r>; Thu, 16 Jan 2003 14:57:47 -0500
Date: Thu, 16 Jan 2003 15:04:13 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: "Ivan G." <ivangurdiev@attbi.com>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.58 Oops when booting from initrd - kobject_del
In-Reply-To: <200301140247.40861.ivangurdiev@attbi.com>
Message-ID: <Pine.LNX.3.96.1030116150157.6851C-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Jan 2003, Ivan G. wrote:

> Kernel: 2.5.58 (everything but the tag changeset)
> 
> My attempt to boot an initrd resulted in the following oops:
> (scribbled down important parts)

I have been asking the same question for some weeks, mkinitrd doesn't seem
to create a proper file (at least the RH 8.0) and building by hand doesn't
load the driver for the root f/s. I asked for doc on what's needed for 2.5
initrd (my hand build 2.4 works) without answers. I assume everyone is
just too busy to respond.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

