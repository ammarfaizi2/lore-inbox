Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313205AbSDOUZ1>; Mon, 15 Apr 2002 16:25:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313206AbSDOUZ1>; Mon, 15 Apr 2002 16:25:27 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:19973
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S313205AbSDOUZZ>; Mon, 15 Apr 2002 16:25:25 -0400
Date: Mon, 15 Apr 2002 13:18:09 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Rex Tsai <chihchun@kalug.linux.org.tw>
cc: linux-kernel@vger.kernel.org, Andy Jeffries <lkml@andyjeffries.co.uk>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: HPT372A with DMA support ?
In-Reply-To: <Pine.LNX.4.10.10204151854270.25849-100000@kalug>
Message-ID: <Pine.LNX.4.10.10204151317360.1699-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Thanks, I missed that message.
I have a 372 but not tested it yet.

Cheer,

On Mon, 15 Apr 2002, Rex Tsai wrote:

> 
> Hi, I have a HighPoint RocketRAID 133 with HPT372A chipset. 
> (firmware revision is 2.31)
> 
> My currect kernel version is 2.4.19-pre5-ac3, this version contains 
> HighPoint "366", "366",  "368", "370", "370A", "372", "374" support.
> 
> When booting with this kernel I get "hde lost interrupt",  I tried
> hacking the ide drivers myself a little. Now, it works without DMA
> support, I submit my patch to linux kernel mailing list. here is the
> patch http://marc.theaimsgroup.com/?l=linux-kernel&m=101848841720406&w=2
> 
> I still trying to improve on DMA support. Can you offer me 
> any help ? ex. data sheet, manual, driver source code, etc ? 
> 
> Best Regards, 
> Rex Tsai, <chihchun_at_kalug.linux.org.tw>
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Andre Hedrick
LAD Storage Consulting Group

