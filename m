Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266079AbRF1SSP>; Thu, 28 Jun 2001 14:18:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266078AbRF1SSJ>; Thu, 28 Jun 2001 14:18:09 -0400
Received: from [209.60.162.25] ([209.60.162.25]:17349 "EHLO wien.coactive.com")
	by vger.kernel.org with ESMTP id <S266079AbRF1SRY>;
	Thu, 28 Jun 2001 14:17:24 -0400
Date: Thu, 28 Jun 2001 11:17:15 -0700 (PDT)
From: Christoph Zens <czens@coactive.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: chuckw@altaserv.net, Aaron Lehmann <aaronl@vitelus.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Vipin Malik <vipin.malik@daniel.com>,
        David Woodhouse <dwmw2@infradead.org>, jffs-dev@axis.com,
        linux-kernel@vger.kernel.org
Subject: Re: Cosmetic JFFS patch.
In-Reply-To: <Pine.LNX.4.33.0106281057170.15199-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.21.0106281111490.19351-100000@rumba.coactive.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Also, in printk's, you waste run-time memory, and you bloat up the need
> for the log size. Both of which are _technical_ reasons not to do it.
> 
> Small is beuatiful.

I totally agree. If you want to use Linux for a small and low cost
embedded system, you can't afford loads of RAM and FLASH space.
Small is the _key_ for those systems.

> 
> 		Linus
> 
> 
> To unsubscribe from this list: send the line "unsubscribe jffs-dev" in
> the body of a message to majordomo@axis.com
> 

-- 
Christoph Zens
czens@coactive.com
(415)-289-7765

