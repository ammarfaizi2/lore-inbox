Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262134AbTCHS2a>; Sat, 8 Mar 2003 13:28:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262141AbTCHS2a>; Sat, 8 Mar 2003 13:28:30 -0500
Received: from tartarus.telenet-ops.be ([195.130.132.46]:13730 "EHLO
	tartarus.telenet-ops.be") by vger.kernel.org with ESMTP
	id <S262134AbTCHS23>; Sat, 8 Mar 2003 13:28:29 -0500
Subject: Re: what's an OOPS
From: Ludootje <ludootje@linux.be>
To: linux-kernel@vger.kernel.org
In-Reply-To: <200303081654.h28Gskpk002027@81-2-122-30.bradfords.org.uk>
References: <200303081654.h28Gskpk002027@81-2-122-30.bradfords.org.uk>
Content-Type: text/plain
Organization: 
Message-Id: <1047148667.1428.1.camel@libranet>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 08 Mar 2003 19:37:48 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Op za 08-03-2003, om 17:54 schreef John Bradford:
> > > The number of the oops, (I.E. whether it was the first, second, third,
> > > etc, starting with 0000).
> > 
> > Urban myth (at least on i386). The "Oops:" part can be decoded on i386 as,
> > 
> >  *      bit 0 == 0 means no page found, 1 means protection fault
> >  *      bit 1 == 0 means read, 1 means write
> >  *      bit 2 == 0 means kernel, 1 means user-mode
> 
> Interesting - I wasn't aware of that.
> 
> Maybe we should note this in Documentation/oops-tracing.txt?
> 
> Infact, overall there must be quite a lot that isn't documented at
> all, except in this mailing list's archives - I think an overhaul of
> Documentation/* is more than slightly overdue...
> 
> John.

Thanks a lot for the very good explanatiosn everyone, I really
appreciate it!

Thanks,
Ludootje

-- 

 The Grasshoppers' Linux Journal - a free, online distributed magazine about GNU/Linux / Open Source / ... oriented towards newbies. Check it out @ http://ghj.sunsite.dk !

