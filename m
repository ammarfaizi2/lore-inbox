Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281424AbRKEXbd>; Mon, 5 Nov 2001 18:31:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281428AbRKEXbX>; Mon, 5 Nov 2001 18:31:23 -0500
Received: from mailout01.sul.t-online.com ([194.25.134.80]:57526 "EHLO
	mailout01.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S281424AbRKEXbH>; Mon, 5 Nov 2001 18:31:07 -0500
Content-Type: text/plain; charset=US-ASCII
From: Thomas Koeller <tkoeller@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Scheduling of low-priority background processes
Date: Tue, 6 Nov 2001 00:30:08 +0100
X-Mailer: KMail [version 1.2]
In-Reply-To: <Pine.LNX.4.10.10111051722590.13543-100000@coffee.psychology.mcmaster.ca>
In-Reply-To: <Pine.LNX.4.10.10111051722590.13543-100000@coffee.psychology.mcmaster.ca>
MIME-Version: 1.0
Message-Id: <01110523561405.00641@sarkovy.koeller.org>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday,  5. November 2001 23:24, Mark Hahn wrote:
>
> please read the scheduler; it's not that bad, especially if you
> ignore the SMP case.  normal procs are only considered if there
> are no runnable RT procs.

I know the scheduler works this way. But does it have to? What I meant to do 
was suggesting an improvement.

Thomas


-- 
Thomas Koeller
tkoeller@gmx.net
