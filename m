Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269207AbUIBVl7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269207AbUIBVl7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 17:41:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269201AbUIBVk0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 17:40:26 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:655 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S269184AbUIBVjR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 17:39:17 -0400
Subject: Re: The argument for fs assistance in handling archives (was:
	silent semantic changes with reiser4)
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: Frank van Maarseveen <frankvm@xs4all.nl>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Linus Torvalds <torvalds@osdl.org>,
       Jamie Lokier <jamie@shareable.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, Adrian Bunk <bunk@fs.tum.de>,
       Hans Reiser <reiser@namesys.com>,
       viro@parcelfarce.linux.theplanet.co.uk, Christoph Hellwig <hch@lst.de>,
       fsdevel <linux-fsdevel@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
In-Reply-To: <20040902203854.GA4801@janus>
References: <20040826150202.GE5733@mail.shareable.org>
	 <200408282314.i7SNErYv003270@localhost.localdomain>
	 <20040901200806.GC31934@mail.shareable.org>
	 <Pine.LNX.4.58.0409011311150.2295@ppc970.osdl.org>
	 <1094118362.4847.23.camel@localhost.localdomain>
	 <20040902203854.GA4801@janus>
Content-Type: text/plain
Message-Id: <1094160994.31499.19.camel@shaggy.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 02 Sep 2004 16:36:34 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-09-02 at 15:38, Frank van Maarseveen wrote:
> Can it do this:
> 
> 	cd FC2-i386-disc1.iso
> 	ls
> 
> or this:
> 
> 	cd /dev/sda1
> 	ls
> 	cd /dev/floppy
> 	ls
> 	cd /dev/cdrom
> 	ls
> 
> ?

We have the mount command for that.  :^)
-- 
David Kleikamp
IBM Linux Technology Center

