Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278634AbRJSTsT>; Fri, 19 Oct 2001 15:48:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278635AbRJSTsK>; Fri, 19 Oct 2001 15:48:10 -0400
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:51196 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S278634AbRJSTry>; Fri, 19 Oct 2001 15:47:54 -0400
From: Andreas Dilger <adilger@turbolabs.com>
Date: Fri, 19 Oct 2001 13:48:21 -0600
To: Mike Castle <dalgoda@ix.netcom.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: e2fsck, LVM and 4096-char block problems
Message-ID: <20011019134821.H402@turbolinux.com>
Mail-Followup-To: Mike Castle <dalgoda@ix.netcom.com>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <20011019132513.F402@turbolinux.com> <20011019123523.A10770@thune.mrc-home.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011019123523.A10770@thune.mrc-home.com>
User-Agent: Mutt/1.3.22i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 19, 2001  12:35 -0700, Mike Castle wrote:
> > On Oct 19, 2001  11:59 -0700, Mike Castle wrote:
> > > Using Linus' 2.4.10, unpatched.  (Perhaps I need to patch the LVM stuff ;-)
> > Very bad combination.  Don't use 2.4.10, don't use stock Linus LVM.
> 
> What needs to be done to get recent LVM into stock kernel?
> 
> I feel like it's the 2.2 RAID stuff all over again.

Well, it is mostly up-to-date in -ac, but I think the Sistina folks have
given up on submitting it to Linus.  I do a bit now and then, but haven't
made much of a real effort to get it fully up-to-date.  Maybe now that the
whole block-device changes have settled down again I will submit a few
patches.

Cheers, Andreas
--
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

