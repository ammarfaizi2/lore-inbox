Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267395AbTAWWFT>; Thu, 23 Jan 2003 17:05:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267421AbTAWWFT>; Thu, 23 Jan 2003 17:05:19 -0500
Received: from gandalf.sch.bme.hu ([152.66.212.141]:8367 "EHLO
	gandalf.sch.bme.hu") by vger.kernel.org with ESMTP
	id <S267395AbTAWWFS>; Thu, 23 Jan 2003 17:05:18 -0500
Date: Thu, 23 Jan 2003 23:14:29 +0100
From: Zsolt Babak <zod@sch.bme.hu>
To: linux-kernel@vger.kernel.org
Subject: Re: Spurious 8259A interrupt: IRQ7 ????
Message-ID: <20030123221428.GA31588@gandalf.sch.bme.hu>
References: <3E2C8EFF.6020707@tin.it> <20030121235339.GB4794@yzero>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
In-Reply-To: <20030121235339.GB4794@yzero>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> i get it on my thinkpad 560e when using a linksys ne2k pcmcia card. i only
> get the message once, and it's triggered after a few seconds of high
> throughput (fast, fd).
> 
Same here with an Acer TravelMate laptop, with an smc pcmcia network card. The
message occures only once at high network load. But the system is quite
stable, so I didn't bother to track this down...

Oh, and the laptop is based on Ali, not on VIA chips.

    Zsolt.
-- 
   "The secret to strong security: less reliance on secrets."
                                                                                
                                       -- Whitfield Diffie --
