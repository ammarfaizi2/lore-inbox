Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751171AbWBCKHF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751171AbWBCKHF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 05:07:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751177AbWBCKHE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 05:07:04 -0500
Received: from webbox4.loswebos.de ([213.187.93.205]:60804 "EHLO
	webbox4.loswebos.de") by vger.kernel.org with ESMTP
	id S1751171AbWBCKHB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 05:07:01 -0500
Date: Fri, 3 Feb 2006 11:07:04 +0100
From: Marc Koschewski <marc@osknowledge.org>
To: dtor_core@ameritech.net
Cc: Lee Revell <rlrevell@joe-job.com>,
       Chuck Ebbert <76306.1226@compuserve.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Wanted: hotfixes for -mm kernels
Message-ID: <20060203100703.GA5691@stiffy.osknowledge.org>
References: <200602021502_MC3-1-B772-547@compuserve.com> <1138913633.15691.109.camel@mindpipe> <d120d5000602021345i255bb69eydb67bc1b0a448f8d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d120d5000602021345i255bb69eydb67bc1b0a448f8d@mail.gmail.com>
X-PGP-Fingerprint: D514 7DC1 B5F5 8989 083E  38C9 5ECF E5BD 3430 ABF5
X-PGP-Key: http://www.osknowledge.org/~marc/pubkey.asc
X-Operating-System: Linux stiffy 2.6.16-rc2-marc-g826eeb53
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Dmitry Torokhov <dmitry.torokhov@gmail.com> [2006-02-02 16:45:52 -0500]:

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

... that's just why I so often wish to have a -git tree, Andrew. ;)

Marc
