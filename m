Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288914AbSBIMSD>; Sat, 9 Feb 2002 07:18:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288919AbSBIMRx>; Sat, 9 Feb 2002 07:17:53 -0500
Received: from dsl-213-023-038-235.arcor-ip.net ([213.23.38.235]:7335 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S288914AbSBIMRk>;
	Sat, 9 Feb 2002 07:17:40 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>
Subject: Re: How to check the kernel compile options ?
Date: Sat, 9 Feb 2002 13:22:22 +0100
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200202082053.g18Krxja001427@tigger.cs.uni-dortmund.de>
In-Reply-To: <200202082053.g18Krxja001427@tigger.cs.uni-dortmund.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16ZWWP-0006Ee-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On February 8, 2002 09:53 pm, Horst von Brand wrote:
> Daniel Phillips <phillips@bonn-fries.net> said:
> > On February 7, 2002 10:41 pm, Mike Touloumtzis wrote:
> > > Adding configuration information to the kernel is a change to the status
> > > quo, and has a cost.  The cost is small, but I'm unsympathetic to that
> > > argument because many small convenience features, each with a small cost,
> > > add up to a large cost.
> > 
> > The cost is *zero* if you don't enable the option, is this concept difficult
> > for you?
> 
> It isn't zero: Somebody has to add the support, check/fix interactions with
> other features, write documentation, keep the support and its documentation
> up to date when stuff in the kernel changes, userland (and user) has to be
> prepared (and checked that it works if the feature is present, and find
> workarounds if it isn't), ...
>
> It might be a small cost, but N * small gets big _very_ fast, and the value
> is marginal at best in this case. There are many other such "small cost
> features" with equally small value results that haven't been included. One
> of the big reasons why I like Linux, BTW.

Non sequitur.  You are talking about a completely different cost than he was.

But I'll bite: if a volunteer wishes to contribute the needed work, and the
feature impacts no systems outside itself, then you have no argument.

-- 
Daniel
