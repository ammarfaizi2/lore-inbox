Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310816AbSCRNfw>; Mon, 18 Mar 2002 08:35:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310817AbSCRNfm>; Mon, 18 Mar 2002 08:35:42 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:53771 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S310816AbSCRNfY>;
	Mon, 18 Mar 2002 08:35:24 -0500
Date: Mon, 18 Mar 2002 14:34:57 +0100
From: Jens Axboe <axboe@suse.de>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Roberto Nibali <ratz@drugphish.ch>, Andrew Morton <akpm@zip.com.au>,
        linux-kernel@vger.kernel.org
Subject: Re: Question about the ide related ioctl's BLK* in 2.5.7-pre1 kernel
Message-ID: <20020318133457.GJ28106@suse.de>
In-Reply-To: <3C9007F5.1000003@drugphish.ch> <3C900A11.55BA4B32@zip.com.au> <3C905894.90407@drugphish.ch> <3C905B9D.A1E3ACF6@zip.com.au> <3C9091D6.6030301@evision-ventures.com> <3C910262.6010107@drugphish.ch> <3C95EB96.9020803@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18 2002, Martin Dalecki wrote:
[BLKRAGET etc]
> BTW> It's quite propably right now, that I will just reintroduce them
> myself and give them the semantics of the multi-write hardware settings,
> just to fix the multi write PIO problem :-).

What would that fix?

I've still got the multi-write fixes pending, out tomorrow I hope. Other
stuff keeps getting in the way. I haven't forgotten :-)

-- 
Jens Axboe

