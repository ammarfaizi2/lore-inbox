Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290289AbSCOK7y>; Fri, 15 Mar 2002 05:59:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290120AbSCOK6U>; Fri, 15 Mar 2002 05:58:20 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:13840 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S290277AbSCOK6F>;
	Fri, 15 Mar 2002 05:58:05 -0500
Date: Fri, 15 Mar 2002 11:57:56 +0100
From: Jens Axboe <axboe@suse.de>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFT] simple deadline I/O scheduler
Message-ID: <20020315105756.GC22169@suse.de>
In-Reply-To: <20020104094334.N8673@suse.de> <E16l8sQ-0000EX-00@starship> <20020314073216.GB30351@suse.de> <E16lXVY-0000Rn-00@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E16lXVY-0000Rn-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 14 2002, Daniel Phillips wrote:
> On March 14, 2002 08:32 am, Jens Axboe wrote:
> > On Wed, Mar 13 2002, Daniel Phillips wrote:
> > > Andrew Morton is also working in here, with a collection of ideas that I hope 
> > > are complementary if looked at the right way.  See his '[patch] delayed disk 
> > > block allocation' post.
> > 
> > Right, I noticed. We could get good write clustering in general with vm
> > merging, though.
> 
> Sorry, I can't parse that, do you mean 'if the elevator merging is merged with
> vm's' or 'if vm does merging' or... ?

Heh, guess it wasn't too clear. It was supposed to say 'if vm does the
merging' or at least partially does it.

-- 
Jens Axboe

