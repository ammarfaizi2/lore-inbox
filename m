Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263713AbTJCLek (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 07:34:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263714AbTJCLek
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 07:34:40 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:36771 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263713AbTJCLej
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 07:34:39 -0400
Date: Fri, 3 Oct 2003 12:34:37 +0100
From: Matthew Wilcox <willy@debian.org>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Matthew Wilcox <willy@debian.org>
Subject: Re: must-fix list reconciliation
Message-ID: <20031003113437.GL24824@parcelfarce.linux.theplanet.co.uk>
References: <3F7D3F37.1060005@cyberone.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F7D3F37.1060005@cyberone.com.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 03, 2003 at 07:19:51PM +1000, Nick Piggin wrote:
> Hi everyone,
> As you might or might not know, the must-fix / should-fix lists have been
> inadvertently forked. We are merging them again, so please don't update
> the wiki until we have worked out what to do with them. This should be a
> day or two at most.
> 
> I had the idea that maybe we could put them into the source tree, and
> encourage people to keep them up to date by making them become criteria
> for the feature and code freeze. Comments?

I'm a little disappointed that after I spent time converting them into
the wiki form, you're now proposing abandoning them again.  This seems
like a retrograde step.

What I'd be more interested in doing is combining the must- and should-
fix lists.  As a first pass, just put all the must-fix items on the
should-fix list at pri 4.  One of the things I did was delete the things
that appeared on both lists.  This would obviously be easier if they
were in one list ;-)

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
