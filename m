Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423490AbWJaPan@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423490AbWJaPan (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 10:30:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423491AbWJaPan
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 10:30:43 -0500
Received: from DENETHOR.UNI-MUENSTER.DE ([128.176.180.180]:33507 "EHLO
	denethor.uni-muenster.de") by vger.kernel.org with ESMTP
	id S1423490AbWJaPam convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 10:30:42 -0500
Date: Tue, 31 Oct 2006 16:30:21 +0100
From: Borislav Petkov <petkov@math.uni-muenster.de>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: David Rientjes <rientjes@cs.washington.edu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched.c : correct comment for this_rq_lock() routine
Message-ID: <20061031153021.GA14505@gollum.tnic>
Reply-To: petkov@math.uni-muenster.de
References: <Pine.LNX.4.64.0610301600550.12811@localhost.localdomain> <Pine.LNX.4.64N.0610301308290.17544@attu2.cs.washington.edu> <Pine.LNX.4.64.0610301623360.13169@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0610301623360.13169@localhost.localdomain>
User-Agent: Mutt/1.5.13 (2006-08-11)
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2006 at 04:34:08PM -0500, Robert P. J. Day wrote:
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

In case you're still doubtful about volunteering:

http://lkml.org/lkml/2004/12/20/255

-- 
Regards/Gruﬂ,
    Boris.
