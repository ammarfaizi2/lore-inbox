Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261242AbSJUHmE>; Mon, 21 Oct 2002 03:42:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261246AbSJUHmE>; Mon, 21 Oct 2002 03:42:04 -0400
Received: from pimout1-ext.prodigy.net ([207.115.63.77]:18920 "EHLO
	pimout1-ext.prodigy.net") by vger.kernel.org with ESMTP
	id <S261242AbSJUHmC> convert rfc822-to-8bit; Mon, 21 Oct 2002 03:42:02 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
Reply-To: landley@trommello.org
To: Andreas Dilger <adilger@clusterfs.com>
Subject: Re: Crunch time -- Final merge candidates for 3.0 (the list).
Date: Sun, 20 Oct 2002 21:47:23 -0500
User-Agent: KMail/1.4.3
Cc: karim@opersys.com, linux-kernel@vger.kernel.org, boissiere@nl.linux.org
References: <200210201849.23667.landley@trommello.org> <200210202037.54370.landley@trommello.org> <20021021064308.GA17430@clusterfs.com>
In-Reply-To: <20021021064308.GA17430@clusterfs.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210202147.23712.landley@trommello.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 21 October 2002 01:43, Andreas Dilger wrote:
> On Oct 20, 2002  20:37 -0500, Rob Landley wrote:
> > Ted Tso has also been posting new ext2/ext3 code with extended attributes
> > and access control lists.
> >
> > Announcement:
> > http://lists.insecure.org/lists/linux-kernel/2002/Oct/6787.html
> > Code (chooe your poison):
> > bk://extfs.bkbits.net/extfs-2.5-update
> > http://thunk.org/tytso/linux/extfs-2.5
> >
> > Apparently generic ACL support went into 2.5.3 (the status list again),
> > but I guess it wasn't added to EXT2.  I suppose this makes this a good
> > candidate for inclusion then. :)
> >
> > So, 11 items from the 2.5 status list (in -aa, in -mm, and "ready"), plus
> > kexec, kernelconfig, and ACL for EXT3.  I believe this brings the total
> > number of pending patchsets still hoping for 2.5 inclusion to 14.
>
> I belive that the ext3 EA+ACL stuff is now in -mm.
>
> Cheers, Andreas

Query: is the stuff in -mm guaranteed to make it into Linus's tree?  Or is it 
another variant of -ac and -dj, from which Linus pulls what he wants?

The first seems HIGHLY unlikely.  But is nice to know anyway... :)

Rob
