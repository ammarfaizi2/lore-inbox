Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129061AbQKON4K>; Wed, 15 Nov 2000 08:56:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129895AbQKON4A>; Wed, 15 Nov 2000 08:56:00 -0500
Received: from chiara.elte.hu ([157.181.150.200]:9487 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S129061AbQKONzr>;
	Wed, 15 Nov 2000 08:55:47 -0500
Date: Wed, 15 Nov 2000 15:35:46 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: mingo@elte.hu
To: Andrew Morton <andrewm@uow.edu.au>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [prepatch] removal of oops->printk deadlocks
In-Reply-To: <3A128E4D.32D81784@uow.edu.au>
Message-ID: <Pine.LNX.4.21.0011151534560.4711-100000@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 16 Nov 2000, Andrew Morton wrote:

> OK, so the options are now:
> 
> 	nmi_watchdog=0
> 	nmi_watchdog=1
> 	nmi_watchdog=1,verbose

looks good for me!

	Ingo

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
