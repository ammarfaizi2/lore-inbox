Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131958AbRAaPEC>; Wed, 31 Jan 2001 10:04:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131876AbRAaPDw>; Wed, 31 Jan 2001 10:03:52 -0500
Received: from green.csi.cam.ac.uk ([131.111.8.57]:39358 "EHLO
	green.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S131817AbRAaPDm>; Wed, 31 Jan 2001 10:03:42 -0500
Date: Wed, 31 Jan 2001 15:03:10 +0000 (GMT)
From: James Sutherland <jas88@cam.ac.uk>
To: "Richard B. Johnson" <root@chaos.analogic.com>
cc: Rik van Riel <riel@conectiva.com.br>,
        Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Version 2.4.1 cannot be built. 
In-Reply-To: <Pine.LNX.3.95.1010131091907.13340A-100000@chaos.analogic.com>
Message-ID: <Pine.SOL.4.21.0101311502390.5803-100000@green.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Jan 2001, Richard B. Johnson wrote:
> On Wed, 31 Jan 2001, Rik van Riel wrote:
> > On Wed, 31 Jan 2001, Richard B. Johnson wrote:
> > > On Tue, 30 Jan 2001, Rik van Riel wrote:
> > > > On Tue, 30 Jan 2001, Richard B. Johnson wrote:
> > > > 
> > > > > The subject says it all. `make dep` is now broken.
> > > > 
> > > > It worked fine here, with 2.4.1 unpacked from the tarball.
> > > 
> > > I cannot find the source for GNU Make 3.77+
> > 
> > I have a hard time believing that you don't have
> > the skills to go to ftp.gnu.org and download the
> > stuff...
> > 
> 
> Now just a cotton-picken minute. When was the last time you
> accessed that site? I spent most of last night looking through
> EMPTY directories with files that are invisible to ftp but
> (sometimes) show with their `ls`, and never with nlist.
> 
> Maybe you can still download stuff if you are running from a
> Web Crawler, but it doesn't work with `ftp` anymore.

Works fine for me with "ftp"... Passive FTP is incredibly slow, though...


James.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
