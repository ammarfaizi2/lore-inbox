Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317331AbSGUBr0>; Sat, 20 Jul 2002 21:47:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317400AbSGUBr0>; Sat, 20 Jul 2002 21:47:26 -0400
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:39408 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S317331AbSGUBrZ>; Sat, 20 Jul 2002 21:47:25 -0400
Date: Sat, 20 Jul 2002 19:47:14 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: David Weinehall <tao@acc.umu.se>,
       Austin Gonyou <austin@digitalroadkill.net>,
       Mark Peloquin <peloquin@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [2.6] Most likely to be merged by Halloween... THE LIST
Message-ID: <20020721014714.GM10315@clusterfs.com>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	David Weinehall <tao@acc.umu.se>,
	Austin Gonyou <austin@digitalroadkill.net>,
	Mark Peloquin <peloquin@us.ibm.com>, linux-kernel@vger.kernel.org
References: <OF918E6F71.637B1CBC-ON85256BFB.004CDDD0@pok.ibm.com> <1027199147.16819.39.camel@irongate.swansea.linux.org.uk> <1027197028.26159.2.camel@UberGeek.digitalroadkill.net> <20020720205520.GX29001@khan.acc.umu.se> <20020720212414.GL10315@clusterfs.com> <1027211042.16819.45.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1027211042.16819.45.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.3.28i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 21, 2002  01:24 +0100, Alan Cox wrote:
> On Sat, 2002-07-20 at 22:24, Andreas Dilger wrote:
> > I, for one, would like to have the choice to use the AIX LVM format, and
> > I'm sure that people thinking of migrating from HP/UX or whatever would
> > want to be able to add support for their on-disk LVM format.  It really
> > provides a framework to consolidate all of the partition/MD code into
> > a single place (e.g. RAID, LVM, LDM (windows NT), DOS, BSD, Sun, etc).
> 
> The LVM format for AIX and so on call all be handled by LVM2

Can it also do mirroring and RAID?  One of the features of AIX LVM is
mirroring on a per-PE basis.  If LVM2 can do this, then great.

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

