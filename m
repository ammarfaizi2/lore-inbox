Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268206AbUIBK4t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268206AbUIBK4t (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 06:56:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268212AbUIBKy0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 06:54:26 -0400
Received: from the-village.bc.nu ([81.2.110.252]:52109 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S264648AbUIBKuf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 06:50:35 -0400
Subject: Re: The argument for fs assistance in handling archives (was:
	silent semantic changes with reiser4)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jamie Lokier <jamie@shareable.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, Adrian Bunk <bunk@fs.tum.de>,
       Hans Reiser <reiser@namesys.com>,
       viro@parcelfarce.linux.theplanet.co.uk, Christoph Hellwig <hch@lst.de>,
       linux-fsdevel@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
In-Reply-To: <Pine.LNX.4.58.0409011311150.2295@ppc970.osdl.org>
References: <20040826150202.GE5733@mail.shareable.org>
	 <200408282314.i7SNErYv003270@localhost.localdomain>
	 <20040901200806.GC31934@mail.shareable.org>
	 <Pine.LNX.4.58.0409011311150.2295@ppc970.osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1094118362.4847.23.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 02 Sep 2004 10:46:05 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2004-09-01 at 21:50, Linus Torvalds wrote:
> and quite frankly, I think you can do the above pretty much totally in
> user space with a small library and a daemon (in fact, ignoring security
> issues you probably don't even need the daemon). And if you can prototype
> it like that, and people actually find it useful, I suspect kernel support
> for better performance might be possible.

Gnome already supports this in the gnome-vfs2 layer. "MC" has supported
it since the late 1990's.


