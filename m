Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263914AbTLJUOw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 15:14:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263918AbTLJUOw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 15:14:52 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:41739
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id S263914AbTLJUOu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 15:14:50 -0500
Date: Wed, 10 Dec 2003 12:09:09 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Linus Torvalds <torvalds@osdl.org>
cc: Larry McVoy <lm@bitmover.com>, Arjan van de Ven <arjanv@redhat.com>,
       Valdis.Kletnieks@vt.edu, Kendall Bennett <KendallB@scitechsoft.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Linux GPL and binary module exception clause?
In-Reply-To: <Pine.LNX.4.58.0312100959180.29676@home.osdl.org>
Message-ID: <Pine.LNX.4.10.10312101152090.3805-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Didn't your earlier public comments state in clear terms, each kernel
release it self has a unique module interface.  This would be the
effective API for the snap shot in time.  Where as claims of it being a
moving target is between releases?  Thus binary module writers get what
they get?

This looks to be your position in the past.

With this in mind, it makes each "published" source the manual unique into
itself.

I am just a little confused and fuzzy around the edges.

Andre Hedrick
LAD Storage Consulting Group

PS: Nobody has yet to comment that I have remaind civil throught the
thread :-) whoops!

On Wed, 10 Dec 2003, Linus Torvalds wrote:

> 
> On Wed, 10 Dec 2003, Larry McVoy wrote:
> >
> > I see.  And your argument, had it prevailed 5 years ago, would have
> > invalidated the following, would it not?  The following from one of the
> > Microsoft lawsuits.
> 
> No it wouldn't.
> 
> Microsoft very much _has_ a binary API to their drivers, in a way that
> Linux doesn't.
> 
> MS has to have that binary API exactly because they live in a binary-only
> world. They've basically put that requirement on themselves by having
> binary-only distributions.
> 
> So your argument doesn't fly. To Microsoft, a "driver" is just another
> external entity, with documented API's, and they indeed ship their _own_
> drivers that way too. And all third-party drivers do the same thing.
> 
> So there is no analogy to the Linux case. In Linux, no fixed binary API
> exists, and the way normal drivers are distributed are as GPL'd source
> code.
> 
> 			Linus
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

