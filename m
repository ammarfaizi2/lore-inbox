Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132842AbRADUmL>; Thu, 4 Jan 2001 15:42:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132565AbRADUmC>; Thu, 4 Jan 2001 15:42:02 -0500
Received: from comunit.de ([195.21.213.33]:25200 "HELO comunit.de")
	by vger.kernel.org with SMTP id <S133045AbRADUln>;
	Thu, 4 Jan 2001 15:41:43 -0500
Date: Thu, 4 Jan 2001 21:41:42 +0100 (CET)
From: Sven Koch <haegar@cut.de>
To: Igmar Palsenberg <maillist@chello.nl>
cc: Andre Hedrick <andre@linux-ide.org>,
        Kernel devel list <linux-kernel@vger.kernel.org>
Subject: Re: 2.2.18 and Maxtor 96147H6 (61 GB)
In-Reply-To: <Pine.LNX.4.21.0101042231120.4090-100000@server.serve.me.nl>
Message-ID: <Pine.LNX.4.30.0101042139270.28511-100000@space.comunit.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Jan 2001, Igmar Palsenberg wrote:

> > You have a hard destroke clipping on the drive.
> > Go look at you logs.
>
> Yep, logs indicate that..
>
> Sven, how did you kill the clipping ??
> Or in generic, how do I kill the clipping ?

I did'nt know something like that even existed :)

Just plugged the drive into the ide controller (single drive on a
promise ata100 in a dec alpha) and it worked.

But I'm booting from SCSI as the machine does not support IDE-drives in
the "bios".

c'ya
sven

-- 

The Internet treats censorship as a routing problem, and routes around it.
(John Gilmore on http://www.cygnus.com/~gnu/)

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
