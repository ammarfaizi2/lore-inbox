Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278797AbRJ3Xom>; Tue, 30 Oct 2001 18:44:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278795AbRJ3Xoe>; Tue, 30 Oct 2001 18:44:34 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:22263
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S278789AbRJ3Xo1>; Tue, 30 Oct 2001 18:44:27 -0500
Date: Tue, 30 Oct 2001 15:44:58 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFC] Proposal For A More Scalable Scheduler ...
Message-ID: <20011030154458.F490@mikef-linux.matchmail.com>
Mail-Followup-To: Davide Libenzi <davidel@xmailserver.org>,
	lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20011030150429.E490@mikef-linux.matchmail.com> <Pine.LNX.4.40.0110301513470.1495-100000@blue1.dev.mcafeelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.40.0110301513470.1495-100000@blue1.dev.mcafeelabs.com>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2001 at 03:14:47PM -0800, Davide Libenzi wrote:
> On Tue, 30 Oct 2001, Mike Fedyk wrote:
> 
> > On Tue, Oct 30, 2001 at 09:02:54AM -0800, Davide Libenzi wrote:
> > > On Tue, 30 Oct 2001, Mike Fedyk wrote:
> >
> > Looking at this again, it probably is preempt safe... I probably merged it
> > wrong.
> >
> > I'll try to fit it into my next kernel...
> 
> No probably You're right and I posted a wrong patch.
> Try to get the one that is here :
> 
> http://www.xmailserver.org/linux-patches/mss.html
> 

That's the one I have, xsched+lats-2.4.13-0.11.diff

2.4.13freeswan-1.91+ac5+preempt+netdev_random+vm_freeswap

I think the main reject was against -ac5.  You wouldn't by chance want to
provide a patch against the -ac kernels, would you?

If not, I'll see what I can do to get them all merged together.

Mike
