Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284691AbSAGSG2>; Mon, 7 Jan 2002 13:06:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284694AbSAGSGM>; Mon, 7 Jan 2002 13:06:12 -0500
Received: from ns.ithnet.com ([217.64.64.10]:1289 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S284691AbSAGSF6>;
	Mon, 7 Jan 2002 13:05:58 -0500
Date: Mon, 7 Jan 2002 19:05:55 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: christian e <cej@ti.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: swapping,any updates ?? Just wasted money on mem upgrade performance still suck :-(
Message-Id: <20020107190555.74ea71fe.skraw@ithnet.com>
In-Reply-To: <3C39E11B.8010506@ti.com>
In-Reply-To: <3C386DC9.307@ti.com>
	<20020106170204.7e04e81f.skraw@ithnet.com>
	<3C396B45.6040702@ti.com>
	<20020107174450.5d20d2ad.skraw@ithnet.com>
	<3C39E11B.8010506@ti.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.7.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 07 Jan 2002 18:55:39 +0100
christian e <cej@ti.com> wrote:

> Stephan von Krawczynski wrote:

> > Please try a stock 2.4.17 (with the patch), otherwise we will have no idea
what> > is going on.
> 
> 
> Just patched the kernel and booted it up..To begin with it looked OK and 
> there wasn't any swapping.Even firing up VMware didn't cause it to swap..

That is fine.

> Then all of a sudden the mouse started moving all over the screen and 
> left and right clicking on everything on it's own. ?? Really weird..
> Ran like that for 5 minutes then the machine crashed hard.

This is for sure no VM issue. This is strange, is this with VMware started,
inside XP? Does this happen under Linux-only, too (with no vmware running)?
It doesn't even look quite like a linux issue at all. Just guessing: do you
have a virus-checker for XP at hand? Only to make sure...

> I assigned 192 MB for XP that should be more than enough..And as long as 
> Linux doesn't swap it is..

This can be driven without swap for sure.

Regards,
Stephan


