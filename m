Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288778AbSANNlv>; Mon, 14 Jan 2002 08:41:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289192AbSANNln>; Mon, 14 Jan 2002 08:41:43 -0500
Received: from hq.fsmlabs.com ([209.155.42.197]:41476 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S288778AbSANNl3>;
	Mon, 14 Jan 2002 08:41:29 -0500
Date: Mon, 14 Jan 2002 06:38:50 -0700
From: yodaiken@fsmlabs.com
To: Roman Zippel <zippel@linux-m68k.org>
Cc: yodaiken@fsmlabs.com, Daniel Phillips <phillips@bonn-fries.net>,
        Arjan van de Ven <arjan@fenrus.demon.nl>, linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Message-ID: <20020114063850.C22065@hq.fsmlabs.com>
In-Reply-To: <20020113223438.A19324@hq.fsmlabs.com> <Pine.LNX.4.33.0201141201040.28881-100000@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.LNX.4.33.0201141201040.28881-100000@serv>; from zippel@linux-m68k.org on Mon, Jan 14, 2002 at 12:14:47PM +0100
Organization: FSM Labs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2002 at 12:14:47PM +0100, Roman Zippel wrote:
> Hi,
> 
> On Sun, 13 Jan 2002 yodaiken@fsmlabs.com wrote:
> 
> > 	Nobody has answered my question about the conflict between SMP per-cpu caching
> > 	and preempt. Since NUMA is apparently the future of MP in the PC world and
> > 	the future of Linux servers, it's interesting to consider this tradeoff.
> 
> Preempt is a UP feature so far.

I think this is a sufficient summary of your engineering approach.

 ...

> More of other FUD deleted, Victor, could you please stop this?

I guess that Andrew, Alan, Andrea and I all are raising objections that
you ignore because we  have some kind of shared bias.

-- 
---------------------------------------------------------
Victor Yodaiken 
Finite State Machine Labs: The RTLinux Company.
 www.fsmlabs.com  www.rtlinux.com

