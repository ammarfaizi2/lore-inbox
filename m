Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261282AbUKWPP1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261282AbUKWPP1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 10:15:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261291AbUKWPP0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 10:15:26 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:39374 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261282AbUKWPPO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 10:15:14 -0500
Date: Tue, 23 Nov 2004 16:14:35 +0100
From: Jens Axboe <axboe@suse.de>
To: Kristian =?iso-8859-1?Q?S=F8rensen?= <ks@cs.aau.dk>
Cc: umbrella-announce@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: Umbrella-0.5.1 stable released
Message-ID: <20041123151435.GD13174@suse.de>
References: <200411231544.09701.ks@cs.aau.dk> <20041123144812.GB13174@suse.de> <200411231604.25522.ks@cs.aau.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200411231604.25522.ks@cs.aau.dk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 23 2004, Kristian Sørensen wrote:
> On Tuesday 23 November 2004 15:48, Jens Axboe wrote:
> > On Tue, Nov 23 2004, Kristian Sørensen wrote:
> > > Hi all!
> > >
> > > We are pleased to inform you that Umbrella 0.5.1 is now released. This is
> > > a very stable release, which has been tested on our workstations for 6+
> > > days continously.
> > >
> > > Get the release here:
> > > http://prdownloads.sourceforge.net/umbrella/umbrella-0.5.1.tar.bz2?downlo
> > >ad
> > >
> > > The strategy of the further development of Umbrella is to have
> > > * STABLE and well tested Umbrella as patches
> > > * UNSTABLE bleeding edge technology in the CVS module umbrella-devel
> > >
> > >
> > > We have lots of new stuff and optimizations in the CVS, which slowley
> > > will be applied and tested before getting realeased as patches. Currently
> > > we have these in the CVS:
> > > * New, small and efficient bit vector
> > > * New datastructure for storing restrictions
> > >    See this thread for details:
> > >   
> > > http://sourceforge.net/mailarchive/forum.php?thread_id=5886152&forum_id=4
> > >2079 * Restrictions on process signaling
> > > * Authentication of binaries (still under development for the 0.6
> > > release)
> >
> > And umbrella is?
> Undskyld - vi plejer at tilføje en beskrivelse... her kommer den:
> 
> Umbrella is a security mechanism which implements a combination of
> process-based Mandatory Access Control (MAC) and authentication of
> files through Digital Signed Binaries (DSB) for Linux based consumer
> electronics devices ranging from mobile phones to settop boxes.
> 
> Umbrella is implemented on top of the Linux Security Modules (LSM)
> framework.  The MAC scheme is enforced by a set of restrictions on
> each process. This policy is distributed with a binary in form of
> execute restrictions (in the file signature) and within the program,
> where the developer has the opportunity of making a "restricted fork"
> for setting restrictions for new children.

Thanks! Sometimes being lazy does pay off.

-- 
Jens Axboe

