Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263425AbTJBSSY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Oct 2003 14:18:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263426AbTJBSSY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Oct 2003 14:18:24 -0400
Received: from MAIL.13thfloor.at ([212.16.62.51]:63946 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S263425AbTJBSSW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Oct 2003 14:18:22 -0400
Date: Thu, 2 Oct 2003 20:18:21 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: kartikey bhatt <kartik_me@hotmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Can't X be elemenated?
Message-ID: <20031002181821.GB2816@DUK2.13thfloor.at>
Mail-Followup-To: Helge Hafting <helgehaf@aitel.hist.no>,
	kartikey bhatt <kartik_me@hotmail.com>, linux-kernel@vger.kernel.org
References: <Law11-F67ATnLE7P95L00001388@hotmail.com> <3F7BE886.8070401@aitel.hist.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F7BE886.8070401@aitel.hist.no>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 02, 2003 at 10:57:42AM +0200, Helge Hafting wrote:
> kartikey bhatt wrote:
> >hey everyone who have joined this thread, my fundamental question have got
> >out of scope. I mean to say
> >
> >1. Kernel level support for graphics device drivers.
> >2. On top of that, one can develop complete lightweight GUI.
> >3. Maybe kernel can provide support for event handling.
> >
> >and I still stick to my opinion that graphics card is a computer resource
> >that needs to be managed by OS   rather than 3rd party developers.
> 
> The card is managed by the os - X has to ask the kernel nicely to get it.
> (Try starting another X server inside an xterm and see how
> that is refused.)

X :2 (not refused ...)

> The details of drawing the windows is something the os don't
> need to worry about though - that is the job of X.
> 
> Please explain whats wrong about "3rd party developers".  Depending on
> how you look at it, all of linux is "3rd part developers" except from Linus.
> 
> >Just feeding in patches to provide support for AGP gart and DRI
> >is an adhoc solution, a stark immoral choice.
> 
> Explain the immoral part. Committing a crime is (usually) immoral.
> Designing software in a way you dislike isn't.

depends on the moral standards ...

best,
Herbert

