Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261818AbSJNEvq>; Mon, 14 Oct 2002 00:51:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261820AbSJNEvq>; Mon, 14 Oct 2002 00:51:46 -0400
Received: from h68-147-110-38.cg.shawcable.net ([68.147.110.38]:48115 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S261818AbSJNEvp>; Mon, 14 Oct 2002 00:51:45 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Sun, 13 Oct 2002 22:55:07 -0600
To: Mark Hahn <hahn@physics.mcmaster.ca>
Cc: Brian Jackson <brian-kernel-list@mdrx.com>, linux-kernel@vger.kernel.org,
       evms-devel@lists.sourceforge.net
Subject: Re: [Evms-devel] Re: Linux v2.5.42
Message-ID: <20021014045507.GR3045@clusterfs.com>
Mail-Followup-To: Mark Hahn <hahn@physics.mcmaster.ca>,
	Brian Jackson <brian-kernel-list@mdrx.com>,
	linux-kernel@vger.kernel.org, evms-devel@lists.sourceforge.net
References: <20021013170630.29597.qmail@escalade.vistahp.com> <Pine.LNX.4.33.0210131545510.17395-100000@coffee.psychology.mcmaster.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0210131545510.17395-100000@coffee.psychology.mcmaster.ca>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 13, 2002  15:58 -0400, Mark Hahn wrote:
> > Yes I do realize that, but I think EVMS offers more in the long run
> > than any of the others.
> 
> for instance, some part of EVMS design is motivated by IBM's political
> desire to permit its bank customers, who have horrible old OS/2 systems,
> to transparently use OS/2 volumes.  it's not as if IBM couldn't provide
> a simple, user-level migration tool.

Well, you try and convert a few TB of data in a few hour outage window
and pray everything goes well (and then have to convert _back_ to the
old format once you find a bug in the new environment).  You have just
never worked in an environment where the time constraints are tight,
and you CANNOT do the migration offline, or in advance, or whatever.

> it's not as if the Linux community is going to rush out and say
> "let's all start use OS/2 volumes everywhere!"

Well, it's not like most of the Linux community is rushing out and saying
"let's all start using Amiga AFFS filesystems" either, but that didn't
prevent it from being included in the kernel.

I actually DO prefer AIX LVM metadata over the Linux LVM metadata,
and it is NO CONTEST when you are comparing it to the "DOS partitions"
that you seem to prefer so much.

> the best part of Linux is its willingness to throw out old designs;

The best part of Linux is that it accepts a lot of people into the fold,
each of whom has their own special needs, and can change it to meet
those needs.

> a big system like EVMS has its own resistance to such redesign.

???  A big system like the VM/VFS/networking/etc has its own resistance to
such redesign too, but that doesn't mean that they haven't been hacked and
diced and re-assembled like Frankenstein several times.  Everything has
to start somewhere, and if you want until everyone reaches "consensus"
on what is the "best" way to implement it, we would all still be running
MS DOS or Minix.

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

