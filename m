Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262775AbTJaCO2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 21:14:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262781AbTJaCO2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 21:14:28 -0500
Received: from serenity.mcc.ac.uk ([130.88.200.93]:60174 "EHLO
	serenity.mcc.ac.uk") by vger.kernel.org with ESMTP id S262775AbTJaCO1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 21:14:27 -0500
Date: Fri, 31 Oct 2003 02:14:25 +0000
From: John Levon <levon@movementarian.org>
To: Dave Jones <davej@redhat.com>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Post-halloween doc updates.
Message-ID: <20031031021425.GB24712@compsoc.man.ac.uk>
References: <20031030141519.GA10700@redhat.com> <1067555512.16868.2.camel@glass.felipe-alfaro.com> <20031031001608.GJ11311@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031031001608.GJ11311@redhat.com>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: King of Woolworths - L'Illustration Musicale
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *1AFOny-000NRq-6v*B02JRCVI4ew*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 31, 2003 at 12:16:08AM +0000, Dave Jones wrote:

>  > > - Another much talked about feature. Ingo Molnar reworked the process
>  > >   scheduler to use an O(1) algorithm.  In operation, you should notice
>  > >   no changes with low loads, and increased scalability with large numbers
>  > >   of processes, especially on large SMP systems.
>  > 
>  > I think we should mention excellent Con Kolivas contributions to the 2.6
>  > kernel scheduler. He did a great job in tunning the scheduler for
>  > maximum interactive feeling.
> 
> With no disrespect to Con, I'm not going to do this, or I'll end up
> spending far too much time adding credits to everyone whoever improved
> something in 2.5.  There's a place for such stuff, and it's aptly named
> 'CREDITS' in toplevel of src dir.

Given that Ingo's reworkings led to horrendous interactive performance
for many desktop users for a long time during 2.5, it seems a little odd
to prefer crediting Ingo over Con given what you've said. How about just
mentioning that we have an O(1) scheduler, plus there has been
significant work on interactive performance.

john
-- 
Khendon's Law:
If the same point is made twice by the same person, the thread is over.
