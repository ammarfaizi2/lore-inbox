Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316855AbSHATVh>; Thu, 1 Aug 2002 15:21:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316860AbSHATVh>; Thu, 1 Aug 2002 15:21:37 -0400
Received: from lucidpixels.com ([66.45.37.187]:53712 "HELO lucidpixels.com")
	by vger.kernel.org with SMTP id <S316855AbSHATVg>;
	Thu, 1 Aug 2002 15:21:36 -0400
Message-ID: <3D4989E1.90B2CC78@lucidpixels.com>
Date: Thu, 01 Aug 2002 15:20:01 -0400
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-lowlatency-preempt i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ragnar =?iso-8859-1?Q?Kj=F8rstad?= <kernel@ragnark.vestdata.no>
CC: linux-kernel@vger.kernel.org, lftp@uniyar.ac.ru, lftp-devel@uniyar.ac.ru,
       apiszcz@mitre.org, ext2-devel@lists.sourceforge.net
Subject: Re: Nasty ext2fs bug!
References: <Pine.LNX.4.44.0208011150310.17729-100000@lucidpixels.com> <20020801174856.GA29562@clusterfs.com> <20020801202718.S20768@vestdata.no>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The remote link is an un-utilized T3.
The downlink is a 3MBIT cable modem.


Ragnar Kjørstad wrote:

> On Thu, Aug 01, 2002 at 11:48:56AM -0600, Andreas Dilger wrote:
> > >  Problem: The pget -n feature of lftp is very nice if you want to maximize
> > >           your download bandwidth, however, if getting a large file, such
> > >           as the one I am getting, once the file is successfully
> > >           retrived, transferring it to another HDD or FTPing it to another
> > >           computer is very slow (800KB-1600KB/s).
> >
> > I find it hard to believe that this would actually make a huge
> > difference, except in the case where the source is throttling bandwidth
> > on a per-connection basis.  Either your network is saturated by the
> > transfer, or some point in between is saturated.  I could be wrong, of
> > course, and it would be interesting to hear the reasoning behind the
> > speedup.
>
> If some link is saturated with 1000 connections, you will get 1% of the
> bandwith instead of 0.1% if you use 10 concurrent connections. right?
>
> --
> Ragnar Kjørstad

