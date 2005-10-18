Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932417AbVJRGp6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932417AbVJRGp6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 02:45:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751445AbVJRGp6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 02:45:58 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:37254 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751444AbVJRGp4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 02:45:56 -0400
Date: Tue, 18 Oct 2005 02:45:27 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@localhost.localdomain
To: Matt Mackall <mpm@selenic.com>
cc: linux-kernel@vger.kernel.org, Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Esben Nielsen <simlo@phys.au.dk>, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: ketchup+rt with ktimers added.
In-Reply-To: <20051018063031.GR26160@waste.org>
Message-ID: <Pine.LNX.4.58.0510180239550.13581@localhost.localdomain>
References: <Pine.LNX.4.58.0510170316310.5859@localhost.localdomain>
 <20051017213915.GN26160@waste.org> <Pine.LNX.4.58.0510180211320.13581@localhost.localdomain>
 <20051018063031.GR26160@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 17 Oct 2005, Matt Mackall wrote:

> On Tue, Oct 18, 2005 at 02:20:38AM -0400, Steven Rostedt wrote:

> > I did not know about this extension.  Good to know, thanks.
>
> Didn't exist until today, motivated entirely by your message.

Good, so this is a good example of some one sending crap (me) inspiring
someone else into greatness (you).  Sorry, this is an inside joke between
Ingo, Thomas, others and myself. :-) (it had nothing to do with you or
your code, it was all about RT)

>
> > > > Since the base version of Michal Schmidt's ketchup-0.9+rt didn't include
> > > > Esben Nielsen's addition of handling Ingo's older kernels, I again
> > > > included it with this patch.
> > >
> > > That's been in tip for a while:
> > >
> > > http://selenic.com/repo/ketchup/
> > >
> >
> > I didn't know about your repo directory.  Sorry, didn't have time to look
> > too deep into this. I just did a few searches on the web and found
> > different links scattered around.  I was just interested in the RT stuff,
> > so I didn't go to deep.
> >
> > Actually, if you had a link to the repo from
> > http://www.selenic.com/ketchup/ I would have found it.
>
> It's here:
>
> http://www.selenic.com/ketchup/wiki/

Ahh, I did see this. That word "Mercurial" scared me from looking further!

-- Steve

