Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262609AbRFLQ0q>; Tue, 12 Jun 2001 12:26:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262626AbRFLQ0g>; Tue, 12 Jun 2001 12:26:36 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:28938 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262609AbRFLQ0V>; Tue, 12 Jun 2001 12:26:21 -0400
Subject: Re: 3com Driver and the 3XP Processor
To: kmacy@netapp.com (Kip Macy)
Date: Tue, 12 Jun 2001 17:24:41 +0100 (BST)
Cc: brent@biglinux.tccw.wku.edu (Brent D. Norris), kmacy@netapp.com (Kip Macy),
        linux-kernel@vger.kernel.org (Linux Kernel List)
In-Reply-To: <Pine.GSO.4.10.10106111812370.22254-100000@orbit-fe.eng.netapp.com> from "Kip Macy" at Jun 11, 2001 06:18:51 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E159qy9-0001aL-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> My opinion is that if you have to obscure your interface to protect your
> margins because you are making a commodity component then you are in the
> wrong business. Nonetheless they can correctly point out that they are

Cryto hardware is commodity. In fact its questionable it has any value below
1Gbit/second anyway because the cheapest low speed crypto coprocessors are
made by AMD and intel. They fit into the second socket on your dual cpu
motherboard and as well as being mass market are conveinently reprogrammable
and able to run your applications when not doing crypto. The cheapest raid
accelerator is the same story. It costs a lot of money to build custom
hardwae, an x86 is the wrong solution but its sufficiently large a hamemr
that it works better than the elegant approach for most cases.

> still making a lot more money than I am :-).

That I doubt looking at recent financial reports

But I'd be inclined to ask 3com 

   What other large company helped design the interface and owns some of the IP
   Does that other company have an interest in the OS business.

I don't know for sure but I suspect that would give a most interesting answer

