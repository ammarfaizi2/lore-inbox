Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315372AbSHMN22>; Tue, 13 Aug 2002 09:28:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315413AbSHMN22>; Tue, 13 Aug 2002 09:28:28 -0400
Received: from employees.nextframe.net ([212.169.100.200]:49402 "EHLO
	sexything.nextframe.net") by vger.kernel.org with ESMTP
	id <S315372AbSHMN20>; Tue, 13 Aug 2002 09:28:26 -0400
Date: Tue, 13 Aug 2002 15:46:16 +0200
From: Morten Helgesen <morten.helgesen@nextframe.net>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re:  [PATCH] 2.5.30 IDE 115
Message-ID: <20020813154616.E2098@sexything>
Reply-To: morten.helgesen@nextframe.net
References: <200208131314.GAA00444@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200208131314.GAA00444@baldur.yggdrasil.com>
User-Agent: Mutt/1.3.22.1i
X-Editor: VIM - Vi IMproved 6.0
X-Keyboard: PFU Happy Hacking Keyboard
X-Operating-System: Slackware Linux (of course)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 13, 2002 at 06:14:30AM -0700, Adam J. Richter wrote:
> >>> = Marcin Dalecki
> >> = Jens Axboe
> > = Marcin Dalecki
> 
> >>> Oh, I realize I didn't express myself properly. I certinaly don't intend
> >>> to eliminate elv_add_request() itself any time soon ;-).
> 
> >> No, I would appreciate it if you would keep your hands out of the block
> >> code.
> 
> >OK. I have enough.
> 
> 	I have confirmed by email with Jens (cc'ed to Martin) that
> Jens did not mean that Martin should step down as IDE maintainer
> or anything like that.

Was there any reason to think Jens actually wanted Martin to step
down ? He clearly stated that he wanted Martin to keep his hands
off the block code - not the IDE code.

> 
> 	Jens was referring to the generic block code that he
> maintains (including elv_add_request and drivers/block/block_ioctl.c,
> which Martin had submitted patch for in IDE 115 without consulting
> with Jens).
>

Of course - no wonder it pisses him off :)

> 	Personally, I hope that Martin stays on as IDE maintainer.
> Getting IDE to a maintainable state was a minefield that had to
> be crossed.  Could someone else have done with fewer mistakes?
> Maybe, but there was plenty of time for someone else to do it,
> and nobody stepped up to the plate.  Of course there is a

I agree with you - there`s no point discussing whether or not
someone else would have been able to do what Martin has done
with fewer mistakes - I think we should focus on helping Martin
make 2.5 IDE stable ...

> trade-off point that point is more conservatively set with the
> software that controls disk storage, but, in general, I think
> it's important to be supportive of those who actually produce.

yeah!

> 
> Adam J. Richter     __     ______________   575 Oroville Road
> adam@yggdrasil.com     \ /                  Milpitas, California 95035
> +1 408 309-6081         | g g d r a s i l   United States of America
>                          "Free Software For The Rest Of Us."

== Morten

-- 

"Livet er ikke for nybegynnere" - sitat fra en klok person.

mvh
Morten Helgesen 
UNIX System Administrator & C Developer 
Nextframe AS
admin@nextframe.net / 93445641
http://www.nextframe.net
