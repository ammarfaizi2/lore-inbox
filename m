Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262771AbTC0Cwx>; Wed, 26 Mar 2003 21:52:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262789AbTC0Cwx>; Wed, 26 Mar 2003 21:52:53 -0500
Received: from palrel12.hp.com ([156.153.255.237]:5047 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id <S262771AbTC0Cww>;
	Wed, 26 Mar 2003 21:52:52 -0500
Date: Wed, 26 Mar 2003 19:04:02 -0800
To: Joshua Kwan <joshk@triplehelix.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: WE16 patch for 2.5.66
Message-ID: <20030327030402.GA24533@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20030327025914.GA1035@firesong>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030327025914.GA1035@firesong>
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 26, 2003 at 06:59:14PM -0800, Joshua Kwan wrote:
> It's me again, since my old patch started failing in net/netsyms.c.
> So anyway, this patch will cleanly update your Wireless Extension
> to version 16, diffed against the vanilla 2.5.66 kernel.
> 
> You can retrieve it at:
> http://triplehelix.org/~joshk/linux/we15_2.5.66-we16.patch.bz2
> 
> It is best used with wireless-tools 26-pre7, to take advantage of
> what WE16 actually does different from v15 which is already in the
> kernel.
> 
> This is obviously still in testing, since Jean hasn't had it merged
> with the main tree. Use at your own risk. :)
> 
> Regards
> Josh

	Jeff has been sitting on my last set of patches for one month,
so I'm doing other things while waiting for him.
	Do you have any need for the new features in WE-16 ? If yes,
tell me about it, I'm always open to feedback.
	Thanks...

	Jean

