Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133007AbRADNTu>; Thu, 4 Jan 2001 08:19:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133028AbRADNTk>; Thu, 4 Jan 2001 08:19:40 -0500
Received: from gidayu.max.uni-duisburg.de ([134.91.242.4]:6416 "HELO
	gidayu.max.uni-duisburg.de") by vger.kernel.org with SMTP
	id <S133007AbRADNTc>; Thu, 4 Jan 2001 08:19:32 -0500
Date: Thu, 4 Jan 2001 14:19:23 +0100
From: Christian Loth <chris@gidayu.max.uni-duisburg.de>
To: Andrew Morton <andrewm@uow.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: DHCP Problems with 3com 3c905C Tornado
Message-ID: <20010104141923.D15097@gidayu.max.uni-duisburg.de>
In-Reply-To: <20010104123139.A15097@gidayu.max.uni-duisburg.de> <3A546F8E.ABF952F@uow.edu.au>, <3A546F8E.ABF952F@uow.edu.au>; <20010104134315.C15097@gidayu.max.uni-duisburg.de> <3A54739F.FB8D6F3D@uow.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <3A54739F.FB8D6F3D@uow.edu.au>; from andrewm@uow.edu.au on Thu, Jan 04, 2001 at 11:59:11PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

On Thu, Jan 04, 2001 at 11:59:11PM +1100, Andrew Morton wrote:
> Now that is wierd.  They're radically different drivers,
> and the 3com one doesn't seem to undergo many changes at
> all.
> 
> I wonder if the PCI scan order may have changed.  What
> other PCI devices did you have in that machine? Any other
> NICs?

No, no other NICs. There's a Matrox G200 in the AGP slot,
and a 3Ware 6200 ATA-66 RAID Controller in another PCI slot.
There's an onboard SCSI controller from Adaptec (AIC7xxx) 
but it's unused and this is a SMP system. The Motherboard is 
a Gigabyte G6BXDU. That's about it.

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
