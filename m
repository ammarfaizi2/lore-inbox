Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293132AbSDDSkZ>; Thu, 4 Apr 2002 13:40:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292957AbSDDSkP>; Thu, 4 Apr 2002 13:40:15 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:19972 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S293132AbSDDSkE>; Thu, 4 Apr 2002 13:40:04 -0500
Date: Thu, 4 Apr 2002 13:37:11 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Andre Pang <ozone@algorithm.com.au>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.4.19-pre5 KL133/KM133 problems (screen corruption/MWQ)
In-Reply-To: <1017900409.368586.2284.nullmailer@bozar.algorithm.com.au>
Message-ID: <Pine.LNX.3.96.1020404133529.3665D-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Apr 2002, Andre Pang wrote:

> I think the patch is clean and conservative enough to go into the
> production kernels.  Without the patch, the KL133 is completely
> unusable in text mode and suffers major video corruption in
> graphics mode; it really needs to be fixed.  Other motherboards
> are completely unaffected.  I've received only positive feedback
> from the patch so far.

Consider this one more positive feedback, I'll try it over the weekend and
see if I can stop using a separate video board.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

