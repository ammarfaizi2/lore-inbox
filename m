Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314885AbSD2IVm>; Mon, 29 Apr 2002 04:21:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314887AbSD2IVl>; Mon, 29 Apr 2002 04:21:41 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:55044 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S314885AbSD2IVk>;
	Mon, 29 Apr 2002 04:21:40 -0400
Date: Mon, 29 Apr 2002 10:21:39 +0200
From: Jens Axboe <axboe@suse.de>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.10 IDE 41
Message-ID: <20020429082139.GE3542@suse.de>
In-Reply-To: <Pine.LNX.4.33.0203181243210.10517-100000@penguin.transmeta.com> <3CC8136B.2060705@evision-ventures.com> <20020425173908.GN3542@suse.de> <3CC83A7B.40800@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25 2002, Martin Dalecki wrote:
> >If you want to disable the TCQ stuff until this is fixed, fine, I have
> >no objection to that. Completely ripping it out is a silly decision.
> 
> Again: what's the problem? - You still have it there at hand.
> Nothing is lost.

That's bullshit, lots of time is needlessly lost because merging with
the ide tree is such a huge pain these days.

-- 
Jens Axboe

