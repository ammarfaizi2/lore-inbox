Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280762AbRKKA6S>; Sat, 10 Nov 2001 19:58:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280765AbRKKA6I>; Sat, 10 Nov 2001 19:58:08 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:52977 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S280762AbRKKA5w>;
	Sat, 10 Nov 2001 19:57:52 -0500
Date: Sat, 10 Nov 2001 17:57:25 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Terje Eggestad <terje.eggestad@scali.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: confused about raw-io blocksizes
Message-ID: <20011110175725.M1778@lynx.no>
Mail-Followup-To: Terje Eggestad <terje.eggestad@scali.no>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20011109171311.J1778@lynx.no> <Pine.LNX.4.30.0111101231350.24890-100000@elin.scali.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <Pine.LNX.4.30.0111101231350.24890-100000@elin.scali.no>; from terje.eggestad@scali.no on Sat, Nov 10, 2001 at 12:55:36PM +0100
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 10, 2001  12:55 +0100, Terje Eggestad wrote:
> > LVM is broken in this regard, unless you have a recent patch (Linus'
> > kernel does not).  I sent him a patch to fix that, but it did not get in.
> 
> I'm been trying with RH 2.4.2-2, stock 2.4.10, stock 2.4.13, and a RH
> 2.4.3 with some additional patches. All of them  has lvm 0.9.1_beta2
> (isn't that getting old??)

Yes it is.  You need a patch for LVM from the Sistina site, or -ac kernel.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

