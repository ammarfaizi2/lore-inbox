Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131208AbRAHXIr>; Mon, 8 Jan 2001 18:08:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135605AbRAHXIh>; Mon, 8 Jan 2001 18:08:37 -0500
Received: from linuxcare.com.au ([203.29.91.49]:17670 "EHLO
	front.linuxcare.com.au") by vger.kernel.org with ESMTP
	id <S131208AbRAHXIZ>; Mon, 8 Jan 2001 18:08:25 -0500
From: Rusty Russell <rusty@linuxcare.com.au>
To: ed@alcpress.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: ipchains vs netfilter performance 
In-Reply-To: Your message of "Sun, 07 Jan 2001 12:14:23 -0800."
             <3A585D9F.21907.1452FA04@localhost> 
Date: Mon, 08 Jan 2001 22:37:15 +1100
Message-Id: <E14Fabz-0007ig-00@halfway>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <3A585D9F.21907.1452FA04@localhost> you write:
> I've noticed that my Linux boxes take quite a hit in terms of
> packets per second rate when I define ipchains rules with
> 2.2.X kernels. Does the netfilter replacement found in 2.4
> kernels improve this performance?

Not really.  What are your rules?

Rusty.
--
http://linux.conf.au The Linux conference Australia needed.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
