Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313328AbSDUARR>; Sat, 20 Apr 2002 20:17:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313336AbSDUARQ>; Sat, 20 Apr 2002 20:17:16 -0400
Received: from bitmover.com ([192.132.92.2]:21144 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S313328AbSDUARP>;
	Sat, 20 Apr 2002 20:17:15 -0400
Date: Sat, 20 Apr 2002 17:17:14 -0700
From: Larry McVoy <lm@bitmover.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Jeff Garzik <garzik@havoc.gtf.org>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Remove Bitkeeper documentation from Linux tree
Message-ID: <20020420171714.A31656@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Roman Zippel <zippel@linux-m68k.org>,
	Jeff Garzik <garzik@havoc.gtf.org>,
	Daniel Phillips <phillips@bonn-fries.net>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <E16ya3u-0000RG-00@starship> <20020420115233.A617@havoc.gtf.org> <3CC19470.ACE2EFA1@linux-m68k.org> <20020420122541.B2093@havoc.gtf.org> <3CC1A31B.AC03136D@linux-m68k.org> <20020420170348.A14186@havoc.gtf.org> <3CC201F7.B3AC3FDF@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 21, 2002 at 02:04:07AM +0200, Roman Zippel wrote:
> kernel development with bk requires net access and so it's sufficient,
> when it's available over the net. On the other hand SubmittingPatches
> describes the lowest common denominator, which works with any SCM and
> doesn't favour any of them.

Huh?  BK requires no more net access than you require when submitting
a regular patch.  You need to be connected to move the bits.  Working
disconnected is one of the things BK does best, compare it to any other
tool and you can do far more with BK unconnected, simply because BK 
takes the history with you.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
