Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261392AbSJPUfp>; Wed, 16 Oct 2002 16:35:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261393AbSJPUfp>; Wed, 16 Oct 2002 16:35:45 -0400
Received: from packet.digeo.com ([12.110.80.53]:4490 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261392AbSJPUfn>;
	Wed, 16 Oct 2002 16:35:43 -0400
Message-ID: <3DADCEFC.7C17B1CC@digeo.com>
Date: Wed, 16 Oct 2002 13:41:32 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rasmus Andersen <rasmus@jaquet.dk>
CC: linux-kernel@vger.kernel.org
Subject: Re: (2.5.43mm1) Unable to handle kernel paging request
References: <20021016220921.A16005@jaquet.dk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 16 Oct 2002 20:41:32.0700 (UTC) FILETIME=[697875C0:01C27554]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rasmus Andersen wrote:
> 
> Hi,
> 
> Booting 2.5.43mm1, I get the following oops:
> 
> Unable to handle kernel paging request at virtual address 00002004
>  printing eip:
> c01a1ddd
> *pde = 00000000
> Oops: 0002
> 3c59x ide-scsi ide-cd rtc
> CPU:    0
> EIP:    0060:[<c01a1ddd>]    Not tainted
> EFLAGS: 00010246
> EIP is at nfs_proc_fsinfo+0x6d/0x110

Does it happen on 2.5.43?
