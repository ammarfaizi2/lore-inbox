Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272686AbRHaN0r>; Fri, 31 Aug 2001 09:26:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272683AbRHaN0g>; Fri, 31 Aug 2001 09:26:36 -0400
Received: from smtp-server3.tampabay.rr.com ([65.32.1.41]:31733 "EHLO
	smtp-server3.tampabay.rr.com") by vger.kernel.org with ESMTP
	id <S272644AbRHaN0X>; Fri, 31 Aug 2001 09:26:23 -0400
Content-Type: text/plain; charset=US-ASCII
From: Phillip Susi <psusi@cfl.rr.com>
Reply-To: psusi@cfl.rr.com
To: Dan Hollis <goemon@anime.net>
Subject: Re: Athlon doesn't like Athlon optimisation?
Date: Fri, 31 Aug 2001 09:21:36 +0000
X-Mailer: KMail [version 1.2]
In-Reply-To: <Pine.LNX.4.30.0108302117150.16904-100000@anime.net>
In-Reply-To: <Pine.LNX.4.30.0108302117150.16904-100000@anime.net>
Cc: David Hollister <david@digitalaudioresources.org>,
        Jan Niehusmann <jan@gondor.com>, <linux-kernel@vger.kernel.org>,
        <rgooch@atnf.csiro.au>, "Albert D. Cahalan" <acahalan@cs.uml.edu>
MIME-Version: 1.0
Message-Id: <0108310921360A.00999@faldara>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have just such a system and thought I'd note that the stock smp kernels 
that redhat 7.1 and slackware 8.0 installed would lock up intermitently.  I 
couldn't get through a build of the kernel.  I ended up booting into the UP 
kernel, got and built the 2.4.9 kernel, and have not had any trouble since.  
For the processor type, I selected athlon, that enables the optimizations you 
are talking about right?

System specs: dual Athlon MP 1.2 Ghz on Tyan's mobo with the dual ethernet 
and u160 scsi, 512 megs corsair cas 2.5 registered pc2100 ddr sdram, and 
seagate's second generation 15,000 rpm cheetah, using the NMB 460 watt power 
supply that tyan recomended.  

On Friday 31 August 2001 04:20 am, Dan Hollis wrote:
>
> So what happens when someone is able to duplicate the problem on say AMD
> 760MP chipset with registered ECC PC2100 ram and 450W power supply?
>
> Not to say it has happened yet (I havent got my dual Tyan Tiger MP yet :-)
> but where would the finger start pointing then?
>
> -Dan
