Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290300AbSAXVKv>; Thu, 24 Jan 2002 16:10:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290301AbSAXVKl>; Thu, 24 Jan 2002 16:10:41 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:62993 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S290300AbSAXVKa>; Thu, 24 Jan 2002 16:10:30 -0500
Message-ID: <3C5076C1.DDEE200B@zip.com.au>
Date: Thu, 24 Jan 2002 13:04:01 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Anish Srivastava <anishs@vsnl.com>
CC: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrea Arcangeli <andrea@suse.de>,
        Rik van Riel <riel@conectiva.com.br>, alan@lxorguk.ukuu.org.uk
Subject: Re: kernel 2.4.17 with -rmap VM patch ROCKS!!!
In-Reply-To: <008301c1a4c1$a79f8fa0$3c00a8c0@baazee.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anish Srivastava wrote:
> 
> Hi!
> 
> I installed kernel 2.4.17 on my SMP server with 8CPU's and 8GB RAM
> and lets just say that whenever the entire physical memory was utilised
> the box would topple over...with kswapd running a havoc on CPU utilization
> So to avoid losing control I had to reboot every 8 hours.
> 

The fact that the current stable version of the Linux kernel
can only achieve an eight-hour uptime on this class of machine
is a fairly serious problem, don't we all agree?

We need a fix for 2.4.18.

Did you test the -aa patches?

-
