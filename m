Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262522AbSI0P32>; Fri, 27 Sep 2002 11:29:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262523AbSI0P32>; Fri, 27 Sep 2002 11:29:28 -0400
Received: from beppo.feral.com ([192.67.166.79]:63248 "EHLO beppo.feral.com")
	by vger.kernel.org with ESMTP id <S262242AbSI0P31>;
	Fri, 27 Sep 2002 11:29:27 -0400
Date: Fri, 27 Sep 2002 08:34:25 -0700 (PDT)
From: Matthew Jacob <mjacob@feral.com>
Reply-To: mjacob@feral.com
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
cc: Jens Axboe <axboe@suse.de>, "Pedro M. Rodrigues" <pmanuel@myrealbox.com>,
       Mathieu Chouquet-Stringer <mathieu@newview.com>,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Warning - running *really* short on DMA buffers while doing file
 transfers
In-Reply-To: <389902704.1033133455@aslan.scsiguy.com>
Message-ID: <Pine.BSF.4.21.0209270833450.21876-100000@beppo>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> If you don't like this behavior, which actually maximizes the
> throughput of the device, have the I/O scheduler hold back a single
> processes from creating such a large backlog.


Justin and I are (for once) in 100% agreement.


