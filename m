Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266367AbSKOPDg>; Fri, 15 Nov 2002 10:03:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266368AbSKOPDg>; Fri, 15 Nov 2002 10:03:36 -0500
Received: from excalibur.cc.purdue.edu ([128.210.189.22]:62987 "EHLO
	ibm-ps850.purdueriots.com") by vger.kernel.org with ESMTP
	id <S266367AbSKOPDf>; Fri, 15 Nov 2002 10:03:35 -0500
Date: Fri, 15 Nov 2002 10:13:19 -0500 (EST)
From: Patrick Finnegan <pat@purdueriots.com>
To: Joe Thornber <joe@fib011235813.fsnet.co.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: Moving from Linux 2.4.19 LVM to LVM2
In-Reply-To: <20021115094934.GB2122@reti>
Message-ID: <Pine.LNX.4.44.0211151012470.14891-100000@ibm-ps850.purdueriots.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Nov 2002, Joe Thornber wrote:

> On Thu, Nov 14, 2002 at 10:51:48PM -0500, Patrick Finnegan wrote:
> > On Thu, 14 Nov 2002, Joe Thornber wrote:
> >
> > > On Wed, Nov 13, 2002 at 11:05:37PM -0500, Patrick Finnegan wrote:
> > > > Is there an easy and plainless way to do this?  Are the LVM2 tools
> > > > backwards-compatible with the old LVM?
> > >
> > > Yes
> >
> > Actually, the answer is aparently "No."  LVM2's tools don't work with a
> > 2.4.x kernel.
>
> Had you applied the device-mapper patches for 2.4 ?

Umm, no.  If I had, then that wouldn't be 2.4's native LVM.

Pat
--
Purdue Universtiy ITAP/RCS
Information Technology at Purdue
Research Computing and Storage
http://www-rcd.cc.purdue.edu


