Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314225AbSDRC5K>; Wed, 17 Apr 2002 22:57:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314227AbSDRC5J>; Wed, 17 Apr 2002 22:57:09 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:57582
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S314225AbSDRC5J>; Wed, 17 Apr 2002 22:57:09 -0400
Date: Wed, 17 Apr 2002 19:59:39 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RAID superblock confusion
Message-ID: <20020418025939.GG574@matchmail.com>
Mail-Followup-To: Neil Brown <neilb@cse.unsw.edu.au>,
	linux-kernel@vger.kernel.org
In-Reply-To: <200204101533.g3AFXwS09100@vindaloo.ras.ucalgary.ca> <20020410184010.GC3509@turbolinux.com> <200204101924.g3AJOp113305@vindaloo.ras.ucalgary.ca> <20020410193812.GE3509@turbolinux.com> <200204102037.g3AKbmT14222@vindaloo.ras.ucalgary.ca> <15540.59659.114876.390224@notabene.cse.unsw.edu.au> <200204131926.g3DJQGI06532@vindaloo.ras.ucalgary.ca> <15550.10053.834276.18723@notabene.cse.unsw.edu.au> <20020418021053.GF574@matchmail.com> <15550.11818.429509.22486@notabene.cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2002 at 12:23:38PM +1000, Neil Brown wrote:
> On Wednesday April 17, mfedyk@matchmail.com wrote:
> > On Thu, Apr 18, 2002 at 11:54:13AM +1000, Neil Brown wrote:
> > > On Saturday April 13, rgooch@ras.ucalgary.ca wrote:
> > > > If there was only a "do as I say, regardless" mode, I would be happy.
> > > > This programmer-knows-best attitude smacks of M$.
> > > 
> > > mdadm will do as you say, reguardless - if you ask it to.  Have you
> > > tried mdadm?
> > >    http://www.cse.unsw.edu.au/~neilb/source/mdadm/
> > 
> > Niel, do you plan to merge mdadm into the raidtools package?  It sounds like
> > it belongs there.
> 
> No.
> If distributions want to distribute mdadm together with the stuff from
> raidtools, then that is up to them.
> But from a development perspective, I don't see any value in making a
> single source distribution.

Why's that?  Don't they compliment each other, or is mdadm a replacement?
If it's not a replacement, combining it with raidtools2 would probably get
it into distributions faster and people have already been taught with
countless how-tos that you need the raidtools package...

Hmm, checking now debian has already packaged mdadm for debian 3.0 (woody),
so raidtools just may become obsoleted so my argument is probably moot...

ehh, what's one more message on lkml anyway? ;)

Mike
