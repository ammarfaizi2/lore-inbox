Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317215AbSGSX1r>; Fri, 19 Jul 2002 19:27:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317217AbSGSX1r>; Fri, 19 Jul 2002 19:27:47 -0400
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:54269 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S317215AbSGSX1q>; Fri, 19 Jul 2002 19:27:46 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Fri, 19 Jul 2002 17:28:55 -0600
To: Hans Reiser <reiser@namesys.com>
Cc: Michael Hohnbaum <hohnbaum@us.ibm.com>,
       "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
       Guillaume Boissiere <boissiere@adiglobal.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6] Most likely to be merged by Halloween... THE LIST]
Message-ID: <20020719232855.GH10315@clusterfs.com>
Mail-Followup-To: Hans Reiser <reiser@namesys.com>,
	Michael Hohnbaum <hohnbaum@us.ibm.com>,
	"Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
	Guillaume Boissiere <boissiere@adiglobal.com>,
	linux-kernel@vger.kernel.org
References: <3D3875D4.3090102@us.ibm.com> <1027111243.1269.94.camel@dyn9-47-17-90.beaverton.ibm.com> <3D388479.1060908@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D388479.1060908@namesys.com>
User-Agent: Mutt/1.3.28i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 20, 2002  01:28 +0400, Hans Reiser wrote:
> Is Halloween the deadline for submission of patches, or the deadline for 
> inclusion?  If I send in reiser4 on Halloween day according to some 
> timezone;-), have I made the deadline for inclusion into 2.6 even if it 
> takes Linus a few months to reach my place in the queue of patches sent 
> to him on Halloween day?
> 
> I understand that earlier is better, and I will send it earlier if I 
> can, but even if we do get the reiser4 core (that which does all that V3 
> does but faster and on top of a plugin infrastructure) done before 
> Halloween, we will inevitably add a few features and tweaks after doing 
> the core, and we will want to send those in at the last minute.

Hans,
my understanding is that core changes that aren't in by Halloween are
not going to be accepted until 2.7.  By pre-announcing the deadline,
it is hoped that people will have lots of time to submit things that are
ready for inclusion, as opposed to rushing to submit when the "freeze"
is announced all of a sudden.

If (as we all hope) the important features are added incrementally to
the development kernel over the next few months, maybe all of the usage
and testing that is going into the development kernel will not be
totally lost when the entire kernel is morphed under a huge weight of
patches.

It may even mean that there will not be an extra year of features (and
bugs) being added to the "frozen" kernel, and we will be able to start
2.7 earlier.

As always, I imagine that as long as you have any core changes in 2.5
before the freeze, it will not be impossible to add self-contained
things like filesystems and drivers after the freeze also.

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

