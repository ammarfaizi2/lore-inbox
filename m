Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315856AbSE2X0J>; Wed, 29 May 2002 19:26:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315862AbSE2X0I>; Wed, 29 May 2002 19:26:08 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:36882 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S315856AbSE2X0G>; Wed, 29 May 2002 19:26:06 -0400
Date: Thu, 30 May 2002 00:25:59 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: James Simmons <jsimmons@transvirtual.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: Linux 2.5.19
Message-ID: <20020530002559.G30585@flint.arm.linux.org.uk>
In-Reply-To: <20020529211702.E30585@flint.arm.linux.org.uk> <Pine.LNX.4.10.10205291331500.19493-100000@www.transvirtual.com> <20020529214739.F30585@flint.arm.linux.org.uk> <3CF554A1.4090607@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 30, 2002 at 12:22:25AM +0200, Martin Dalecki wrote:
> Dear Russell why don't you just abuse Linus as a spinlock for this kind
> of synchronization its his job. No need to get angry at this.
> Hey it's developement series time...

The fundamental point I'm making is people shouldn't go around taking
changes randomly from maintainers trees, and believing that they know
far better than the maintainer what they're doing, especially when they
don't have the hardware to even try it out, and go submitting these
changes to Linus without even asking about it first...  after the
maintainer has been very careful and explicitly not submitted
the change because they have very good reasons not to.

What if I were to take, say, Mochel's experimental tree and send some
random alpha code to Linus?  Let anarchy rule!

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

