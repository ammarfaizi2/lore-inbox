Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135210AbREHTL0>; Tue, 8 May 2001 15:11:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135213AbREHTLQ>; Tue, 8 May 2001 15:11:16 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:3078 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S135210AbREHTLG>;
	Tue, 8 May 2001 15:11:06 -0400
Date: Tue, 8 May 2001 21:10:41 +0200
From: Jens Axboe <axboe@suse.de>
To: Thiago Vinhas de Moraes <tvinhas@networx.com.br>
Cc: Ben Fennema <bfennema@ix.netcom.com>, cacook@freedom.net,
        linux-kernel@vger.kernel.org
Subject: Re: write to dvd ram
Message-ID: <20010508211041.M505@suse.de>
In-Reply-To: <91FD33983070D21188A10008C728176C09421202@LDMS6003> <20010508100129.19740@dragon.linux.ix.netcom.com> <20010508195030.J505@suse.de> <01050815594606.01919@zeus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01050815594606.01919@zeus>; from tvinhas@networx.com.br on Tue, May 08, 2001 at 03:59:46PM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 08 2001, Thiago Vinhas de Moraes wrote:
> 
> Hi!
> 
> Can this new UDF driver do cd-rewriting ?

No not in itself, but you can give the pktcdvd module a shot. It can do
rw CD-RW mount so far, at least.

*.kernel.org/pub/linux/kernel/people/axboe/packet/

There's a packet-writing mailing list for the above patch, there is more
info in the tar file above (subscribe info, archives, resources, etc).

-- 
Jens Axboe

