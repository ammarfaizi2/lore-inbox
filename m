Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270696AbRHKALE>; Fri, 10 Aug 2001 20:11:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270697AbRHKAKy>; Fri, 10 Aug 2001 20:10:54 -0400
Received: from [24.159.204.122] ([24.159.204.122]:3597 "EHLO
	tweedle.cabbey.net") by vger.kernel.org with ESMTP
	id <S270696AbRHKAKn>; Fri, 10 Aug 2001 20:10:43 -0400
Date: Fri, 10 Aug 2001 19:06:53 -0500 (CDT)
From: Chris Abbey <linux@cabbey.net>
X-X-Sender: <cabbey@tweedle.cabbey.net>
To: <linux-kernel@vger.kernel.org>
Subject: Re: Remotely rebooting a machine with state 'D' processes, how?
In-Reply-To: <20010811095051.A28624@gondor.apana.org.au>
Message-ID: <Pine.LNX.4.33.0108101904350.7726-100000@tweedle.cabbey.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tomorrow, Herbert Xu wrote:
> Perhaps we need a RESTART3 that restarts without notifying?

That would be the one line outb that Chris Wedgewood posted a few notes
back in the thread. If my memory of x86 bios is correct he simple poked
the control register that equates to pushing the reset button.

-- 
now the forces of openness have a powerful and
  unexpected new ally - http://ibm.com/linux

