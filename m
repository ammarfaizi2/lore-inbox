Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262528AbSJ0UTa>; Sun, 27 Oct 2002 15:19:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262536AbSJ0UT3>; Sun, 27 Oct 2002 15:19:29 -0500
Received: from dclient217-162-232-203.hispeed.ch ([217.162.232.203]:3207 "EHLO
	trivadis.com") by vger.kernel.org with ESMTP id <S262528AbSJ0UT3>;
	Sun, 27 Oct 2002 15:19:29 -0500
Envelope-to: linux-kernel@vger.kernel.org
Date: Sun, 27 Oct 2002 21:13:00 +0100
From: Tim Tassonis <timtas@cubic.ch>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Swap doesn't work
In-Reply-To: <20021027200308.A26047@infradead.org>
References: <E185tHb-0002mq-00@trivadis.com>
	<20021027200308.A26047@infradead.org>
X-Mailer: Sylpheed version 0.8.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <E185tmO-0002mu-00@trivadis.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Sorry, tons of people that have absolute no clue about the package
> internals set up their systems themselves and make mistakes.  nothing
> spectacular, but they just don't have those people who know the
> packages in detail and can notice and fix the bugs.  Just get binary
> rpm/deb whatever of the toolchain and reproduce.

As I said, I can't reproduce it even on my lfs system, maybe because my
disks are scsi. So reproducing on my Red Hat wouldn't really help, would
it?

> > lfs has a manual with clearly specified package versions, patches and
> > order of "toolchaining". It might well be a bug in that chain, but
> > other distros have bugs, too. Signing software doesn't make it
> > superior, after all.
> 
> but having people who understand the software maintain the
> packages sometimes helps :)

As far as I know, lfs does not maintain the packages. binutils and gcc are
maintained by FSF to my knowledge.

Bye
Tim
