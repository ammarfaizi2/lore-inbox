Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132655AbRALUEo>; Fri, 12 Jan 2001 15:04:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132805AbRALUEe>; Fri, 12 Jan 2001 15:04:34 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:2827 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S132655AbRALUEU>;
	Fri, 12 Jan 2001 15:04:20 -0500
Date: Fri, 12 Jan 2001 21:04:11 +0100
From: Jens Axboe <axboe@suse.de>
To: Chris Rankin <rankinc@zipworld.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux-2.4.0-ac7: Unresolved symbol "queued_sectors" in scsi_mod.o
Message-ID: <20010112210411.A18997@suse.de>
In-Reply-To: <200101121953.f0CJrpI13822@wittsend.ukgateway.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200101121953.f0CJrpI13822@wittsend.ukgateway.net>; from rankinc@zipworld.com.au on Fri, Jan 12, 2001 at 07:53:50PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 12 2001, Chris Rankin wrote:
> Hi,
> 
> I have just compiled 2.4.0-ac7, and this kernel boots up OK (no more
> processes missing from the output of "ps -ef", either). However, I am
> now getting an unresolved symbol "queued_sectors" in scsi_mod.o when I
> run depmod.

Fixed in -ac8

-- 
* Jens Axboe <axboe@suse.de>
* SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
