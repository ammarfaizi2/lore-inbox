Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261443AbULXUA2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261443AbULXUA2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Dec 2004 15:00:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261444AbULXUA2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Dec 2004 15:00:28 -0500
Received: from MAIL.13thfloor.at ([212.16.62.51]:63164 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S261443AbULXUAX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Dec 2004 15:00:23 -0500
Date: Fri, 24 Dec 2004 21:00:22 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Ingo Molnar <mingo@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: apic and 8254 wraparound ...
Message-ID: <20041224200022.GA14956@mail.13thfloor.at>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Ingo Molnar <mingo@redhat.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20041224001144.GA5192@mail.13thfloor.at> <1103845033.15193.6.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1103845033.15193.6.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Alan!

On Thu, Dec 23, 2004 at 11:37:17PM +0000, Alan Cox wrote:
> On Gwe, 2004-12-24 at 00:11, Herbert Poetzl wrote:
> > I don't know what kind of errors the buggy Mercury/
> > Neptune chipset timers can cause, maybe they need some
> > special handling, but from the available code, what 
> > about something like this:
> 
> Data sheet is on the intel site, but essentially 
> latching bugs on the reads.

somehow I'm unable to locate it, I can see the 
430TX and 430HX but not the 430NX and 430LX ...

do you have an url for me?

TIA,
Herbert

> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
