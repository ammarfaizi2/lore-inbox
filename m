Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130105AbQLGC1m>; Wed, 6 Dec 2000 21:27:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130218AbQLGC1W>; Wed, 6 Dec 2000 21:27:22 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.29]:38411 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S130105AbQLGC1N>; Wed, 6 Dec 2000 21:27:13 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Brian Kress <kressb@fsc-usa.com>
Date: Thu, 7 Dec 2000 12:55:49 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14894.60965.866703.618540@notabene.cse.unsw.edu.au>
Cc: Peter Samuelson <peter@cadcamlab.org>,
        Roberto Ragusa <robertoragusa@technologist.com>,
        linux-kernel@vger.kernel.org
Subject: Re: kernel panic in SoftwareRAID autodetection
In-Reply-To: message from Brian Kress on Wednesday December 6
In-Reply-To: <14893.25967.936504.881427@notabene.cse.unsw.edu.au>
	<yam8375.1358.149393648@a4000>
	<20001205183657.J6567@cadcamlab.org>
	<3A2E3C39.B96B9516@fsc-usa.com>
	<14894.42901.943835.494412@notabene.cse.unsw.edu.au>
	<3A2EB071.2CD7D01D@fsc-usa.com>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday December 6, kressb@fsc-usa.com wrote:
> Neil Brown wrote:
> > 
> > here we have lost the "part" automatic variable in disk_name but ....
> > 
> 
> 	I don't think so.  Look again.  

Gulp... :-(

Yes, your patch is indeed fine.  I heartily recommend it (for whatever
that is worth).

Your mailer on the other hand....  could use some work.
The latest patch that you mailed out still had only spaces, no tabs.
Nevertheless, I managed to apply it and it seems to work fine, as well
as looking all right.

NeilBrown
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
