Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316882AbSGTNEF>; Sat, 20 Jul 2002 09:04:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317170AbSGTNEF>; Sat, 20 Jul 2002 09:04:05 -0400
Received: from front1.mail.megapathdsl.net ([66.80.60.31]:10759 "EHLO
	front1.mail.megapathdsl.net") by vger.kernel.org with ESMTP
	id <S316882AbSGTNEF>; Sat, 20 Jul 2002 09:04:05 -0400
Subject: Re: [2.6] Most likely to be merged by Halloween... THE LIST
From: Miles Lane <miles@megapathdsl.net>
To: Dave Jones <davej@suse.de>, David Woodhouse <dwmw2@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20020718222229.B21997@suse.de>
References: <3D361091.13618.16DC46FB@localhost>
	 <Pine.LNX.3.96.1020718123016.8220B-100000@gatekeeper.tmr.com>
	 <20020718222229.B21997@suse.de>
Content-Type: text/plain
Organization: 
Message-Id: <1027170375.2026.24.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.1.0.99 (Preview Release)
Date: 20 Jul 2002 09:06:15 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-07-18 at 16:22, Dave Jones wrote:

>  > > o Overhaul PCMCIA support                         (David Woodhouse, David Hinds)
>  > 	Sure would be nice if it worked on desktops as well as laptops
> 
> "works for me". Admittedly I've not played with pcmcia much, but it
> seems at least if you choose the right hardware it works fine.

Uh, I have seen no patches from David for this?  Have I somehow
missed this?  

I would dearly love to see this functionality get added.  I would 
also like to hear what the implementation plan is.  Will the 
need for /etc/pcmcia go away?  Will the new code do a better job
of knowing what drivers to load without system configuration files?
How will device removal be handled?  Will we still need cardctl
and cardmgr?  

I just went through a process yesterday of trying to get some
PCMCIA wireless PC Card configuration.  It isn't at all straightforward,
even with pcmcia-cs.

	Miles

