Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129214AbRBHBXJ>; Wed, 7 Feb 2001 20:23:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130021AbRBHBXA>; Wed, 7 Feb 2001 20:23:00 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.29]:9740 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S129214AbRBHBWp>; Wed, 7 Feb 2001 20:22:45 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Jun Sun <jsun@mvista.com>
Date: Thu, 8 Feb 2001 12:22:26 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14977.62674.189100.548731@notabene.cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: nfs_refresh_inode: inode number mismatch
In-Reply-To: message from Jun Sun on Wednesday February 7
In-Reply-To: <3A81F2A6.DC5AB40B@mvista.com>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday February 7, jsun@mvista.com wrote:
> 
> This is a weird problem that I am looking at right.  It seems to indicate a
> bug in the nfs server.
> 
> I have a MIPS machine that boots from a NFS root fs hosted on a redhat 6.2
> workstation.  Everything works fine except that after a few reboots I start to
> see the error messages like the following:

What verison of Linux?  If it is less than 2.2.18, then an upgrade 
will help you a lot.

If it is >= 2.2.18, I will look some more.

NeilBrown
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
