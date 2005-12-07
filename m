Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751716AbVLGUWd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751716AbVLGUWd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 15:22:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751678AbVLGUWc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 15:22:32 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:47248 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751214AbVLGUWc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 15:22:32 -0500
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Arjan van de Ven <arjan@infradead.org>,
       "Randy.Dunlap" <rdunlap@xenotime.net>, Rik van Riel <riel@redhat.com>,
       Andrea Arcangeli <andrea@suse.de>,
       William Lee Irwin III <wli@holomorphy.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Reply-To: Gerrit Huizenga <gh@us.ibm.com>
From: Gerrit Huizenga <gh@us.ibm.com>
Subject: Re: Linux in a binary world... a doomsday scenario 
In-reply-to: Your message of Wed, 07 Dec 2005 20:53:03 +0100.
             <Pine.LNX.4.62.0512072049110.24915@pademelon.sonytel.be> 
Date: Wed, 07 Dec 2005 12:22:24 -0800
Message-Id: <E1Ek5o0-00061j-00@w-gerrit.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 07 Dec 2005 20:53:03 +0100, Geert Uytterhoeven wrote:
> On Wed, 7 Dec 2005, Arjan van de Ven wrote:
> > > Such lists could tell us not only which devices work (are
> > > supported with open source drivers) but also which devices
> > > are not supported and hence may need attention.
> > > 
> > > There has been some discussion about OSDL attempting to do this.
> > 
> > the biggest pitfal by having this done by a commercial entity or an
> > entity with commercial funding is that there is a LOT of pressure to
> > call things with binary drivers also certified/working. 
> > It has to be an entity that can resist that pressure; if OSDL can,
> > great. But their funding is partially from sources that will try to put
> > that pressure on I suspect...
> > So I would almost rather have a separate "kicked off and supported by
> > OSDL" organisation with its own charter than have OSDL do it itself. I
> > can imagine OSDL feeling the same as well ...
> 
> What about linux/Documentation/, which is maintained by us (as in `the
> community', not by `commercial entity that can be pressured')?
> 
> At least for a `positive' lists it's not that difficult: if the driver is in
> the tree, just add the supported hardware to the list in linux/Documentation/.
> 
> Whether we want to put a `negative' list there as well is another question.
> Perhaps some form of `to do' or `drivers wanted' list?

I'm a little less worried about OSDL advocating binary drivers.  I
*am* more worried about how the message goes out, how the information
becomes visible to the right people, etc.  I think OSDL can help there;
the project managers, product marking people, senior manager's etc. at
these various companies have business models that assume Linux is
"just like everything else" and these people don't go rooting around
in linux/Documentation looking for the answers to their business model.
OSDL can help here since more business folks talk to OSDL.

And, by calling attention to those items which do and do not have source
drivers available along with the education on business reasons for
avoiding binary drivers might help get the message through to more of
the right people.

Ideally, any OSDL effort would also be reviewed and contributed to by
the development community to keep it focused in the right directions.

gerrit
