Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276424AbSBJVuL>; Sun, 10 Feb 2002 16:50:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279798AbSBJVuB>; Sun, 10 Feb 2002 16:50:01 -0500
Received: from mallaury.noc.nerim.net ([62.4.17.82]:42252 "HELO
	mallaury.noc.nerim.net") by vger.kernel.org with SMTP
	id <S276424AbSBJVtl>; Sun, 10 Feb 2002 16:49:41 -0500
Date: Sun, 10 Feb 2002 22:49:32 +0100
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com, andre@linux-ide.org,
        jmontpezat@nerim.net
Subject: Re: [RAID-soft,ATA,WD] problems with a RAID5 disc not detected
Message-ID: <20020210214932.GA20694@calixo.net>
In-Reply-To: <20020210205653.GA20212@calixo.net> <15462.59714.671946.156442@notabene.cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <15462.59714.671946.156442@notabene.cse.unsw.edu.au>
User-Agent: Mutt/1.3.27i
X-Face: "99`N"mZV/:<T->OLp[>#d3R;u.!ivtwAEpIQDL8rD#;L3Wm)~^)Uv=#;S!LZf1y8oRY7J#JR\Lr{*4Cn*32C89ln>0~5~tm--}j%hvhj+vtW><xbwA=@G8M||zPV0-r`:6zhMqq+_OC_0W*-:Wxzm3%|A5EE}VFnIgRU=+,L-hGdM"j&l'_^zK+%MBOsdmi#e3(3fGg^SGM
From: Cyrille Chepelov <cyrille@chepelov.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le Mon, Feb 11, 2002, à 08:42:26AM +1100, Neil Brown a écrit:

> Are you sure that you set the partition type properly for the
> partitions in the new drive. i.e. set it to FD ??

I'm stupid.

Thanks a *lot* for pointing that out to me (I was sure I had done it, but 
in fact I've done it on the other disc bought that day -- which sits in a 
closet as a spare drive).

(I'm not going to retract my comments on Western Digital -- but at least
that thing works now)

	-- Cyrille (going to run and hide in my bed, after cfdisk'ing that
		    partition table)

-- 
Grumpf.

