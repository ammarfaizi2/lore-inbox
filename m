Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262146AbSJNUeZ>; Mon, 14 Oct 2002 16:34:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262154AbSJNUeZ>; Mon, 14 Oct 2002 16:34:25 -0400
Received: from air-2.osdl.org ([65.172.181.6]:16260 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S262146AbSJNUeX>;
	Mon, 14 Oct 2002 16:34:23 -0400
Subject: Re: Evolution and 2.5.x
From: Andy Pfiffer <andyp@osdl.org>
To: Thomas Molina <tmolina@cox.net>
Cc: Robert Love <rml@tech9.net>, Eric Blade <eblade@m-net.arbornet.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0210141435440.6072-100000@dad.molina>
References: <Pine.LNX.4.44.0210141435440.6072-100000@dad.molina>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 14 Oct 2002 13:39:56 -0700
Message-Id: <1034627996.1995.55.camel@andyp>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-10-14 at 12:41, Thomas Molina wrote:
> > > See this thread:
> > > http://lists.ximian.com/archives/public/evolution-hackers/2002-June/004841.html
> > > 
> > > It is indeed broken in 2.5 and it is not, for once, our fault.  This
> > > thread and other discussion seem to point out it is a bug in ORBit.
> > > 
> > > 	Robert Love
> > 
> > I spent some time trying to track this problem down, but reached a wall
> > due to the size and nature of the ChangeSet.
> > 
> > The bitkeeper ChangeSet that made Evolution's address book hang when
> > trying to compose a new message when run on 2.5.x kernels was 1.262.2.2.
> 
> I've read this thread and I'm confused.  Is this seen as a problem with 
> Evolution, ORBit, or the 2.5 kernel?  If it is seen as a possible kernel 
> problem, I'll add it to my problem report status page and track it.  If I 
> track it, Eric Blade will get a weekly email asking whether he's still 
> seeing the problem, at least until I'm told to drop it, or no one 
> responds.

I'll defer to the experts as to the root cause of the problem.

All I know for sure is that before 1.262.2.2 Evolution works, and after
applying 1.262.2.2, it doesn't.

Andy


