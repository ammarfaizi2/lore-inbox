Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267418AbRGYXau>; Wed, 25 Jul 2001 19:30:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267419AbRGYXak>; Wed, 25 Jul 2001 19:30:40 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:49929
	"EHLO Opus.bloom.county") by vger.kernel.org with ESMTP
	id <S267418AbRGYXa0>; Wed, 25 Jul 2001 19:30:26 -0400
Date: Wed, 25 Jul 2001 16:29:36 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "J . A . Magallon" <jamagallon@able.es>
Cc: Alan Cox <laughing@shared-source.org>,
        Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] i2c update to 2.6.0 for 2.4.7
Message-ID: <20010725162936.E4174@opus.bloom.county>
In-Reply-To: <20010725024629.E2308@werewolf.able.es> <20010724192805.A695@opus.bloom.county> <20010725105716.A6980@werewolf.able.es> <20010726012523.A1656@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010726012523.A1656@werewolf.able.es>
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Thu, Jul 26, 2001 at 01:25:23AM +0200, J . A . Magallon wrote:
> 
> On 20010725 J . A . Magallon wrote:
> >
> >On 20010725 Tom Rini wrote:
> >>On Wed, Jul 25, 2001 at 02:46:29AM +0200, J . A . Magallon wrote:
> >>> Hi.
> >>> 
> >>> This patch updates i2c support in kernel to 2.6.0. I have corrected original patch
> >>> to use slab.h instead of malloc.h, a couple #endif's, and Comfigure.help references
> >>> to other docs in <file:...> format.
> >>
> >>It appears to be missing new files.  The rpx and 405 bits aren't all there.
> >>
> >
> >Correct, the original patch generator skips them, both in 2.6.0 and latest cvs.
> >Why ?
> >Will redo the patch...
> >
> 
> I have been looking at that part, and seems like pretty half-done, even buggy.
> Can't you live without it ?

The code actually works well, it just depends on other things which aren't yet
in Linus' tree but should be soon.  There might be typos however.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
