Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130163AbRADMnt>; Thu, 4 Jan 2001 07:43:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132675AbRADMni>; Thu, 4 Jan 2001 07:43:38 -0500
Received: from gidayu.max.uni-duisburg.de ([134.91.242.4]:3344 "HELO
	gidayu.max.uni-duisburg.de") by vger.kernel.org with SMTP
	id <S130163AbRADMnY>; Thu, 4 Jan 2001 07:43:24 -0500
Date: Thu, 4 Jan 2001 13:43:15 +0100
From: Christian Loth <chris@gidayu.max.uni-duisburg.de>
To: Andrew Morton <andrewm@uow.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: DHCP Problems with 3com 3c905C Tornado
Message-ID: <20010104134315.C15097@gidayu.max.uni-duisburg.de>
In-Reply-To: <20010104123139.A15097@gidayu.max.uni-duisburg.de> <3A546F8E.ABF952F@uow.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <3A546F8E.ABF952F@uow.edu.au>; from andrewm@uow.edu.au on Thu, Jan 04, 2001 at 11:41:50PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello again,

On Thu, Jan 04, 2001 at 11:41:50PM +1100, Andrew Morton wrote:
> 
> hmm..  I've heard of this once before.  Running
> pump from the RH initscripts?
> 

Yes, but I also tested the normal dhcp client from the dhcpcd (sp?)
RPM. This one didn't work either.

> 
> Did _both_ 3c90x and 3c59x fail, or only 3c59x?
> 

Both did not work. And 3c59x from 2.2.18 didn't work
as well, and as far as I could judge 3c90x is not included
in the kernel proper, right?

> 
> Thanks.  I'll try to reproduce this (fat chance :().
> Is there any chance you can set this arrangement up
> again in the future?

I fear not :( It's a private project and my
budget is very very limited. The 3com card is exchanged for the
DEC Tulip card (actually a Netgear NIC), and I simply can't afford 
to buy another one, as they're pretty expensive.

- Chris

-- 
Christian Loth
Coder of 'Project Gidayu'
Computer Science Student, University of Dortmund
chris@gidayu.mud.de - http://gidayu.mud.de
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
