Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132622AbRAFSY1>; Sat, 6 Jan 2001 13:24:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132630AbRAFSYQ>; Sat, 6 Jan 2001 13:24:16 -0500
Received: from [200.199.222.5] ([200.199.222.5]:45580 "EHLO
	strauss.mileniumnet.com.br") by vger.kernel.org with ESMTP
	id <S132622AbRAFSX4>; Sat, 6 Jan 2001 13:23:56 -0500
Date: Sat, 6 Jan 2001 14:26:09 -0200 (BRST)
From: Thiago Rondon <maluco@mileniumnet.com.br>
To: TenThumbs <tenthumbs@cybernex.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.2.19pre6 change in /proc behavior
In-Reply-To: <Pine.LNX.4.21.0101061230450.239-100000@perfect.master>
Message-ID: <Pine.LNX.4.21.0101061423460.13574-100000@freak.mileniumnet.com.br>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


At 2.4 too, but the status of file is o+r. Do see any
problem about this?

-Thiago Rondon

On Sat, 6 Jan 2001, TenThumbs wrote:

> Let's say a normal user has started a process with pid =
> 12345. /proc/12345 owner and group is the same as the user but
> /proc/12345/* are all owned by root so the normal user can't read most
> of the entries there. In 2.2.18 everything is owned by the user.
> 
> Is this supposed to be happening?
> 
> Thanks.
> 
> -- 
> Sun
>     2001-01-06 17:30:47.031 UTC (JD 2451916.229711)
>     X  =  -0.004587559, Y  =  -0.004598857, Z  =  -0.001825999
>     X' =   0.000008151, Y' =  -0.000003497, Z' =  -0.000001714
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
> 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
