Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269499AbUICQpG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269499AbUICQpG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 12:45:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269517AbUICQov
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 12:44:51 -0400
Received: from [195.135.223.198] ([195.135.223.198]:12928 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S269499AbUICQnA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 12:43:00 -0400
Date: Fri, 3 Sep 2004 17:48:04 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Dave Kleikamp <shaggy@austin.ibm.com>
Cc: Jamie Lokier <jamie@shareable.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linus Torvalds <torvalds@osdl.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, Adrian Bunk <bunk@fs.tum.de>,
       Hans Reiser <reiser@namesys.com>,
       viro@parcelfarce.linux.theplanet.co.uk, Christoph Hellwig <hch@lst.de>,
       fsdevel <linux-fsdevel@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: The argument for fs assistance in handling archives (was: silent semantic changes with reiser4)
Message-ID: <20040903154804.GC1396@elf.ucw.cz>
References: <20040826150202.GE5733@mail.shareable.org> <200408282314.i7SNErYv003270@localhost.localdomain> <20040901200806.GC31934@mail.shareable.org> <Pine.LNX.4.58.0409011311150.2295@ppc970.osdl.org> <1094118362.4847.23.camel@localhost.localdomain> <20040902161130.GA24932@mail.shareable.org> <1094146912.31495.13.camel@shaggy.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1094146912.31495.13.camel@shaggy.austin.ibm.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Thirdly, you must be referring to the Gnome versions of Bash, Make,
> > GCC, coreutils and Perl which I haven't found.  Perhaps we have a
> > different idea of what "supports this" means :)
> 
> Please don't tell me that we have expectations to run make from within a
> tar file.  This is getting silly.  tar does a pretty good job of
> extracting files into real directories, and putting them back into an
> archive.  I don't see a need to teach the kernel how to deal with
> compound files when user space can do it very easily.

Actually its not easy. User has to manually extract it and manually
delete it when he's done. Not nice.
								Pavel
-- 
When do you have heart between your knees?
