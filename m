Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263124AbUCSWZz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 17:25:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263127AbUCSWZy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 17:25:54 -0500
Received: from waste.org ([209.173.204.2]:20906 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S263124AbUCSWZy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 17:25:54 -0500
Date: Fri, 19 Mar 2004 16:25:47 -0600
From: Matt Mackall <mpm@selenic.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [CFT] inflate.c rework arch testing needed
Message-ID: <20040319222546.GP11010@waste.org>
References: <20040318231006.GK11010@waste.org> <20040319103126.A12519@flint.arm.linux.org.uk> <20040319171615.GN11010@waste.org> <20040319213957.K14431@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040319213957.K14431@flint.arm.linux.org.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 19, 2004 at 09:39:57PM +0000, Russell King wrote:
> > > There are un-merged patches in the pipeline which make this all work
> > > correctly with todays toolchains - which mostly means getting rid of
> > > all static data to make the compiler produce the right relocations.
> > 
> > Well perhaps you could send them to me.
> 
> I think this is everything...

Ok, I can merge all of this with my stuff without creating any undue pain.
I've actually killed most of it already in the course of eliminating globals.

-- 
Matt Mackall : http://www.selenic.com : Linux development and consulting
