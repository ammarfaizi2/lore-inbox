Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267403AbUIJRWw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267403AbUIJRWw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 13:22:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267527AbUIJRWw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 13:22:52 -0400
Received: from rproxy.gmail.com ([64.233.170.202]:14623 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S267403AbUIJRWt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 13:22:49 -0400
Message-ID: <9e47339104091010221f03ec06@mail.gmail.com>
Date: Fri, 10 Sep 2004 13:22:49 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: radeon-pre-2
Cc: =?ISO-8859-1?Q?Felix_K=FChling?= <fxkuehl@gmx.de>,
       DRI Devel <dri-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <1094832031.17883.1.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <E3389AF2-0272-11D9-A8D1-000A95F07A7A@fs.ei.tum.de>
	 <DA459966-02B9-11D9-A8D1-000A95F07A7A@fs.ei.tum.de>
	 <9e47339104090917353554a586@mail.gmail.com>
	 <Pine.LNX.4.58.0409100209100.32064@skynet>
	 <9e47339104090919015b5b5a4d@mail.gmail.com>
	 <20040910153135.4310c13a.felix@trabant>
	 <9e47339104091008115b821912@mail.gmail.com>
	 <1094829278.17801.18.camel@localhost.localdomain>
	 <9e4733910409100937126dc0e7@mail.gmail.com>
	 <1094832031.17883.1.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Sep 2004 17:00:33 +0100, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> > > > On Gwe, 2004-09-10 at 17:37, Jon Smirl wrote:
> > > >  The plan is to add fbdev capability to the DRM so that you won't need
> > > >  to run vesafb. DRM will give you the features found in VESA fb instead
> > > >  of you needing to load it separately.
> > > >
> > > Your personal plan.
> >
> > I'm writing code to fix the conflicts between vesafb, fbdev, DRM and
> > XAA and you're not. Either provide your own code for sorting out the
> > resource conflicts or keep your opinions to yourself.
> 
> You can write all the code you like its still "your personal plan". I
> have seen nothing but rejection of it by the kernel community.

My "personal plan" has been posted for comment to all relevant email
lists -- xorg, fbdev, dri, and lkml. All feedback that was received
was addressed and incorporated. Various aspects of the plan were
talked about at three OLS sessions. Everyone has been invited to
participate.  I even went through significant effort to encourage
fbdev developers to come to OLS and discuss the changes.

Plan as orginally posted to lkml:
http://lkml.org/lkml/2004/8/2/111

If the kernel community is going to reject this plan please let me
know now so that I won't waste a year of my life writing the code for
it. If Linux wants to stay with a 1980's desktop that's fine; at least
Microsoft and Apple are innovating.

-- 
Jon Smirl
jonsmirl@gmail.com
