Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932421AbVI3Afj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932421AbVI3Afj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 20:35:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932419AbVI3Afj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 20:35:39 -0400
Received: from smtp.osdl.org ([65.172.181.4]:10394 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932415AbVI3Afi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 20:35:38 -0400
Date: Thu, 29 Sep 2005 17:35:27 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Luben Tuikov <ltuikov@yahoo.com>
cc: Arjan van de Ven <arjan@infradead.org>, Willy Tarreau <willy@w.ods.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Luben Tuikov <luben_tuikov@adaptec.com>,
       Jeff Garzik <jgarzik@pobox.com>
Subject: Re: I request inclusion of SAS Transport Layer and AIC-94xx into
 the kernel
In-Reply-To: <20050929232013.95117.qmail@web31810.mail.mud.yahoo.com>
Message-ID: <Pine.LNX.4.64.0509291730360.3378@g5.osdl.org>
References: <20050929232013.95117.qmail@web31810.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 29 Sep 2005, Luben Tuikov wrote:
>
> >    It's like real science: if you have a theory that doesn't match 
> >    experiments, it doesn't matter _how_ much you like that theory. It's
> >    wrong. You can use it as an approximation, but you MUST keep in mind 
> >    that it's an approximation.
> 
> But this is _the_ definition of a theory.  No one is arguing that
> a theory is not an approximation to observed behaviour.

No.

A scientific theory is an approximation of observed behaviour WITH NO 
KNOWN HOLES.

Once there are known holes in the theory, it's not a scientific theory. At 
best it's an approximation, but quite possibly it's just plain wrong.

And that's my point. Specs are not only almost invariably badly written, 
they also never actually match reality. 

At which point at _best_ it's just an approximation. At worst, it's much 
worse. At worst, it causes people to ignore reality, and then it becomes 
religion.

And that's way _way_ too common. People who ignore reality are sadly not 
at all unusual.

"But the spec says ..." is pretty much always a sign of somebody who has 
just blocked out the fact that some device doesn't.

So don't talk about specs.

Talk about working code that is _readable_ and _works_.

There's an absolutely mindbogglingly huge difference between the two.

			Linus
