Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132978AbRDKURB>; Wed, 11 Apr 2001 16:17:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132983AbRDKUQv>; Wed, 11 Apr 2001 16:16:51 -0400
Received: from ns.suse.de ([213.95.15.193]:65030 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S132978AbRDKUQi>;
	Wed, 11 Apr 2001 16:16:38 -0400
Date: Wed, 11 Apr 2001 22:16:36 +0200 (CEST)
From: Dave Jones <davej@suse.de>
To: Christoph Hellwig <hch@caldera.de>
Cc: <linux-kernel@vger.kernel.org>, <kbuild-devel@lists.sourceforge.net>,
        "Eric S. Raymond" <esr@snark.thyrsus.com>
Subject: Re: CML2 1.0.0 release announcement
In-Reply-To: <200104112004.WAA30164@ns.caldera.de>
Message-ID: <Pine.LNX.4.30.0104112212310.29627-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Apr 2001, Christoph Hellwig wrote:

> > CML2 takes around 15 seconds before I get that far.
> > This is on an Athlon 800 w/512MB. I dread to think how this
> > responds on a 486.
>
> If you look for something _even_ faster try mconfig.  For everyone who is
> interested, I've put my latests half-way stable version is on ftp.  It's at
>   ftp.openlinux.org:/pub/people/hch/mconfig/mconfig-0.19-pre1.tar.gz
> Props for all the hard work go to Michael Elizabeth Chastain!

This is the first I've heard of mconfig. (I don't track the kbuild list)
Does it solve all the problems that Eric's solution proposes?
It's certainly fast (CML1 menuconfig speed at least).

regards,

Dave.

