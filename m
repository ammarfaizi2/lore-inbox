Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262580AbSKIToC>; Sat, 9 Nov 2002 14:44:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262590AbSKIToC>; Sat, 9 Nov 2002 14:44:02 -0500
Received: from scaup.mail.pas.earthlink.net ([207.217.120.49]:57050 "EHLO
	scaup.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S262580AbSKIToB>; Sat, 9 Nov 2002 14:44:01 -0500
Date: Sat, 9 Nov 2002 12:44:08 -0800 (PST)
From: James Simmons <jsimmons@infradead.org>
X-X-Sender: <jsimmons@maxwell.earthlink.net>
To: Ben Pfaff <blp@cs.stanford.edu>
cc: James Simmons <jsimmons@phoenix.infradead.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.45 / fb vga16fb build error
In-Reply-To: <87adkjcz7p.fsf@pfaff.Stanford.EDU>
Message-ID: <Pine.LNX.4.33.0211091243450.7035-100000@maxwell.earthlink.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > > > I finished porting over the driver to the new api last night. It will be
> > > > part of the next pull by Linus. I have a few more things I need done over
> > > > the weekend for the new fbdev stuff.
> > >
> > > Was there something wrong with my patches to do the same thing
> > > that have been in Alan Cox's tree for some time now?
> >
> > No, but the final api is done and struct display_switch is going away!!!
> > So I had to fix the driver to work with the latest changes.
>
> I see.  I didn't realize that the API was changing again.  Oh
> well.

Its the last set of changes. It should be ready monday.


