Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316621AbSHPSzL>; Fri, 16 Aug 2002 14:55:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317022AbSHPSzL>; Fri, 16 Aug 2002 14:55:11 -0400
Received: from air-2.osdl.org ([65.172.181.6]:2688 "EHLO cherise.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S316621AbSHPSzK>;
	Fri, 16 Aug 2002 14:55:10 -0400
Date: Fri, 16 Aug 2002 12:03:49 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise.pdx.osdl.net
To: Dave Hansen <haveblue@us.ibm.com>
cc: Greg KH <greg@kroah.com>, <linux-kernel@vger.kernel.org>,
       "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Subject: Re: [PATCH] add buddyinfo /proc entry
In-Reply-To: <3D5D25FE.8010002@us.ibm.com>
Message-ID: <Pine.LNX.4.44.0208161158270.1048-100000@cherise.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 16 Aug 2002, Dave Hansen wrote:

> Greg KH wrote:
> > All it takes is one line added to /etc/fstab mounting driverfs at /sys.
> > As the code is not a .config option, you are using it if you mount it or
> > not :)  The fact that no one else will look at that mount point,
> > shouldn't matter to you.
> > 
> > And yes, for just one thing (hey, why don't you move _all_ the vm stats
> > over to it), it is worth adding that one line.  And you'll eventually
> > have to do it anyway, as these things _will_ be moving there.
> > 
> > Hell, tell me which machine you are using, and I'll go add it.
> 
> How long has it been in the tree (2.4 and 2.5)?  I'll add it to my 
> machine, but I am anticipating a 3 hour conversation as I explain to 
> the other users why they got dropped to a root prompt because driverfs 
> isn't supported when they boot.

You're making things up and spreading FUD. Why would you want to do that? 

Oh right, it's because most "kernel developers" would rather bitch about 
that which they do not understand and cut down other developers than suck 
it up and actually try to learn something from someone else. 

Get over it.


	-pat

