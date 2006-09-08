Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751194AbWIHWZ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751194AbWIHWZ1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 18:25:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751195AbWIHWZ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 18:25:26 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:2824 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1751194AbWIHWZZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 18:25:25 -0400
Date: Fri, 8 Sep 2006 18:25:24 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Oliver Neukum <oliver@neukum.org>
cc: paulmck@us.ibm.com, David Howells <dhowells@redhat.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Uses for memory barriers
In-Reply-To: <200609082346.20740.oliver@neukum.org>
Message-ID: <Pine.LNX.4.44L0.0609081824190.8280-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Sep 2006, Oliver Neukum wrote:

> > Again you have misunderstood.  The original code was _not_ incorrect.  I 
> > was asking: Given the code as stated, would the assertion ever fail?
> 
> I claim the right to call code that fails its own assertions incorrect. :-)

Touche!

> > The code _was_ correct for my purposes, namely, to illustrate a technical 
> > point about the behavior of memory barriers.
> 
> I would say that the code may fail the assertion purely based
> on the formal definition of a memory barrier. And do so in a subtle
> and inobvious way.

But what _is_ the formal definition of a memory barrier?  I've never seen 
one that was complete and correct.

Alan Stern

