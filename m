Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129385AbQKVXFv>; Wed, 22 Nov 2000 18:05:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129485AbQKVXFl>; Wed, 22 Nov 2000 18:05:41 -0500
Received: from mail-out.chello.nl ([213.46.240.7]:19755 "EHLO
        amsmta06-svc.chello.nl") by vger.kernel.org with ESMTP
        id <S129385AbQKVXF2>; Wed, 22 Nov 2000 18:05:28 -0500
Date: Thu, 23 Nov 2000 00:43:08 +0100 (CET)
From: Igmar Palsenberg <maillist@chello.nl>
To: Andreas Schwab <schwab@suse.de>
cc: Pauline Middelink <middelink@polyware.nl>, linux-kernel@vger.kernel.org
Subject: Re: linux-2.2.18-pre19 asm/delay.h problem?
In-Reply-To: <200011221649.eAMGnDr23208@hawking.suse.de>
Message-ID: <Pine.LNX.4.21.0011230042420.28000-100000@server.serve.me.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> |> > > #define __bad_udelay() panic("Udelay called with too large a constant")
> |> 
> |> Can't we change that to :
> |> #error "Udelay..."
> 
> No.

?? I think I'm missing something here.

 
> Andreas.


	Igmar

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
