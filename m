Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316573AbSHSAZX>; Sun, 18 Aug 2002 20:25:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316574AbSHSAZX>; Sun, 18 Aug 2002 20:25:23 -0400
Received: from dp.samba.org ([66.70.73.150]:49541 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S316573AbSHSAZW>;
	Sun, 18 Aug 2002 20:25:22 -0400
Date: Mon, 19 Aug 2002 10:04:11 +1000
From: Rusty Russell <rusty@rustcorp.com.au>
To: Greg KH <greg@kroah.com>
Cc: haveblue@us.ibm.com, linux-kernel@vger.kernel.org, Martin.Bligh@us.ibm.com
Subject: Re: [PATCH] add buddyinfo /proc entry
Message-Id: <20020819100411.018ac784.rusty@rustcorp.com.au>
In-Reply-To: <20020816143925.GA3957@kroah.com>
References: <3D5C6410.1020706@us.ibm.com>
	<20020816043140.GA2478@kroah.com>
	<3D5CBCFC.2090006@us.ibm.com>
	<20020816143925.GA3957@kroah.com>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; powerpc-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Aug 2002 07:39:25 -0700
Greg KH <greg@kroah.com> wrote:

> On Fri, Aug 16, 2002 at 01:51:08AM -0700, Dave Hansen wrote:
> > Greg KH wrote:
> > > On Thu, Aug 15, 2002 at 07:31:44PM -0700, Dave Hansen wrote:
> > >
> > >> Not _another_ proc entry!
> > >
> > > Yes, not another one.  Why not move these to driverfs, where they
> > > belong.
> > 
> > Could you show us how this particular situation might be laid out in a 
> > driverfs/kfs/gregfs tree?
> 
> root/vm/buddyinfo   ?

root/memory please.  vm is a little obscure.

Rusty.
-- 
   there are those who do and those who hang on and you don't see too
   many doers quoting their contemporaries.  -- Larry McVoy
