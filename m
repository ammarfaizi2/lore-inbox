Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132980AbRDKUIE>; Wed, 11 Apr 2001 16:08:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132973AbRDKUHw>; Wed, 11 Apr 2001 16:07:52 -0400
Received: from ns.caldera.de ([212.34.180.1]:4873 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S132697AbRDKUHj>;
	Wed, 11 Apr 2001 16:07:39 -0400
Date: Wed, 11 Apr 2001 22:04:48 +0200
Message-Id: <200104112004.WAA30164@ns.caldera.de>
From: Christoph Hellwig <hch@caldera.de>
To: <davej@suse.de>
Cc: <linux-kernel@vger.kernel.org>, <kbuild-devel@lists.sourceforge.net>,
        "Eric S. Raymond" <esr@snark.thyrsus.com>
Subject: Re: CML2 1.0.0 release announcement
X-Newsgroups: caldera.lists.linux.kernel
In-Reply-To: <Pine.LNX.4.31.0104112013010.25121-100000@athlon>
User-Agent: tin/1.4.1-19991201 ("Polish") (UNIX) (Linux/2.2.14 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.31.0104112013010.25121-100000@athlon> you wrote:
> One of the first things I noticed was it seems noticably slower
> than CML1. A make menuconfig in CML1 takes me into the menu
> in under a second. (On an already compiled tree).
> CML2 takes around 15 seconds before I get that far.
> This is on an Athlon 800 w/512MB. I dread to think how this
> responds on a 486.

If you look for something _even_ faster try mconfig.  For everyone who is
interested, I've put my latests half-way stable version is on ftp.  It's at

  ftp.openlinux.org:/pub/people/hch/mconfig/mconfig-0.19-pre1.tar.gz

Props for all the hard work go to Michael Elizabeth Chastain!

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.
