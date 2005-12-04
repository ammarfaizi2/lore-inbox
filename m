Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932222AbVLDSfm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932222AbVLDSfm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Dec 2005 13:35:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932265AbVLDSfm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Dec 2005 13:35:42 -0500
Received: from wproxy.gmail.com ([64.233.184.207]:10371 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932222AbVLDSfl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Dec 2005 13:35:41 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AU6U9EY1JOeAM022fQVA2YqhcxzLGajb8a9+ewOnX7WDshM0HXEExa4Xlayu7Bz1aTa2kqPUykUF8/p9q9Dw/9inH2o8R7xTJEe6WvZTQHRGO/pU2xZRBUPS57rVeJlFrAZFiTK0ZN5rlnRh93D4SawKYzLl6s5y21dpo1J3ddc=
Message-ID: <9a8748490512041035l53bf4578n6372c2e3d7c96322@mail.gmail.com>
Date: Sun, 4 Dec 2005 19:35:40 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Subject: Re: Linux 2.6.15-rc5: off-line for a week
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <6bffcb0e0512040926xdff72a8t@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.64.0512032155290.3099@g5.osdl.org>
	 <9a8748490512040856m5aaeead3o8b11ae69824fec9@mail.gmail.com>
	 <6bffcb0e0512040926xdff72a8t@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/4/05, Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:
> Hi,
>
> On 04/12/05, Jesper Juhl <jesper.juhl@gmail.com> wrote:
> > On 12/4/05, Linus Torvalds <torvalds@osdl.org> wrote:
> > >
> > > There's a rc5 out there now, largely because I'm going to be out of email
> > > contact for the next week, and while I wish people were religiously
> > > testing all the nightly snapshots, the fact is, you guys don't.
> > >
> > I'll bet a lot of people do test the -rc's and a lot of the snapshots
> > (if not all), at least I know I try my best to do so, but you'd never
> > notice since I rarely run into trouble with my regular config and thus
> > don't post any bug reports.   I don't think that's uncommon.
> >
>
> IMHO KLive is solution.
> http://klive.cpushare.com/
>
Hmm, yes, this will allow some info to be gathered - I'm now running
this, thanks for the pointer.

But, forcing users to install python, twistd, zope interface etc is
not exactely making it simple for people to run (and they have to know
about it first as well).

If this was instead implemented in C and distributed with the kernel
source I think a lot more people would run it and the data gathered
would be a lot more useful.

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
