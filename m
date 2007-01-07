Return-Path: <linux-kernel-owner+w=401wt.eu-S932542AbXAGNyJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932542AbXAGNyJ (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 08:54:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932533AbXAGNyI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 08:54:08 -0500
Received: from 1wt.eu ([62.212.114.60]:1833 "EHLO 1wt.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932542AbXAGNyI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 08:54:08 -0500
Date: Sun, 7 Jan 2007 14:53:58 +0100
From: Willy Tarreau <w@1wt.eu>
To: Akula2 <akula2.shark@gmail.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.20-rc4
Message-ID: <20070107135358.GT24090@1wt.eu>
References: <Pine.LNX.4.64.0701062216210.3661@woody.osdl.org> <8355959a0701070415q1fe8ebf7l40807b02de11db0c@mail.gmail.com> <20070107125512.GA14898@flint.arm.linux.org.uk> <8355959a0701070538o1406f5b7ma8e4b957201ca59e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8355959a0701070538o1406f5b7ma8e4b957201ca59e@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 07, 2007 at 07:08:47PM +0530, Akula2 wrote:
> On 1/7/07, Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> >
> >See the thread "kernel.org lies about latest -mm kernel" on this mailing
> >list.
> 
> Russell,
> 
> I have read the thread, big thanks to you for the inputs.
> Honestly I didn't understand much about the git internal working
> except getdents () @ HPA & Linus replies. This is incredible indeed.
> 
> I didn't understand these lines posted by John 'Warthog9' Hawley:-
> 
> "On average we are moving anywhere from 400-600mbps between the two
> machines, on release days we max both of the connections at 1gpbs each
> and have seen that draw last for 48hours.  For instance when FC6 was
> released in the first 12 hours or so we moved 13 TBytes of data"
>
> What FC6 release has to do with moving of 13 TB of data? :O

There are distro mirrors on kernel.org, and the most famous ones
are downloaded by huge number of people on their release day. What
John explained is that the cumulated downloads during the 12 first
hours after FC6 releases totalized 13 TB of data sent to the net,
which is indeed 2 gig links at full load. Impressive !

Willy

