Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422663AbWJ3WFy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422663AbWJ3WFy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 17:05:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422680AbWJ3WFy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 17:05:54 -0500
Received: from mail.gmx.de ([213.165.64.20]:14057 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1422663AbWJ3WFx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 17:05:53 -0500
X-Authenticated: #5039886
Date: Mon, 30 Oct 2006 23:05:51 +0100
From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: David Rientjes <rientjes@cs.washington.edu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       trivial@kernel.org
Subject: Re: [PATCH] sched.c : correct comment for this_rq_lock() routine
Message-ID: <20061030220551.GA7828@atjola.homenet>
Mail-Followup-To: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	"Robert P. J. Day" <rpjday@mindspring.com>,
	David Rientjes <rientjes@cs.washington.edu>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	trivial@kernel.org
References: <Pine.LNX.4.64.0610301600550.12811@localhost.localdomain> <Pine.LNX.4.64N.0610301308290.17544@attu2.cs.washington.edu> <Pine.LNX.4.64.0610301623360.13169@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.64.0610301623360.13169@localhost.localdomain>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2006.10.30 16:34:08 -0500, Robert P. J. Day wrote:
> On Mon, 30 Oct 2006, David Rientjes wrote:
> 
> > On Mon, 30 Oct 2006, Robert P. J. Day wrote:
> >
> > >
> > > Correct the comment for the this_rq_lock() routine.
> > >
> >
> > You submitted this same patch two days ago.
> >
> > 		http://lkml.org/lkml/2006/10/28/54
> 
> that's right, i did.  and given that it was a trivial, aesthetic patch
> but a couple "git pull" cycles went by without it being applied, i
> figured i might as well submit it again.
> 
> quite honestly, at this point, given that it's this much trouble to
> fix a freaking comment in a single file, i'm seriously losing interest
> in wasting any more of my time at this.  life is just too short to
> volunteer unpaid labour that just gets dropped on the floor because
> you don't know the secret handshake.

You CC'd trivial@kernel.org, so you've probably read
http://www.kernel.org/pub/linux/kernel/people/bunk/trivial/
which clearly says that it most likely will go into 2.6.20(-rc1). So
your "git pull" tests tell nothing...

I have never submitted a patch to trivial@, so I have no idea if you get
any kind of confirmation that it will be included, but if you get none,
you should probably just assume that it will be included.

Also, you should just take David's reply as a confirmation that your
patch didn't get lost in the noise but was seen by someone. Of course
you should also remember to not re-submit patches that quick, especially
if there is only a weekend in between the two submissions...

Björn
