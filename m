Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263278AbTC0Q1t>; Thu, 27 Mar 2003 11:27:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263282AbTC0Q1s>; Thu, 27 Mar 2003 11:27:48 -0500
Received: from gans.physik3.uni-rostock.de ([139.30.44.2]:35227 "EHLO
	gans.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id <S263278AbTC0Q1s>; Thu, 27 Mar 2003 11:27:48 -0500
Date: Thu, 27 Mar 2003 17:39:00 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Larry McVoy <lm@bitmover.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: ECC error in 2.5.64 + some patches
In-Reply-To: <20030327162732.GB29195@work.bitmover.com>
Message-ID: <Pine.LNX.4.33.0303271736590.26764-100000@gans.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Mar 2003, Larry McVoy wrote:

> On Thu, Mar 27, 2003 at 05:17:25PM +0100, Tim Schmielau wrote:
> > On Thu, 27 Mar 2003, Larry McVoy wrote:
> >
> > > I'm getting these on the machine we use to do the BK->CVS conversions.
> > > My guess is that this means there was a memory error and ECC fixed it.
> > > The only problem is that I'm reasonably sure that there isn't ECC on
> > > these DIMMs.  Does anyone have the table of error codes to explanations?
> > > Google didn't find anything for this one.
> >
> > No, I don't have a table of error codes either, but it's probably the
> > on-die Cache which has ECC for all recent (>=350 MHz iirc) Pentii.
>
> This is a 2.16Ghz Athlon not a Pentium if that makes a difference.

The on-die second-level cache of all Athlons also has ECC. But I can't
find a document of the error codes on AMD's website either.

