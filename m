Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267845AbTBYUIR>; Tue, 25 Feb 2003 15:08:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268220AbTBYUIR>; Tue, 25 Feb 2003 15:08:17 -0500
Received: from uni00du.unity.ncsu.edu ([152.1.13.100]:35723 "EHLO
	uni00du.unity.ncsu.edu") by vger.kernel.org with ESMTP
	id <S267845AbTBYUIR>; Tue, 25 Feb 2003 15:08:17 -0500
From: jlnance@unity.ncsu.edu
Date: Tue, 25 Feb 2003 15:18:32 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: Minutes from Feb 21 LSE Call
Message-ID: <20030225201832.GA9442@ncsu.edu>
References: <20030225051956.GA18302@f00f.org> <FKEAJLBKJCGBDJJIPJLJMEOOEPAA.scott@coyotegulch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <FKEAJLBKJCGBDJJIPJLJMEOOEPAA.scott@coyotegulch.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2003 at 02:59:05PM -0500, Scott Robert Ladd wrote:
> > In two year this kind of hardware probably will be SMP (HT or some
> > variant).
> 
> HT is not the same thing as SMP; while the chip may appear to be two
> processors, it is actually equivalent 1.1 to 1.3 processors, depending on
> the application.
> 
> Multicore processors and true SMP systems are unlikely to become mainstream
> consumer items, given the premium price charged for such systems.

I think the difference between SMP and HT is likely to decrease rather
than increase in the future.  Even now people want to put multiple CPUs
on the same piece of silicon.  Once you do that it only makes sense to
start sharning things between them.  If you had a system with 2 CPUs
which shared a common L1 cache is that going to be a HT or an SMP system?
Or you could go further and have 2 CPUs which share an FPU.  There are
all sorts of combinations you could come up with.  I think designers
will experiment and find the one that gives the most throughput for
the least money.

Jim
