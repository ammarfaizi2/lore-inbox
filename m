Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264720AbSJUDx1>; Sun, 20 Oct 2002 23:53:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264722AbSJUDx1>; Sun, 20 Oct 2002 23:53:27 -0400
Received: from w032.z064001165.sjc-ca.dsl.cnc.net ([64.1.165.32]:38215 "EHLO
	nakedeye.aparity.com") by vger.kernel.org with ESMTP
	id <S264720AbSJUDx0>; Sun, 20 Oct 2002 23:53:26 -0400
Date: Sun, 20 Oct 2002 21:07:40 -0700 (PDT)
From: "Matt D. Robinson" <yakker@aparity.com>
To: Rusty Russell <rusty@rustcorp.com.au>
cc: Roman Zippel <zippel@linux-m68k.org>, <riel@conectiva.com.br>,
       <linux-kernel@vger.kernel.org>, <akpm@zip.com.au>, <davej@suse.de>,
       <davem@redhat.com>, Guillaume Boissiere <boissiere@adiglobal.com>,
       <mingo@redhat.com>
Subject: Re: 2.6: Shortlist of Missing Features
In-Reply-To: <20021021135137.2801edd2.rusty@rustcorp.com.au>
Message-ID: <Pine.LNX.4.44.0210202105570.13602-100000@nakedeye.aparity.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Oct 2002, Rusty Russell wrote:
|>On Sun, 20 Oct 2002 14:59:58 +0200 (CEST)
|>Roman Zippel <zippel@linux-m68k.org> wrote:
|>> But now would be a good time to recapitulate things which Linus might have
|>> forgotten in the patching frenzy.
|>
|>Yes.  If we only consider new arch-independent features which are actively
|>being pushed at the moment and are feature complete, I get the following
|>(much stolen from Guilluame: thanks!):
|>
|>- Build option for Linux Trace Toolkit (LTT)  (Karim Yaghmour)  
|>- Kernel Probes  (Vamsi Krishna S)
|>- High resolution timers  (George Anzinger, etc.)  
|>- EVMS (Enterprise Volume Management System)  (EVMS team)  
|>- Device Mapper (lvm2)	(Alasdair Kergon, Patrick Caulfield, Joe Thornber)
|>- New config system (Roman Zippel)
|>- In-kernel module loader (Rusty Russell)
|>- Unified boot/parameter support (Rusty Russell)
|>- Hotplug CPU removal (Rusty Russell)
|>- ext2/ext3 extended attribute & ACLs support (Ted Ts'o)
|>
|>The rest (eg. hyperthread-aware scheduler, connection tracking optimizations)
|>don't really qualify as major new features as far as I can tell.

I would think that LKCD fits in here.  It's a feature, and important
to include as far as my team (and a number of distribution and OEMs)
believe.

|>To ensure none of these get simply missed (rather than an actual decision
|>not to include them), it'd be nice to actually get "NAK"s once Linus gets
|>back.  And at least if we have a finite "possible" list, we can judge how
|>frozen we really are.
|>
|>It's a relatively short list: how many am I missing?  (Dave?)
|>Rusty.

Please put LKCD in the list.

--Matt

