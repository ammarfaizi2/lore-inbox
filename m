Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030290AbWA0ITD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030290AbWA0ITD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 03:19:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030292AbWA0ITD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 03:19:03 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:10255 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1030290AbWA0ITB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 03:19:01 -0500
Date: Fri, 27 Jan 2006 09:21:14 +0100
From: Jens Axboe <axboe@suse.de>
To: Hans Reiser <reiser@namesys.com>
Cc: Edward Shishkin <edward@namesys.com>, LKML <linux-kernel@vger.kernel.org>,
       Reiserfs mail-list <Reiserfs-List@namesys.com>
Subject: Re: random minor benchmark: Re: Copy 20 tarfiles: ext2 vs (reiser4, unixfile) vs (reiser4,cryptcompress)
Message-ID: <20060127082113.GV4311@suse.de>
References: <43D7C6BE.1010804@namesys.com> <43D7CA7F.4010502@namesys.com> <20060126153343.GH4311@suse.de> <43D91225.3030605@namesys.com> <20060126185612.GM4311@suse.de> <43D933EB.6080009@namesys.com> <20060127080625.GS4311@suse.de> <43D9D681.7020002@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43D9D681.7020002@namesys.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27 2006, Hans Reiser wrote:
> Jens Axboe wrote:
> 
> > So the systime quoted above is basically useless, it doesn't reflect the
> >
> >real time spent in the kernel by far. I think you should note that when
> >you post these scores, otherwise you're really showing a skewed picture.
> >
> >  
> >
> He wasn't expecting me to post the benchmark, and I frankly only looked
> at the real time and forgot there was a systime in there that needed
> cutting out when I posted it. My error, not his. I must say though, the
> real time makes me quite happy, especially considering how CPUs are just
> going to keep getting faster.

Yeah and that's ok, I was just interested in seeing some more
interesting compression benchmarks so I wondered if you had done that.

-- 
Jens Axboe

