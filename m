Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315921AbSE2Xws>; Wed, 29 May 2002 19:52:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315805AbSE2XwQ>; Wed, 29 May 2002 19:52:16 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:57106 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S315758AbSE2XwN>; Wed, 29 May 2002 19:52:13 -0400
Date: Thu, 30 May 2002 00:52:07 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: James Simmons <jsimmons@transvirtual.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: Linux 2.5.19
Message-ID: <20020530005207.I30585@flint.arm.linux.org.uk>
In-Reply-To: <20020529211702.E30585@flint.arm.linux.org.uk> <Pine.LNX.4.10.10205291331500.19493-100000@www.transvirtual.com> <20020529214739.F30585@flint.arm.linux.org.uk> <3CF554A1.4090607@evision-ventures.com> <20020530002559.G30585@flint.arm.linux.org.uk> <3CF55941.7060806@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 30, 2002 at 12:42:09AM +0200, Martin Dalecki wrote:
> Well ... they have once excuse... if the maintainer is
> himself a bit slow on submitting to Linus. Yes I know that's
> a matter primary of personal style so there is no need
> to discuss about it until down...

You still don't get the point.

1. Patches from cyber2000fb.c have been submitted and the driver in Linus'
   tree up to 2.5.18 is completely up to date and functional, with zero
   known problems.

2. Someone comes along, scans my patch and finds a change.

3. This person takes it upon themselves to solely take that change,
   and, without querying the person who put out the patch set, or
   the maintainer of the driver, decides to send it to Linus without
   testing it in any way since they don't have the hardware to test it.

4. Maintainer, naturally, gets really pissed off.

If you think this is acceptable, why the hell did I bother sending those
IDE DMA changes through you?  After all, you don't need to know about
them because I know better than you, don't I?  *That's* what you're
advocating here, and I'm sure you're going to object to that.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

