Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265936AbTAJSbG>; Fri, 10 Jan 2003 13:31:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265711AbTAJSa1>; Fri, 10 Jan 2003 13:30:27 -0500
Received: from [193.158.237.250] ([193.158.237.250]:25481 "EHLO
	mail.intergenia.de") by vger.kernel.org with ESMTP
	id <S265830AbTAJS3w>; Fri, 10 Jan 2003 13:29:52 -0500
Date: Fri, 10 Jan 2003 19:38:18 +0100
Message-Id: <200301101838.h0AIcIZ05740@mail.intergenia.de>
To: William Lee Irwin III <wli@holomorphy.com>
From: Brian Tinsley <btinsley@emageon.com>
Subject: Re: 2.4.20, .text.lock.swap cpu usage? (ibm x440) [rescued]
CC: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>Okay, can you try with either 2.4.x-aa or 2.5.x-CURRENT?
>
Yes, I *just* booted a machine with 2.4.20-aa1 in our lab. I was having 
problems compiling the Linux Virtual Server code, but it's fixed now. 

>I'm suspecting either bh problems or lowpte problems.
>
>Also, could you monitor your load with the scripts I posted?
>  
>
Yes, they are already uploaded to a customer site and ready to go. I 
need to flex the -aa1 kernel a bit before I load it there as well.


Thanks!


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

