Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262976AbSJHWmE>; Tue, 8 Oct 2002 18:42:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263059AbSJHWmE>; Tue, 8 Oct 2002 18:42:04 -0400
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:64671 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262976AbSJHWmC>; Tue, 8 Oct 2002 18:42:02 -0400
Subject: Re: [PATCH] better RPC statistics
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Chuck Lever <cel@citi.umich.edu>, Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux NFS List <nfs@lists.sourceforge.net>
In-Reply-To: <20021008220450.GC9807@think.thunk.org>
References: <Pine.LNX.4.44.0210081517370.1273-100000@dexter.citi.umich.edu>
	 <20021008220450.GC9807@think.thunk.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 08 Oct 2002 23:57:43 +0100
Message-Id: <1034117863.31448.30.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-10-08 at 23:04, Theodore Ts'o wrote:
> It's not just "kernel interfaces" which should go in before October
> 20th.  
> 
> If we really want the feature freeze to be real, we really will need
> to be hard-nosed about what we accept after the freeze date.  (Said he
> who is frantically trying to finish up a last couple of ext2/3
> features in before 2.6.)
> 
> So I'd encourage folks to at least submit patches before Oct. 20th
> when they are ready, and not try to save stuff for after feature
> freeze....

There is a lot of driver clean up which will take lots of time beyond
Oct 31st. IDE is going to take a whole ton of work yet, but that (well
barring what happens with driverfs now) should be independant of the
rest of the world.


