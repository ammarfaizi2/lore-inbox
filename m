Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284635AbRLEUEq>; Wed, 5 Dec 2001 15:04:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284639AbRLEUEh>; Wed, 5 Dec 2001 15:04:37 -0500
Received: from trillium-hollow.org ([209.180.166.89]:40200 "EHLO
	trillium-hollow.org") by vger.kernel.org with ESMTP
	id <S284635AbRLEUE2>; Wed, 5 Dec 2001 15:04:28 -0500
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org, lm@bitmover.com (Larry McVoy),
        "Jeff Merkey" <jmerkey@timpanogas.org>
Subject: Re: Loadable drivers [was SMP/cc Cluster description ] 
In-Reply-To: Your message of "Wed, 05 Dec 2001 11:40:07 PST."
             <E16Bhtn-0004xf-00@trillium-hollow.org> 
Date: Wed, 05 Dec 2001 12:04:18 -0800
From: erich@uruk.org
Message-Id: <E16BiHC-00052T-00@trillium-hollow.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I wrote:

> This really goes into a side-topic, but plainly:
> 
> The general driver/random module framework in Linux really needs to get
> separated from the core kernel, and made so that it doesn't need to be
> recompiled between minor kernel versions.  Perhaps even pulling the
> drivers in general apart from each other, just aggregating releases for
> convenience.

...and licensing issues aside (probably only GPL for the moment), this
kind of thing could form the basis for an open-source kernel/OS-independent
set of drivers.

I know that I have been intending on doing a Linux driver compatibility
layer of sorts for my OS project (going to be GPL'd) I'm working on.

Maybe there are some others interested in this kind of project?

--
    Erich Stefan Boleyn     <erich@uruk.org>     http://www.uruk.org/
"Reality is truly stranger than fiction; Probably why fiction is so popular"
