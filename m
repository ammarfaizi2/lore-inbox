Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287493AbSBLHep>; Tue, 12 Feb 2002 02:34:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290811AbSBLHef>; Tue, 12 Feb 2002 02:34:35 -0500
Received: from CPEdeadbeef0000.cpe.net.cable.rogers.com ([24.100.234.67]:45575
	"HELO coredump.sh0n.net") by vger.kernel.org with SMTP
	id <S287493AbSBLHeW>; Tue, 12 Feb 2002 02:34:22 -0500
Subject: Re: ANNOUNCEMENT: XFS patches with rmap12e + 2.4.18-pre9
From: Shawn Starr <spstarr@sh0n.net>
To: Linux <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.40.0202110133010.5068-100000@coredump.sh0n.net>
In-Reply-To: <Pine.LNX.4.40.0202110133010.5068-100000@coredump.sh0n.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1.99 (Preview Release)
Date: 12 Feb 2002 02:35:33 -0500
Message-Id: <1013499333.3572.8.camel@coredump>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some of you may experience compile problems with quota with XFS. I'm
working on a patch to be ready for today.

NOTE: Two people have reported problems with XFS + EXT3/EXT2. People
report the kernel unable to locate superblocks of EXT2/EXT3 filesystems
with XFS compiled in. Looking for help on this issue and researching. 

I'll be also intregrating 2.4.18-pre9-ac1 as well today.

Shawn.

On Mon, 2002-02-11 at 01:34, Shawn Starr wrote:
> 
> I'm fixing some of those as we speak, rmap12e going in and some fixes
> being made to some buffer code.
> 
> 2.4.18-pre9-xfs-shawn4 will be the next diff coming. There is also one
> change from XFS CVS as of tonight so that will be merged in as well.
> 
> On Mon, 11 Feb 2002, Roberto Rivera wrote:
> 
> > Hi Shawn,
> > I downloaded your patches:
> > _  xfs-20020205-20020206.inc
> > <http://xfs.sh0n.net/2.4/xfs-20020205-20020206-inc.diff.patch>
> >   xfs-20020205.diff.patch
> > <http://xfs.sh0n.net/2.4/xfs-20020205.diff.patch.bz2>
> > xfs-20020206-20020209.inc
> > <http://xfs.sh0n.net/2.4/xfs-20020206-20020209-inc.diff.patch>_
> >
> > Didn't find:
> >   xfs-2.4.18-pre9-shawn1
> >   containing: ac3 rmap12d and xfs
> >
> > Seemed to only have the xfs changes.
> > Did I miss something?
> >
> > Rob
> >
> >
> > <http://xfs.sh0n.net/2.4/xfs-20020205.diff.patch.bz2>
> >
> >
> >
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


