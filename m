Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261338AbSJHQLs>; Tue, 8 Oct 2002 12:11:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261339AbSJHQLs>; Tue, 8 Oct 2002 12:11:48 -0400
Received: from thunk.org ([140.239.227.29]:4291 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id <S261338AbSJHQLr>;
	Tue, 8 Oct 2002 12:11:47 -0400
Date: Tue, 8 Oct 2002 12:17:22 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Andrew Morton <akpm@digeo.com>
Cc: Simon Kirby <sim@netnation.com>, linux-kernel@vger.kernel.org
Subject: Re: The reason to call it 3.0 is the desktop (was Re: [OT] 2.6 not 3.0 -  (NUMA))
Message-ID: <20021008161722.GB2913@think.thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Andrew Morton <akpm@digeo.com>, Simon Kirby <sim@netnation.com>,
	linux-kernel@vger.kernel.org
References: <m17yCIx-006hSwC@Mail.ZEDAT.FU-Berlin.DE> <1281002684.1033892373@[10.10.2.3]> <E17ybuZ-0003tz-00@starship> <3DA1D30E.B3255E7D@digeo.com> <3DA1D969.8050005@nortelnetworks.com> <3DA1E250.1C5F7220@digeo.com> <20021008023654.GA29076@netnation.com> <3DA247F3.B1150369@digeo.com> <20021008025457.GA26788@netnation.com> <3DA24A4E.87BEBD2C@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DA24A4E.87BEBD2C@digeo.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 07, 2002 at 08:00:30PM -0700, Andrew Morton wrote:
> Simon Kirby wrote:
> > 
> > On Mon, Oct 07, 2002 at 07:50:27PM -0700, Andrew Morton wrote:
> > 
> > > Oh tell me about it.
> > >
> > > Appended is the offset->block mapping for my "linux-kernel" mailbox.
> > > Read it and weep...
> > 
> > Eep. :)  Just out of interest, how did you get these mappings?
> > 

Debugfs will also show the mappings, although it's less reliable when
used on a mounted filesystem....

						- Ted
