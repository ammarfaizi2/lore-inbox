Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261508AbSJAHec>; Tue, 1 Oct 2002 03:34:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261510AbSJAHec>; Tue, 1 Oct 2002 03:34:32 -0400
Received: from [212.3.242.3] ([212.3.242.3]:51184 "HELO mail.vt4.net")
	by vger.kernel.org with SMTP id <S261508AbSJAHec>;
	Tue, 1 Oct 2002 03:34:32 -0400
Content-Type: text/plain; charset=US-ASCII
From: DevilKin <devilkin-lkml@blindguardian.org>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.5.40 - and a feature freeze reminder
Date: Tue, 1 Oct 2002 09:39:53 +0200
User-Agent: KMail/1.4.1
References: <Pine.LNX.4.33.0210010021400.25527-100000@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0210010021400.25527-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210010939.53707.devilkin-lkml@blindguardian.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 01 October 2002 09:32, Linus Torvalds wrote:
<snip>
> And if it wasn't clear to the non-2.5-development people out there, yes
> you _should_ also test this code out even before the freeze. The IDE layer
> shouldn't be all that scary any more, and while there are still silly
> things like trivially non-compiling setups etc, it's generally a good idea
> to try things out as widely as possible before it's getting too late to
> complain about things..

Basically: I would _love_ to test this kernel on my laptop here, but - 
unfortunately - i need the laptop for my work. Which means i need it to work.

So how much chance IS there to trash the filesystems? I guess a lot of ppl 
like me are just waiting to test it out, but aren't willing to screw their 
systems over it...

DK
-- 
There's no easy quick way out, we're gonna have to live through our
whole lives, win, lose, or draw.
		-- Walt Kelly

