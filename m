Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262608AbSI0VYp>; Fri, 27 Sep 2002 17:24:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262612AbSI0VYo>; Fri, 27 Sep 2002 17:24:44 -0400
Received: from magic.adaptec.com ([208.236.45.80]:51680 "EHLO
	magic.adaptec.com") by vger.kernel.org with ESMTP
	id <S262608AbSI0VYk>; Fri, 27 Sep 2002 17:24:40 -0400
Date: Fri, 27 Sep 2002 15:29:36 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Reply-To: "Justin T. Gibbs" <gibbs@scsiguy.com>
To: James Bottomley <James.Bottomley@steeleye.com>, mjacob@feral.com
cc: Andrew Morton <akpm@digeo.com>, Jens Axboe <axboe@suse.de>,
       "Pedro M. Rodrigues" <pmanuel@myrealbox.com>,
       Mathieu Chouquet-Stringer <mathieu@newview.com>,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Warning - running *really* short on DMA buffers while 
 doingfiletransfers
Message-ID: <2646716224.1033162176@aslan.btc.adaptec.com>
In-Reply-To: <200209272123.g8RLNAi21161@localhost.localdomain>
References: <200209272123.g8RLNAi21161@localhost.localdomain>
X-Mailer: Mulberry/3.0.0a4 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> That was true of 2.2, 2.3 (and I think early 2.4) but it isn't true of
> late  2.4 and 2.5

I have see 0 changes in 2.4 that indicate that it is safe to have the
mid-layer do queuing.

--
Justin

