Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262886AbSJGFvL>; Mon, 7 Oct 2002 01:51:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262889AbSJGFvL>; Mon, 7 Oct 2002 01:51:11 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:12160 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S262886AbSJGFvK>;
	Mon, 7 Oct 2002 01:51:10 -0400
Date: Mon, 7 Oct 2002 07:56:37 +0200
From: Jens Axboe <axboe@suse.de>
To: Jure Repinc <jlp@holodeck1.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Support for Mount Rainier / Packet Writing
Message-ID: <20021007055637.GD1738@suse.de>
References: <3DA09C34.4070709@holodeck1.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DA09C34.4070709@holodeck1.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 06 2002, Jure Repinc wrote:
> Hi all.
> 
> Now that feature freeze is just around the corner I would like to ask 
> you if we will get support for packet writing in the 2.6/3.0 kernel. It 
> would be especialy nice to have support for Mount Rainier which enables 
> easy use of CD-RWs and that would help people (especially newbies) that 
> use CD-RWs a lot.
> 
> There are some patches from Jens Axboe that are available here:
> http://w1.894.telia.com/~u89404340/patches/packet/2.5/

These are for CD-RW transparent writing, not cd-mrw.

> Are patches these OK for this or would support have to be completely 
> rewriten?

I had patches for 2.4 that enable mt rainier support in ide-cd and sr,
they need to be polished a bit and submitted. I don't view the feature
freeze as a big problem here, it's just minor additions to the cd-rom
driver so...

-- 
Jens Axboe

