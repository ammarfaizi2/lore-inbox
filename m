Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932310AbWBBVs1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932310AbWBBVs1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 16:48:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932311AbWBBVs1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 16:48:27 -0500
Received: from xenotime.net ([66.160.160.81]:27328 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932304AbWBBVs0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 16:48:26 -0500
Date: Thu, 2 Feb 2006 13:48:18 -0800 (PST)
From: "Randy.Dunlap" <rdunlap@xenotime.net>
X-X-Sender: rddunlap@shark.he.net
To: dtor_core@ameritech.net
cc: Lee Revell <rlrevell@joe-job.com>,
       Chuck Ebbert <76306.1226@compuserve.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Wanted: hotfixes for -mm kernels
In-Reply-To: <d120d5000602021345i255bb69eydb67bc1b0a448f8d@mail.gmail.com>
Message-ID: <Pine.LNX.4.58.0602021346510.16597@shark.he.net>
References: <200602021502_MC3-1-B772-547@compuserve.com> 
 <1138913633.15691.109.camel@mindpipe> <d120d5000602021345i255bb69eydb67bc1b0a448f8d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Feb 2006, Dmitry Torokhov wrote:

> On 2/2/06, Lee Revell <rlrevell@joe-job.com> wrote:
> > On Thu, 2006-02-02 at 15:00 -0500, Chuck Ebbert wrote:
> > > Most -mm kernels have small but critical bugs that are found shortly
> > > after release.  Patches for these are posted on linux-kernel but
> > > they aren't made available on kernel.org until the next -mm release.
> > >
> > > Would it be possible to create a hotfix/ directory for each -mm
> > > release and put those patches there?  A README could explain that
> > > the fixes are untested.  At least people reading the files could
> > > see an issue exists even if they're not brave enough to try the
> > > patch. :)
> >
> > I doubt it - mm is an experimental kernel, hotfixes only make sense for
> > production stuff.  It moves too fast.
> >
> > A better question is what does -mm give you that mainline does not, that
> > causes you to want to "stabilize" a specific -mm version?
> >
>
> Some people just run -mm so the hotfixes/* would help them to get
> their boxes running until the next -mm without having to hunt through
> LKML for bugs already reported/fixed. This will allow better testing
> coverage because most obvious bugs are caught almost immediately and
> then people can continue using -mm to find more stuff.

Yep.  I think it's a good idea, although it does move fast, like
Lee says.  I'd be willing to help if e.g. there was some place
where several of us could upload patches to.

-- 
~Randy
