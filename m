Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263135AbSKRSG1>; Mon, 18 Nov 2002 13:06:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263204AbSKRSG0>; Mon, 18 Nov 2002 13:06:26 -0500
Received: from carisma.slowglass.com ([195.224.96.167]:23050 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S263135AbSKRSGW>; Mon, 18 Nov 2002 13:06:22 -0500
Date: Mon, 18 Nov 2002 18:13:20 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: CaT <cat@zip.com.au>
cc: Ben Pfaff <blp@cs.stanford.edu>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.45 / fb vga16fb build error
In-Reply-To: <20021118124920.GA593@zip.com.au>
Message-ID: <Pine.LNX.4.44.0211181811400.22101-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On Sat, Nov 09, 2002 at 12:44:08PM -0800, James Simmons wrote:
> > > I see.  I didn't realize that the API was changing again.  Oh
> > > well.
> > 
> > Its the last set of changes. It should be ready monday.
> 
> Hey.
> 
> Any news wrt this? :)

I will be posting a patch today against 2.5.48. It will have the latest 
changes for the fbdev layer. Note several drivers are still broken but I'm 
in the process of updating them over the next few days :-)


