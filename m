Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278808AbRJ3Xxy>; Tue, 30 Oct 2001 18:53:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278807AbRJ3Xxo>; Tue, 30 Oct 2001 18:53:44 -0500
Received: from [208.129.208.52] ([208.129.208.52]:4612 "EHLO xmailserver.org")
	by vger.kernel.org with ESMTP id <S278800AbRJ3Xxf>;
	Tue, 30 Oct 2001 18:53:35 -0500
Date: Tue, 30 Oct 2001 16:01:41 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Mike Fedyk <mfedyk@matchmail.com>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFC] Proposal For A More Scalable Scheduler ...
In-Reply-To: <20011030154458.F490@mikef-linux.matchmail.com>
Message-ID: <Pine.LNX.4.40.0110301558500.1495-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Oct 2001, Mike Fedyk wrote:

> On Tue, Oct 30, 2001 at 03:14:47PM -0800, Davide Libenzi wrote:
> > On Tue, 30 Oct 2001, Mike Fedyk wrote:
> >
> > > On Tue, Oct 30, 2001 at 09:02:54AM -0800, Davide Libenzi wrote:
> > > > On Tue, 30 Oct 2001, Mike Fedyk wrote:
> > >
> > > Looking at this again, it probably is preempt safe... I probably merged it
> > > wrong.
> > >
> > > I'll try to fit it into my next kernel...
> >
> > No probably You're right and I posted a wrong patch.
> > Try to get the one that is here :
> >
> > http://www.xmailserver.org/linux-patches/mss.html
> >
>
> That's the one I have, xsched+lats-2.4.13-0.11.diff
>
> 2.4.13freeswan-1.91+ac5+preempt+netdev_random+vm_freeswap
>
> I think the main reject was against -ac5.  You wouldn't by chance want to
> provide a patch against the -ac kernels, would you?

No, I prefer to work with vanilla versions.
It should not be a problem the merge anyway.
Look that the patch you donwloaded ( xsched+lats-* ) is the one that has
the LatSched latency sampler patch.




- Davide


