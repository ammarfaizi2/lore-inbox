Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262539AbSI0RPt>; Fri, 27 Sep 2002 13:15:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262538AbSI0RPl>; Fri, 27 Sep 2002 13:15:41 -0400
Received: from magic.adaptec.com ([208.236.45.80]:18055 "EHLO
	magic.adaptec.com") by vger.kernel.org with ESMTP
	id <S262531AbSI0RP0>; Fri, 27 Sep 2002 13:15:26 -0400
Date: Fri, 27 Sep 2002 11:20:30 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Reply-To: "Justin T. Gibbs" <gibbs@scsiguy.com>
To: Jens Axboe <axboe@suse.de>, Matthew Jacob <mjacob@feral.com>
cc: "Pedro M. Rodrigues" <pmanuel@myrealbox.com>,
       Mathieu Chouquet-Stringer <mathieu@newview.com>,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Warning - running *really* short on DMA buffers while doing
 file transfers
Message-ID: <2484506224.1033147230@aslan.btc.adaptec.com>
In-Reply-To: <20020927153751.GH23468@suse.de>
References: <389902704.1033133455@aslan.scsiguy.com>
 <Pine.BSF.4.21.0209270833450.21876-100000@beppo>
 <20020927153751.GH23468@suse.de>
X-Mailer: Mulberry/3.0.0a4 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm now saying for the 3rd time, that there's zero problem in having a
> huge dirty cache backlog. This is not the problem, please disregard any
> reference to that. Count only the time spent for servicing a read
> request, _from when it enters the drive_ and until it completes. IO
> scheduler is _not_ involved.

On the drive?  That's all I've been saying.

--
Justin
