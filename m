Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282140AbRK1PFq>; Wed, 28 Nov 2001 10:05:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282156AbRK1PFf>; Wed, 28 Nov 2001 10:05:35 -0500
Received: from node10450.a2000.nl ([24.132.4.80]:61312 "EHLO awacs.dhs.org")
	by vger.kernel.org with ESMTP id <S282908AbRK1PFY>;
	Wed, 28 Nov 2001 10:05:24 -0500
Date: Wed, 28 Nov 2001 16:05:23 +0100
From: Pascal Haakmat <a.haakmat@chello.nl>
To: linux-kernel@vger.kernel.org
Subject: Re: [CRASH (kswapd)]: Unable to handle kernel NULL pointer dereference at virtual address 00000018
Message-ID: <20011128160523.A7856@awacs.dhs.org>
In-Reply-To: <20011128043636.A4128@awacs.dhs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011128043636.A4128@awacs.dhs.org>; from a.haakmat@chello.nl on Wed, Nov 28, 2001 at 04:36:36AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

28/11/01 04:36, Pascal Haakmat wrote:

> Linux 2.4.14 with XFS 1.0.2 patch (but without kdb patch) crashed on me
> today. The on screen crash dump said something about kswapd.
> 
> I managed to salvage the following information from the screen before the
> screen went black (courtesy of the screen blanker?). I didn't find any way
> to get the display back so the rest of the information was lost:

[snip]

Some people suggested I should get the Oops information from
/var/log/messages. I should have mentioned that the Oops turns up nowhere in
the logfiles. 

I did find a couple of (XFS-related?) Oopses that I hadn't noticed before
though. See the thread "XFS Oopses with 2.4.5 and 2.4.14?".  I am starting
to wonder whether it is a good idea to run XFS. Thanks.
