Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261691AbSI0MNR>; Fri, 27 Sep 2002 08:13:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261658AbSI0MNR>; Fri, 27 Sep 2002 08:13:17 -0400
Received: from beppo.feral.com ([192.67.166.79]:34832 "EHLO beppo.feral.com")
	by vger.kernel.org with ESMTP id <S261607AbSI0MNQ>;
	Fri, 27 Sep 2002 08:13:16 -0400
Date: Fri, 27 Sep 2002 05:18:26 -0700 (PDT)
From: Matthew Jacob <mjacob@feral.com>
Reply-To: mjacob@feral.com
To: Jens Axboe <axboe@suse.de>
cc: "Justin T. Gibbs" <gibbs@scsiguy.com>,
       "Pedro M. Rodrigues" <pmanuel@myrealbox.com>,
       Mathieu Chouquet-Stringer <mathieu@newview.com>,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Warning - running *really* short on DMA buffers while doing file
 transfers
In-Reply-To: <20020927102503.GA15101@suse.de>
Message-ID: <Pine.BSF.4.21.0209270510350.20512-100000@beppo>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[ .. all sorts of nice discussion, but not on our argument point ]
> 
> Agrh. Who's saying 'fix' the hba driver? Either I'm not expressing
> myself very clearly, or you are simply not reading what I write.

I (foolishly) leapt in when you said "253 is 'over the top'". You seemed
to imply that the aic7xxx driver was at fault and should be limiting the
amount it is sending out. My (mostly) only beef with what you've written
is with that implication- mainly as "don't send so many damned commands
if you think they're too many". If the finger pointing at aic7xx is not
what you're implying, then this has been a waste of email bandwidth-
sorry.

-matt


