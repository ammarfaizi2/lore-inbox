Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266767AbUFYP1o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266767AbUFYP1o (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 11:27:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266768AbUFYP1n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 11:27:43 -0400
Received: from mx1.redhat.com ([66.187.233.31]:52416 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266767AbUFYP10 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 11:27:26 -0400
Date: Fri, 25 Jun 2004 11:27:14 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Patrick Mochel <mochel@digitalimplant.org>
cc: Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>,
       Swsusp mailing list <swsusp-devel@lists.sourceforge.net>
Subject: Re: SMP support for swsusp (this one actually works for me)
In-Reply-To: <Pine.LNX.4.50.0406241354340.32272-100000@monsoon.he.net>
Message-ID: <Pine.LNX.4.44.0406251126430.9066-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Jun 2004, Patrick Mochel wrote:

> > +#if 0
> ...
> > +#endif
> 
> If that's dead code, why not remove it?

I'm not entirely convinced that is dead code on all
systems ...

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

