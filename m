Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262635AbSJHWg6>; Tue, 8 Oct 2002 18:36:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262602AbSJHWg6>; Tue, 8 Oct 2002 18:36:58 -0400
Received: from tomts19.bellnexxia.net ([209.226.175.73]:19682 "EHLO
	tomts19-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S262508AbSJHWgy>; Tue, 8 Oct 2002 18:36:54 -0400
Content-Type: text/plain; charset=US-ASCII
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: Christoph Hellwig <hch@infradead.org>, "Theodore Ts'o" <tytso@mit.edu>,
       linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
Subject: Re: [Ext2-devel] [RFC] [PATCH 1/4] Add extended attributes to ext2/3
Date: Tue, 8 Oct 2002 18:37:45 -0400
User-Agent: KMail/1.4.3
References: <E17yymB-00021j-00@think.thunk.org> <20021008184039.GA8174@think.thunk.org> <20021008195047.A14549@infradead.org>
In-Reply-To: <20021008195047.A14549@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210081837.45980.tomlins@cam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On October 8, 2002 02:50 pm, Christoph Hellwig wrote:
> On Tue, Oct 08, 2002 at 02:40:39PM -0400, Theodore Ts'o wrote:
> > On Tue, Oct 08, 2002 at 07:19:00PM +0100, Christoph Hellwig wrote:
> > > > This first patch creates a generic interface for registering caches
> > > > with the VM subsystem so that they can react appropriately to memory
> > > > pressure.
> > >
> > > I'd suggest Ed Tomlinson's much saner interface that adds a third
> > > callbackj to kmem_cache_t (similar to the Solaris implementation)
> > > instead.
> >
> > Can you give me a pointer to his stuff?  Thanks!
>
> It is/was in akpm's -mm tree
> (http://www.zip.com.au/~akpm/linux/patches/2.5/). Ed, do you have a pointer
> to your most recent patch?

Its in Andrew's tree.

Ed

