Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267348AbTA3C7V>; Wed, 29 Jan 2003 21:59:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267371AbTA3C7V>; Wed, 29 Jan 2003 21:59:21 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:41994 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S267348AbTA3C7U>; Wed, 29 Jan 2003 21:59:20 -0500
Date: Wed, 29 Jan 2003 22:05:51 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Rusty Russell <rusty@rustcorp.com.au>
cc: GertJan Spoelman <kl@gjs.cc>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Trivial: Changes all <module>.o to .ko in Kconfig files 
In-Reply-To: <20030129050522.471442C653@lists.samba.org>
Message-ID: <Pine.LNX.3.96.1030129220355.7114D-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Jan 2003, Rusty Russell wrote:

> I'd prefer just trimming the extension.  "modprobe foo" is what they
> want to know.
> 
> It also sets the prefix of the parameters, when/if they are updated.

I tend to agree with you, but the .o in existing help files is clearly
wrong. Perhaps the patch could be edited to just replace the .ko with
nothing. Yep, it can.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

