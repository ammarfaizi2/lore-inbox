Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269228AbUIBWD0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269228AbUIBWD0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 18:03:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269235AbUIBWDX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 18:03:23 -0400
Received: from frankvm.xs4all.nl ([80.126.170.174]:49119 "EHLO
	janus.localdomain") by vger.kernel.org with ESMTP id S269228AbUIBWCo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 18:02:44 -0400
Date: Fri, 3 Sep 2004 00:02:42 +0200
From: Frank van Maarseveen <frankvm@xs4all.nl>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Frank van Maarseveen <frankvm@xs4all.nl>,
       Dave Kleikamp <shaggy@austin.ibm.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Linus Torvalds <torvalds@osdl.org>,
       Jamie Lokier <jamie@shareable.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, Adrian Bunk <bunk@fs.tum.de>,
       Hans Reiser <reiser@namesys.com>, Christoph Hellwig <hch@lst.de>,
       fsdevel <linux-fsdevel@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: The argument for fs assistance in handling archives (was: silent semantic changes with reiser4)
Message-ID: <20040902220242.GA5414@janus>
References: <20040826150202.GE5733@mail.shareable.org> <200408282314.i7SNErYv003270@localhost.localdomain> <20040901200806.GC31934@mail.shareable.org> <Pine.LNX.4.58.0409011311150.2295@ppc970.osdl.org> <1094118362.4847.23.camel@localhost.localdomain> <20040902203854.GA4801@janus> <1094160994.31499.19.camel@shaggy.austin.ibm.com> <20040902214806.GA5272@janus> <20040902220027.GD23987@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040902220027.GD23987@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.1i
X-Subliminal-Message: Use Linux!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 02, 2004 at 11:00:27PM +0100, viro@parcelfarce.linux.theplanet.co.uk wrote:
> 
> The hell it is.
> 
> a) kernel has *NO* *FUCKING* *KNOWLEDGE* of fs type contained on a device.

excuse me, but how does the kernel mount the root fs?

-- 
Frank
