Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965142AbVLVI42@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965142AbVLVI42 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 03:56:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965141AbVLVI42
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 03:56:28 -0500
Received: from smtp.osdl.org ([65.172.181.4]:48825 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965139AbVLVI41 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 03:56:27 -0500
Date: Thu, 22 Dec 2005 00:52:09 -0800
From: Andrew Morton <akpm@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, aabdulla@nvidia.com,
       jgarzik@pobox.com, netdev@vger.kernel.org, ak@suse.de,
       discuss@x86-64.org, perex@suse.cz, alsa-devel@alsa-project.org,
       gregkh@suse.de
Subject: Re: 2.6.15-rc6: known regressions in the kernel Bugzilla
Message-Id: <20051222005209.0b1b25ca.akpm@osdl.org>
In-Reply-To: <20051222011320.GL3917@stusta.de>
References: <Pine.LNX.4.64.0512181641580.4827@g5.osdl.org>
	<20051222011320.GL3917@stusta.de>
X-Mailer: Sylpheed version 2.1.8 (GTK+ 2.8.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@stusta.de> wrote:
>
> The following bugs in the kernel Bugzilla [1] contain regressions in 
> 2.6.15-rc compared to 2.6.14 with patches:

Thanks for tracking this.  Although I fear it won't come to much.

non-bugzilla post-2.6.14 bugs which I've squirelled away include:


From: Brice Goglin <Brice.Goglin@ens-lyon.org>
Subject: Linux 2.6.14: Badness in as-iosched

From: Charles-Edouard Ruault <ce@ruault.com>
Subject: [BUG] kernel 2.6.14.2 breaks IPSEC

From: Michael Madore <michael.madore@gmail.com>
Subject: USB handoff, irq 193: nobody cared!

From: Wu Fengguang <wfg@mail.ustc.edu.cn>
Subject: BUG: spinlock recursion on 2.6.14-mm2 when oprofiling

From: Miles Lane <miles.lane@gmail.com>
Subject: 2.6.15-rc2-git6 + ipw2200 1.0.8 -- Slab corruption

From: "Gottfried Haider" <gohai@gmx.net>
Subject: [2.6.15-rc2] 8139too probe fails (pci related?)

From: Steve Work <swork@aventail.com>
Subject: Multi-thread corefiles broken since April

From: Diego Calleja <diegocg@gmail.com>
Subject: Oops with w9968cf

From: John Reiser <jreiser@BitWagon.com>
Subject: control placement of vDSO page

From: "P. Christeas" <p_christ@hol.gr>
Subject: No sound from CX23880 tuner w. 2.6.15-rc5

Subject: x86_64 timekeeping buglets
From: Jim Houston <jim.houston@comcast.net>

