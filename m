Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313157AbSDUGAn>; Sun, 21 Apr 2002 02:00:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313138AbSDUGAm>; Sun, 21 Apr 2002 02:00:42 -0400
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:1533 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S313093AbSDUGAl>; Sun, 21 Apr 2002 02:00:41 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Sat, 20 Apr 2002 23:59:06 -0600
To: Andrew Morton <akpm@zip.com.au>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: BK, deltas, snapshots and fate of -pre...
Message-ID: <20020421055906.GA3017@turbolinux.com>
Mail-Followup-To: Andrew Morton <akpm@zip.com.au>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.21.0204202347010.27210-100000@weyl.math.psu.edu> <20020420.205958.123241031.davem@redhat.com> <3CC240EB.AAD35A09@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 20, 2002  21:32 -0700, Andrew Morton wrote:
> Dailies (nice) would need some distinguishing feature in EXTRAVERSION,
> please.  "-20Apr02" would suit.  (I suspect if that started happening,
> the -pre's would become redundant.  But that can be decided at a later
> stage)

Well, hopefully it will be "-pre020420" so that increasing kernel
versions can be sorted...  Also, skip releasing snapshots on days
when no new deltas have been applied...

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

