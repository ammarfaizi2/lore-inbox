Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262840AbUCRSDz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 13:03:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262842AbUCRSDz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 13:03:55 -0500
Received: from mx1.redhat.com ([66.187.233.31]:30438 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262840AbUCRSDr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 13:03:47 -0500
Date: Thu, 18 Mar 2004 13:03:43 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Rajesh Venkatasubramanian <vrajesh@umich.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-rc1-aa1
In-Reply-To: <Pine.GSO.4.58.0403181228360.24039@blue.engin.umich.edu>
Message-ID: <Pine.LNX.4.44.0403181303280.22002-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Mar 2004, Rajesh Venkatasubramanian wrote:

> > Yeah, we'll definately need the prio_tree stuff before the
> > object based rmap can go into the mainline kernel...
> 
> The prio_tree stuff is progressing well. I managed to boot and do some
> preliminary testing both on UP and SMP. I want to test it bit more.
> Moreover, I am yet to merge it with objrmap. I want to finish that
> and run some tests - rmap-test.c, test-mmap3.c, etc.
> 
> If you are interested in seeing how it looks now:
> 
> http://www-personal.engin.umich.edu/~vrajesh/linux/prio_tree/

Cool.  I'll definately take a look ...

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

