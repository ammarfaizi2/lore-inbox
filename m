Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310629AbSCHBC4>; Thu, 7 Mar 2002 20:02:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310631AbSCHBCr>; Thu, 7 Mar 2002 20:02:47 -0500
Received: from web9906.mail.yahoo.com ([216.136.129.249]:21766 "HELO
	web9906.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S310629AbSCHBCi>; Thu, 7 Mar 2002 20:02:38 -0500
Message-ID: <20020308010238.739.qmail@web9906.mail.yahoo.com>
Date: Thu, 7 Mar 2002 17:02:38 -0800 (PST)
From: Beef Arrowny <tanfhltu@yahoo.com>
Subject: Re: Kernel Oops in 2.4.18 (ide.c)
To: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@suse.de>,
        Andre Hedrick <andre@linux-ide.org>
In-Reply-To: <Pine.LNX.4.44.0203070909590.19993-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- Zwane Mwaikambo <zwane@linux.realnet.co.sz> wrote:
> On Wed, 6 Mar 2002, Beef Arrowny wrote:
> 
> > I think I've got all the right info, but here
> goes:
> > 
> > I'm trying to get my RICOH MP6200A CD-RW to work
> on
> > this new machine I just built.  I've gotten it to
> work
> > in the past, but it's always been blind luck. 
> This is
> > the first time I've gotten an oops however.
> 
> I sent a patch to fix the oops, but not the
> underlying problem a while 
> back, so thats probably why it hasn't made it into
> mainline. Jens might 
> know wether the drive is a problematic one.
> 
> Regards,
> 	Zwane
> 

Can you give me a hint as to what I might be able to
do to modify it and fix it?  I'm not an expert in C
coding, but I can mill my way around... I can
understand why such a patch may be left out of the
mainstream kernel, but I wouldn't mind applying it in
my case.

Just for some more info on the problem.  I did some
more reboots last night, and I did get the 'eject sr0'
to work once. I then pressed the CD back in and tried
the eject again, and froze up hard.  no Oops that
time.  So it works intermittently.

Thanks for your prompt reply.

Regards,
Toby


__________________________________________________
Do You Yahoo!?
Try FREE Yahoo! Mail - the world's greatest free email!
http://mail.yahoo.com/
