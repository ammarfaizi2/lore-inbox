Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281330AbRKQLUu>; Sat, 17 Nov 2001 06:20:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281331AbRKQLUb>; Sat, 17 Nov 2001 06:20:31 -0500
Received: from marao.utad.pt ([193.136.40.3]:31755 "EHLO marao.utad.pt")
	by vger.kernel.org with ESMTP id <S281330AbRKQLU3> convert rfc822-to-8bit;
	Sat, 17 Nov 2001 06:20:29 -0500
Subject: Re: Swap Usage with Kernel 2.4.14
From: Alvaro Lopes <alvieboy@alvie.com>
To: war <war@starband.net>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3BF5B275.215D6D44@starband.net>
In-Reply-To: <3BF5B275.215D6D44@starband.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution/0.99.0 (Preview Release)
Date: 17 Nov 2001 11:18:55 +0000
Message-Id: <1005995937.694.0.camel@dwarf>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sáb, 2001-11-17 at 00:42, war wrote:
> Regular usage on my box, launching netscape, opera, pan, xchat, gaim;
> the kernel eventually digs into swap.
> 
> However, the swap is never released?
> 
> Mem:   900596K av,  185896K used,  714700K free,       0K shrd,    4172K
> buff
> Swap: 2048276K av,   63728K used, 1984548K free                   91176K
> cached
> 
> Are there any settings I should have set or be aware of?
> 
> I current use 4GB support, 1GB of ram, 2GB of swap.
> 
> Having 1GB, I thought I had enough memory for basic operations without
> the disk swapping like mad.
> 

AFAIK with 2.4.14 processes can be in memory and swap at the same time. 

> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


