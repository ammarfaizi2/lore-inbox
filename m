Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293532AbSBZHVG>; Tue, 26 Feb 2002 02:21:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293534AbSBZHU4>; Tue, 26 Feb 2002 02:20:56 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:47626 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S293532AbSBZHUg>;
	Tue, 26 Feb 2002 02:20:36 -0500
Date: Tue, 26 Feb 2002 08:20:21 +0100
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@zip.com.au>
Cc: Ken Brownfield <brownfld@irridia.com>,
        Dieter =?iso-8859-1?Q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.19-preX: What we really need: -AA patches finally in the tree
Message-ID: <20020226072021.GC11837@suse.de>
In-Reply-To: <200202260135.18913.Dieter.Nuetzel@hamburg.de> <20020225190241.C26077@asooo.flowerfire.com> <3C7AE123.97A92EA0@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C7AE123.97A92EA0@zip.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 25 2002, Andrew Morton wrote:
> Ken Brownfield wrote:
> > 
> > ...
> > It should be in it's own release separate from other major changes at
> > least, IMHO, if the backport is desired by enough folk to outweigh the
> > largish change.  And I definitely have VM _way_ higher up my personal
> > list. :)
> > 
> 
> I intend to chunk up the -aa VM patch and feed it into 2.4.19-pre.
> I think Andrea's OK with that.   Just the VM and buffercache bits.
> Something also needs to be done about block-highmem and pte-highmem.

I've recommended block-highmem before, and I can do it again. If it
needs to be split a bit (I don't really think it does, though), I can
even do that too.

-- 
Jens Axboe

