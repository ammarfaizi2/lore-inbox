Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289193AbSA2NCj>; Tue, 29 Jan 2002 08:02:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288958AbSA2NCa>; Tue, 29 Jan 2002 08:02:30 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:58642 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S288810AbSA2NCV>; Tue, 29 Jan 2002 08:02:21 -0500
Subject: Re: A modest proposal -- We need a patch penguin
To: mingo@elte.hu
Date: Tue, 29 Jan 2002 13:14:43 +0000 (GMT)
Cc: dalecki@evision-ventures.com (Martin Dalecki),
        torvalds@transmeta.com (Linus Torvalds), linux-kernel@vger.kernel.org,
        axboe@suse.de (Jens Axboe)
In-Reply-To: <Pine.LNX.4.33.0201291527310.5560-100000@localhost.localdomain> from "Ingo Molnar" at Jan 29, 2002 03:33:34 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16VY5z-0003sn-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> rapidly. Sometimes keeping broken code around as an incentive to fix it
> *for real* is better than trying to massage the broken code somewhat.
> 
> a patch penguin doesnt solve this particular problem, by definition he
> just wont fix the block IO code.

Ingo, you should have a look at my mailbox and the people sick of trying to
get Linus to take 3 liners to fix NODEV type stuff and being ignored so that
2.5.* still doesn't even compile or boot for many people.

Dave in doing the patch hoovering at least ensures these are picked up. You
think if this carries on anyone will be running Linus tree in 9 months ?
