Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161518AbWJ3VhE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161518AbWJ3VhE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 16:37:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161519AbWJ3VhD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 16:37:03 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:27340 "EHLO
	rubicon.netdirect.ca") by vger.kernel.org with ESMTP
	id S1161518AbWJ3VhB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 16:37:01 -0500
X-Originating-Ip: 72.57.81.197
Date: Mon, 30 Oct 2006 16:34:08 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: David Rientjes <rientjes@cs.washington.edu>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       trivial@kernel.org
Subject: Re: [PATCH] sched.c : correct comment for this_rq_lock() routine
In-Reply-To: <Pine.LNX.4.64N.0610301308290.17544@attu2.cs.washington.edu>
Message-ID: <Pine.LNX.4.64.0610301623360.13169@localhost.localdomain>
References: <Pine.LNX.4.64.0610301600550.12811@localhost.localdomain>
 <Pine.LNX.4.64N.0610301308290.17544@attu2.cs.washington.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-16.8, required 5, autolearn=not spam, ALL_TRUSTED -1.80,
	BAYES_00 -15.00)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Oct 2006, David Rientjes wrote:

> On Mon, 30 Oct 2006, Robert P. J. Day wrote:
>
> >
> > Correct the comment for the this_rq_lock() routine.
> >
>
> You submitted this same patch two days ago.
>
> 		http://lkml.org/lkml/2006/10/28/54

that's right, i did.  and given that it was a trivial, aesthetic patch
but a couple "git pull" cycles went by without it being applied, i
figured i might as well submit it again.

quite honestly, at this point, given that it's this much trouble to
fix a freaking comment in a single file, i'm seriously losing interest
in wasting any more of my time at this.  life is just too short to
volunteer unpaid labour that just gets dropped on the floor because
you don't know the secret handshake.

rday
