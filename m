Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314220AbSDRCUQ>; Wed, 17 Apr 2002 22:20:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314221AbSDRCUP>; Wed, 17 Apr 2002 22:20:15 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:44206 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S314220AbSDRCUO>; Wed, 17 Apr 2002 22:20:14 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Mike Fedyk <mfedyk@matchmail.com>
Date: Thu, 18 Apr 2002 12:23:38 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15550.11818.429509.22486@notabene.cse.unsw.edu.au>
Cc: Richard Gooch <rgooch@ras.ucalgary.ca>,
        Andreas Dilger <adilger@clusterfs.com>, linux-kernel@vger.kernel.org
Subject: Re: RAID superblock confusion
In-Reply-To: message from Mike Fedyk on Wednesday April 17
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday April 17, mfedyk@matchmail.com wrote:
> On Thu, Apr 18, 2002 at 11:54:13AM +1000, Neil Brown wrote:
> > On Saturday April 13, rgooch@ras.ucalgary.ca wrote:
> > > If there was only a "do as I say, regardless" mode, I would be happy.
> > > This programmer-knows-best attitude smacks of M$.
> > 
> > mdadm will do as you say, reguardless - if you ask it to.  Have you
> > tried mdadm?
> >    http://www.cse.unsw.edu.au/~neilb/source/mdadm/
> 
> Niel, do you plan to merge mdadm into the raidtools package?  It sounds like
> it belongs there.

No.
If distributions want to distribute mdadm together with the stuff from
raidtools, then that is up to them.
But from a development perspective, I don't see any value in making a
single source distribution.

NeilBrown
