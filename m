Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265305AbTBTNOg>; Thu, 20 Feb 2003 08:14:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265320AbTBTNOg>; Thu, 20 Feb 2003 08:14:36 -0500
Received: from cal003100.student.utwente.nl ([130.89.160.36]:18887 "EHLO
	margo.student.utwente.nl") by vger.kernel.org with ESMTP
	id <S265305AbTBTNOe>; Thu, 20 Feb 2003 08:14:34 -0500
Date: Thu, 20 Feb 2003 14:24:39 +0100
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.x release process comments
Message-ID: <20030220132439.GA12010@margo.student.utwente.nl>
Mail-Followup-To: simon, linux-kernel@vger.kernel.org
References: <20030220125808.GA11694@margo.student.utwente.nl> <026601c2d8e1$9f2616f0$3f00a8c0@witbe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <026601c2d8e1$9f2616f0$3f00a8c0@witbe>
User-Agent: Mutt/1.4i
From: Simon Oosthoek <simon@margo.student.utwente.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20, 2003 at 02:11:46PM +0100, Paul Rolland wrote:
> Hello,
> 
> > I'm not saying it should, but it would be good from a PR 
> > perspective and as
> > an element in the reliability feeling vector ;-)
> Not sure about it... People like it when a product looks stable,
> and having a -blah or -pre and so on once a week doesn't make
> me feel I have some stable product...

But that's only because the kernel is in public development, it's not a
black box (which is a Good Thing (tm)). You shouldn't need to run a -pre
kernel release in 99% of all cases, so having them available shouldn't
detract from a feeling of stability (regardless of how often they come)

> > The number of -pre releases shouldn't be limited for its own sake, but
> > rather in the process of stabilising the kernel for release. 
> > So I mean after
> > a couple of -pre releases start focussing on debugging and 
> > then finish with
> > a few -rc's before the next cycle starts. That way the diffs 
> > between full
> > versions are smaller and upgrading gets easier.
> So, the question is to choose between :
>  - less releases with more changes
> or
>  - more relaseases with less changes
> 
> Is that correct ?

I guess so.

There's probably not a "right" way to choose between the two, but I'd prefer
the latter option.

Cheers

Simon
