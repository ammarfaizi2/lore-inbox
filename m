Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964830AbVLFH6t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964830AbVLFH6t (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 02:58:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964836AbVLFH6t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 02:58:49 -0500
Received: from nproxy.gmail.com ([64.233.182.203]:36018 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964830AbVLFH6r convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 02:58:47 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rI26Cv5ORNhSDy/jIJ5OZImapDeB7B9BAKuTUniMMYJwIDswBsmgcCzI3z0PXjIEE99DU+AEDiijeuDpt4L4oKy1XUcVKJH6u46vo0ohMkL4AuZRJavyFPG+MdQXgvphdvdQb1Jg94CNqN9fZwY+Y0cfFcrm4QsVggPpVwkDv4c=
Message-ID: <2cd57c900512052358m5b631204i@mail.gmail.com>
Date: Tue, 6 Dec 2005 15:58:46 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
To: Greg KH <greg@kroah.com>
Subject: Re: Linux in a binary world... a doomsday scenario
Cc: Tim Bird <tim.bird@am.sony.com>, Dave Airlie <airlied@gmail.com>,
       David Woodhouse <dwmw2@infradead.org>, arjan@infradead.org,
       andrew@walrond.org, linux-kernel@vger.kernel.org
In-Reply-To: <20051206040820.GB26602@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <21d7e9970512051610n1244467am12adc8373c1a4473@mail.gmail.com>
	 <4394DA1D.3090007@am.sony.com> <20051206040820.GB26602@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2005/12/6, Greg KH <greg@kroah.com>:
> On Mon, Dec 05, 2005 at 04:23:57PM -0800, Tim Bird wrote:
> > Dave Airlie wrote:
> > >>To the larger argument about supporting binary drivers,
> > >>all Arjan manages to prove with his post is that,
> > >>if handled in the worst possible way, support for
> > >>binary drivers would be a disaster.  Who can disagree
> > >>with that?
> > >>
> > > And do you think that given the opportunity, any company is going
> > > spend the extra money required to not do it in the worst possible
> > > way??
> >
> > I meant "handled in the worst possible way by
> > the kernel developers".  It *is* possible to define
> > stable APIs and have them used successfully.
> >
> > POSIX is not the greatest example, but it seems
> > to work OK.  I realize that drivers are more
> > tightly bound to the kernel than are libraries
> > or applications, but sheesh, this is not rocket
> > science.
>
> For people to think that the kernel developers are just "too dumb" to
> make a stable kernel api (and yes, I've had people accuse me of this
> many times to my face[1]) shows a total lack of understanding as to
> _why_ we change the in-kernel api all the time.  Please see
> Documentation/stable_api_nonsense.txt for details on this.
>
> thanks,
>
> greg k-h
>
> [1] My usual response is, "If we are so dumb, why are you using the kernel
>     made by us?", which usually stops the conversation right there.

Your response is nonsense. It has the same logic as saying "If
proprietary software is wrong, why are you using it?".
Everybody are using proprietary software, aren't they?

If the pattern goes in A->B .... ->A, then the developers are really dumb.
--
Coywolf Qi Hunt
http://sosdg.org/~coywolf/
