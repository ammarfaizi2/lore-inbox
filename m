Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263977AbSKIBOQ>; Fri, 8 Nov 2002 20:14:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263979AbSKIBOQ>; Fri, 8 Nov 2002 20:14:16 -0500
Received: from phoenix.mvhi.com ([195.224.96.167]:58630 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S263977AbSKIBOP>; Fri, 8 Nov 2002 20:14:15 -0500
Date: Sat, 9 Nov 2002 01:20:56 +0000 (GMT)
From: James Simmons <jsimmons@phoenix.infradead.org>
To: Ben Pfaff <blp@cs.stanford.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.45 / fb vga16fb build error
In-Reply-To: <87el9vd09k.fsf@pfaff.Stanford.EDU>
Message-ID: <Pine.LNX.4.44.0211090118570.14371-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > I finished porting over the driver to the new api last night. It will be 
> > part of the next pull by Linus. I have a few more things I need done over 
> > the weekend for the new fbdev stuff.
> 
> Was there something wrong with my patches to do the same thing
> that have been in Alan Cox's tree for some time now?

No, but the final api is done and struct display_switch is going away!!!
So I had to fix the driver to work with the latest changes.

