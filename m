Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263333AbTAaXnF>; Fri, 31 Jan 2003 18:43:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263342AbTAaXnF>; Fri, 31 Jan 2003 18:43:05 -0500
Received: from h68-147-110-38.cg.shawcable.net ([68.147.110.38]:15357 "EHLO
	schatzie.adilger.int") by vger.kernel.org with ESMTP
	id <S263333AbTAaXnE>; Fri, 31 Jan 2003 18:43:04 -0500
Date: Fri, 31 Jan 2003 16:52:21 -0700
From: Andreas Dilger <adilger@clusterfs.com>
To: Chris Wedgwood <cw@f00f.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Bitkeeper-announce] Re: bkbits.net downtime
Message-ID: <20030131165221.O3904@schatzie.adilger.int>
Mail-Followup-To: Chris Wedgwood <cw@f00f.org>,
	linux-kernel@vger.kernel.org
References: <200301312114.h0VLEmC11997@work.bitmover.com> <20030131145018.N3904@schatzie.adilger.int> <20030131224627.GA1686@f00f.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030131224627.GA1686@f00f.org>; from cw@f00f.org on Fri, Jan 31, 2003 at 02:46:27PM -0800
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 31, 2003  14:46 -0800, Chris Wedgwood wrote:
> On Fri, Jan 31, 2003 at 02:50:18PM -0700, Andreas Dilger wrote:
> > Actually, with BK it should be possible to have read only clones on
> > multiple servers, should it not?  Not that I'm saying BK should foot
> > the bill to do that, but having read-only clones of the primary
> > kernel trees would avoid most downtime.
> 
> At the risk of suggesting something insanely complex...
> 
> ... assuming BK read-only copies do work, why not actually have 'bk
> pull' for hosts which can serve RO copies of the trees?  You
> could use SRV records to locate these transparently to what has been
> deployed now (I'm not really a fan of rfc2782.txt but nonetheless it
> exists and others are using it, so it's a 'standard' of sorts).
> 
> Presumably doing something like this means you could have many people
> voluntarily providing RO trees for different projects and lessen the
> load on the bitmover infrastructure...

That's exactly what I was suggesting, but not very clearly it seems.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

