Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261656AbSI0HYm>; Fri, 27 Sep 2002 03:24:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261655AbSI0HYm>; Fri, 27 Sep 2002 03:24:42 -0400
Received: from beppo.feral.com ([192.67.166.79]:58127 "EHLO beppo.feral.com")
	by vger.kernel.org with ESMTP id <S261650AbSI0HYk>;
	Fri, 27 Sep 2002 03:24:40 -0400
Date: Fri, 27 Sep 2002 00:29:53 -0700 (PDT)
From: Matthew Jacob <mjacob@feral.com>
Reply-To: mjacob@feral.com
To: Jens Axboe <axboe@suse.de>
cc: "Justin T. Gibbs" <gibbs@scsiguy.com>,
       "Pedro M. Rodrigues" <pmanuel@myrealbox.com>,
       Mathieu Chouquet-Stringer <mathieu@newview.com>,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Warning - running *really* short on DMA buffers while doing file
 transfers
In-Reply-To: <20020927072441.GT5646@suse.de>
Message-ID: <Pine.BSF.4.21.0209270029280.18144-100000@beppo>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 27 Sep 2002, Jens Axboe wrote:

> On Fri, Sep 27 2002, Matthew Jacob wrote:
> > > 
> > > So I think the 'more tags the better!' belief is very much bogus, at
> > > least for the common case.
> > 
> > Well, that's one theory.
> 
> Numbers talk, theory spinning walks
> 
> Both Andrew and I did latency numbers for even small depths of tagging,
> and the result was not pretty. Sure this is just your regular plaino
> SCSI drives, however that's also what I care most about. People with
> big-ass hardware tend to find a way to tweak them as well, I'd like the
> typical systems to run fine out of the box though.
> 

Fair enough. 




