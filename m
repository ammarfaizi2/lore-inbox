Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268560AbRHKQZT>; Sat, 11 Aug 2001 12:25:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268564AbRHKQZA>; Sat, 11 Aug 2001 12:25:00 -0400
Received: from lanm-pc.com ([64.81.97.118]:15350 "EHLO golux.thyrsus.com")
	by vger.kernel.org with ESMTP id <S268560AbRHKQYv>;
	Sat, 11 Aug 2001 12:24:51 -0400
Date: Sat, 11 Aug 2001 12:22:18 -0400
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Alex Buell <alex.buell@tahallah.demon.co.uk>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel lockups on dual-Athlon board -- help wanted
Message-ID: <20010811122218.E6024@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Alex Buell <alex.buell@tahallah.demon.co.uk>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <20010811062349.A1769@thyrsus.com> <Pine.LNX.4.33.0108111145530.4433-100000@tahallah.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0108111145530.4433-100000@tahallah.demon.co.uk>; from alex.buell@tahallah.demon.co.uk on Sat, Aug 11, 2001 at 11:46:14AM +0100
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Buell <alex.buell@tahallah.demon.co.uk>:
> On Sat, 11 Aug 2001, Eric S. Raymond wrote:
> 
> > 6. Here's a weird one.  When the kernel is running, the power switch
> >    has to be pressed down for 4 seconds to power down the machine.  But
> >    during a lockup it powers down the machine instantly.
> >
> > What we're seeing suggests some bad interaction between the SMP
> > support and the hardware.  But item 7 hints that power management
> > could be involved, even though we have it configured out.
> 
> You appear to be missing item 7.

It was 0400 and I was fried.  I was referring to the item 6 you quoted.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

Militias, when properly formed, are in fact the people themselves and
include all men capable of bearing arms. [...] To preserve liberty it is
essential that the whole body of the people always possess arms and be
taught alike, especially when young, how to use them.
        -- Senator Richard Henry Lee, 1788, on "militia" in the 2nd Amendment
