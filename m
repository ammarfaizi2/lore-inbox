Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267442AbSLEVEl>; Thu, 5 Dec 2002 16:04:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267439AbSLEVEV>; Thu, 5 Dec 2002 16:04:21 -0500
Received: from windsormachine.com ([206.48.122.28]:11013 "EHLO
	router.windsormachine.com") by vger.kernel.org with ESMTP
	id <S267441AbSLEVBV>; Thu, 5 Dec 2002 16:01:21 -0500
Date: Thu, 5 Dec 2002 16:08:54 -0500 (EST)
From: Mike Dresser <mdresser_l@windsormachine.com>
To: Byron Albert <byron@markerman.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: host buss on p4 xeon 
In-Reply-To: <3DEFBEB7.9080500@markerman.com>
Message-ID: <Pine.LNX.4.33.0212051608030.32292-100000@router.windsormachine.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Dec 2002, Byron Albert wrote:

> Hello,
>
>  I am testing some new dual 2.4/2.8ghz Xeon DP boxes. They all have the
> ServerWorks GC -LE Chipset. I was looking at the dmesg out put and it
> says that the host buss is 100mhz but I in all the docs about the mother
> board it says it should 400. Is this some other number or is there some
> patches I need to get the faster bus speeds?
>
> Thanks
> Byron
>
> ..... CPU clock speed is 2394.9664 MHz.
> ..... host bus clock speed is 99.7902 MHz.
>

On a p4/2.53 here:

..... CPU clock speed is 2558.5372 MHz.
..... host bus clock speed is 134.6596 MHz.

Nope, entirely normal.  Intel mere quad's the input frequency.

Mike

