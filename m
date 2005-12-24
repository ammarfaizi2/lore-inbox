Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932431AbVLXMl2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932431AbVLXMl2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Dec 2005 07:41:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932524AbVLXMl2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Dec 2005 07:41:28 -0500
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:36531 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932431AbVLXMl2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Dec 2005 07:41:28 -0500
Date: Sat, 24 Dec 2005 07:41:13 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: ed <ed@ednevitible.co.uk>
cc: Pekka Enberg <penberg@cs.helsinki.fi>, Greg Kroah-Hartman <gregkh@suse.de>,
       linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Book recommendations
In-Reply-To: <20051224123828.208a1c24@workstation>
Message-ID: <Pine.LNX.4.58.0512240736150.4523@gandalf.stny.rr.com>
References: <20051223231115.5f678e5a@workstation> <1135383110.5774.12.camel@localhost.localdomain>
 <84144f020512240233kc5508a1qc37a9af7b1f84281@mail.gmail.com>
 <20051224123828.208a1c24@workstation>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 24 Dec 2005, ed wrote:

> On Sat, 24 Dec 2005 12:33:32 +0200
> Pekka Enberg <penberg@cs.helsinki.fi> wrote:
>
> > On 12/24/05, Steven Rostedt <rostedt@goodmis.org> wrote:
> > > Previously, I recommended three books:
> > >
> > > http://www.kerneltraffic.org/kernel-traffic/kt20050605_312.html#8
> >
> > FWIW, I would recommend all three as well.
>
> Thanks for the advice people, they're on my amazon wish list, I'll see
> if the local library can get them in too, might save some money!
>
> Do most people read the books before starting out? Is it something I can
> grasp through reading the kernel sources, I'm not shy to reading, just
> wondering.

The best way is to have the books as you walk through the code.  The books
themselves are not very useful if you are not looking at the code while
you read them. Let me rephrase that, the books are much more helpful when
the code is in front of you, and you can experiment with modules and such,
and do the examples in the books.

Warning, the books are much more static than the kernel.  So some of the
examples in the books will not work with the latest kernels, but if you
find one, it's OK to pop a quick question here, and you might get an
answer for a current example.  But check out the websites listed in the
book first, I believe they have updates.

-- Steve

