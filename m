Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316774AbSFFDJY>; Wed, 5 Jun 2002 23:09:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316765AbSFFDJY>; Wed, 5 Jun 2002 23:09:24 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:37812 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S316763AbSFFDJW>; Wed, 5 Jun 2002 23:09:22 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Date: Thu, 6 Jun 2002 13:09:17 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15614.53853.52948.516366@notabene.cse.unsw.edu.au>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: /proc/scsi/aic7xxx/? considered harmful (2.4.19-pre9) 
In-Reply-To: message from Justin T. Gibbs on Wednesday June 5
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday June 5, gibbs@scsiguy.com wrote:
> >
> >Hi,
> > I have 3 NFS servers with ext3 on raid5 on scsi with assorted
> >aic7xxx scsi controllers, all running 2.4.19-pre9 (plus some ext3 and
> >raid and nfs patches) using the "new" aic7xxx drivers.
> 
> You need to use aic7xxx driver version 6.2.8 to avoid this problem.
> Its been in Marcelo's tree for a bit, but I guess it missed pre9.

Thanks..  Looks like I have 6.2.6..
Actually on looking more closely it was -pre8, not -pre9 :-(

Anyway, I'm glad will be fixed in -final.  Thanks again,
NeilBrown
