Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267578AbSLFIxL>; Fri, 6 Dec 2002 03:53:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267580AbSLFIxL>; Fri, 6 Dec 2002 03:53:11 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:59141 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S267578AbSLFIxK>; Fri, 6 Dec 2002 03:53:10 -0500
Message-ID: <3DF0660A.B26D91D8@aitel.hist.no>
Date: Fri, 06 Dec 2002 09:55:38 +0100
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.5.50 i686)
X-Accept-Language: no, en, en
MIME-Version: 1.0
To: jeff millar <wa1hco@adelphia.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: is KERNEL developement finished, yet ???
References: <F6E1228667B6D411BAAA00306E00F2A51539BA@pdc2.nestec.net> <200212041526.57501.shanehelms@eircom.net> <01c301c29bf5$201a9120$6a01a8c0@wa1hco> <20021206005510.A7411@iapetus.localdomain> <007301c29cd3$95ad99d0$6a01a8c0@wa1hco>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jeff millar wrote:
> 
> Harnessing energy (rockets, nukes, etc) is fundamentally an unlimited
> engineering opportunity.  But kernel development is mostly an attempt to
> reduce overhead to zero. If a kernel runs 90% efficient now, then there's
> only 10% additional improvement possible.
> 

It isn't merely reducing overhead.  You can, for example,
develop better caching/readahead/swap algorithms and sometimes
get fantastic improvement.  

> On the other hand application software is fundamentally unlimited.
> 
> So if you want to work on reliability, portability, maintainability, and
> adaptation to new hardware then kernels make a good career.  But if you want
> to break new ground, then it's either application space or hardware.
> 
You can break new ground with kernels too - whenever you find
new ways to use the hardware.  Kernels for massively parallel
machines aren't standardized yet, for example.
And that's the way hardware may have to go for further improvement
when it hits the final size limits.

Helge Hafting
