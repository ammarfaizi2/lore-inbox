Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268343AbTBSKlR>; Wed, 19 Feb 2003 05:41:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268345AbTBSKlR>; Wed, 19 Feb 2003 05:41:17 -0500
Received: from cda1.e-mind.com ([195.223.140.107]:26497 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S268343AbTBSKlN>;
	Wed, 19 Feb 2003 05:41:13 -0500
Date: Wed, 19 Feb 2003 11:51:01 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: David Lang <david.lang@digitalinsight.com>
Cc: Jamie Lokier <jamie@shareable.org>, Thomas Molina <tmolina@cox.net>,
       linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: openbkweb-0.0
Message-ID: <20030219105101.GJ14633@x30.suse.de>
References: <20030219095701.GB14633@x30.suse.de> <Pine.LNX.4.44.0302190240120.8609-100000@dlang.diginsite.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0302190240120.8609-100000@dlang.diginsite.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 19, 2003 at 02:43:48AM -0800, David Lang wrote:
> On Wed, 19 Feb 2003, Andrea Arcangeli wrote:
> 
> > On Sat, Feb 15, 2003 at 01:31:16PM -0800, David Lang wrote:
> > > Andrea, since the on-disk format for bitkeeper is supposed to be SCCS
> > > would it be good enough for you to be able to get a copy of this? what
> > > mechanism would you prefer to use to get updates (rsync, FTP, HTTP, etc)
> >
> > how do you avoid races with rsync/ftp/http? How do you fetch the SCCS
> > format out of bkbits.net w/o using bitkeeper?
> >
> > Andrea
> 
> I don't know the RIGHT answer about the races (quick and dirty answer,
> deep doing a rsync until there is nothing to get???)

no it won't fix it (theoretically), I know in practice it would work
most of the time though :)

Andrea
