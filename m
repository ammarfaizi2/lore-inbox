Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261276AbSJUICh>; Mon, 21 Oct 2002 04:02:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261277AbSJUICh>; Mon, 21 Oct 2002 04:02:37 -0400
Received: from h68-147-110-38.cg.shawcable.net ([68.147.110.38]:56562 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S261276AbSJUICf>; Mon, 21 Oct 2002 04:02:35 -0400
Date: Mon, 21 Oct 2002 02:05:17 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Rob Landley <landley@trommello.org>
Cc: karim@opersys.com, linux-kernel@vger.kernel.org, boissiere@nl.linux.org
Subject: Re: Crunch time -- Final merge candidates for 3.0 (the list).
Message-ID: <20021021080517.GB17430@clusterfs.com>
Mail-Followup-To: Rob Landley <landley@trommello.org>, karim@opersys.com,
	linux-kernel@vger.kernel.org, boissiere@nl.linux.org
References: <200210201849.23667.landley@trommello.org> <200210202037.54370.landley@trommello.org> <20021021064308.GA17430@clusterfs.com> <200210202147.23712.landley@trommello.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200210202147.23712.landley@trommello.org>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 20, 2002  21:47 -0500, Rob Landley wrote:
> On Monday 21 October 2002 01:43, Andreas Dilger wrote:
> > On Oct 20, 2002  20:37 -0500, Rob Landley wrote:
> > > Ted Tso has also been posting new ext2/ext3 code with extended attributes
> > > and access control lists.
> > >
> > > So, 11 items from the 2.5 status list (in -aa, in -mm, and "ready"), plus
> > > kexec, kernelconfig, and ACL for EXT3.  I believe this brings the total
> > > number of pending patchsets still hoping for 2.5 inclusion to 14.
> >
> > I belive that the ext3 EA+ACL stuff is now in -mm.
> 
> Query: is the stuff in -mm guaranteed to make it into Linus's tree?  Or is it 
> another variant of -ac and -dj, from which Linus pulls what he wants?

I doubt it.  However, being included in "-mm" or "-ac" is one step closer to
being included in "" than just being a random patch/cset on the internet...

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

