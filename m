Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030309AbVKWBhQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030309AbVKWBhQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 20:37:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030308AbVKWBhQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 20:37:16 -0500
Received: from zproxy.gmail.com ([64.233.162.196]:25691 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965074AbVKWBhJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 20:37:09 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mDQ70TfoxzL3nKSK2eJSJGPpGuf/aSxYzjQOy7bEO/NV53GQuHo2/7FFVLfiE3PYvfAJ4Qt3uCpQfBPPNhsg0RDKfJugh/7jEUK0DZD1hXrzSNhHHSjLsZyn9Jt7EjOECll+3ucenylDBw7gpla5cG/AfmFLc6c5nly8AtCAp78=
Message-ID: <625fc13d0511221737u583d10a9ja7bba6078f107e5@mail.gmail.com>
Date: Tue, 22 Nov 2005 19:37:08 -0600
From: Josh Boyer <jwboyer@gmail.com>
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: Christmas list for the kernel
Cc: Andrew Morton <akpm@osdl.org>, s0348365@sms.ed.ac.uk,
       linux-kernel@vger.kernel.org
In-Reply-To: <9e4733910511221709t546089d1id76357256079d8f9@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <9e4733910511221031o44dd90caq2b24fbac1a1bae7b@mail.gmail.com>
	 <200511221839.24202.s0348365@sms.ed.ac.uk>
	 <9e4733910511221110j47e8ddcs1c9936db1eb5f0b4@mail.gmail.com>
	 <20051122164353.4177c59a.akpm@osdl.org>
	 <9e4733910511221709t546089d1id76357256079d8f9@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/22/05, Jon Smirl <jonsmirl@gmail.com> wrote:
> On 11/22/05, Andrew Morton <akpm@osdl.org> wrote:
> > Jon Smirl <jonsmirl@gmail.com> wrote:
> > >
> > > On 11/22/05, Alistair John Strachan <s0348365@sms.ed.ac.uk> wrote:
> > > > On Tuesday 22 November 2005 18:31, Jon Smirl wrote:
> > > > > There have been recent comments about the pace of kernel development
> > > > > slowing.
> > > >
> > > > I doubt the diffstat from the last 6 kernel releases will tell this story.
> > >
> > > Andrew Morton said it: "He suggested this may indicate that the kernel
> > > is nearing completion. "Famous last words, but the actual patch volume
> > > _has_ to drop off one day," said Morton. "We have to finish this thing
> > > one day."
> > >
> > > http://news.zdnet.co.uk/software/linuxunix/0,39020390,39221942,00.htm
> > >
> >
> > I was wrong, as usual.  The trend at http://www.zip.com.au/~akpm/x.jpg is,
> > I think, being maintained.
>
> I wonder what that would look like if you pull Adrian Bunk's changes
> out. He is generating thousands of lines of patches (they're good
> patches but they don't add features).

A change is a change.  You might as well pull out the ppc{32,64} ->
powepc stuff if you're simply looking for new shiny features.  Alot of
that stuff is "just change".  Andrew's chart is tracking change, not
new features.

josh
