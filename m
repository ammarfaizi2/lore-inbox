Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268343AbUIBTwl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268343AbUIBTwl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 15:52:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268816AbUIBTwg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 15:52:36 -0400
Received: from the-village.bc.nu ([81.2.110.252]:8081 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268657AbUIBTu3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 15:50:29 -0400
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
In-Reply-To: <Pine.LNX.4.58.0409021045210.2295@ppc970.osdl.org>
References: <20040826150202.GE5733@mail.shareable.org>
	 <200408282314.i7SNErYv003270@localhost.localdomain>
	 <20040901200806.GC31934@mail.shareable.org>
	 <Pine.LNX.4.58.0409011311150.2295@ppc970.osdl.org>
	 <1094118362.4847.23.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0409021045210.2295@ppc970.osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1094150760.5809.30.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 02 Sep 2004 19:46:05 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2004-09-02 at 18:46, Linus Torvalds wrote:
> > Gnome already supports this in the gnome-vfs2 layer. "MC" has supported
> > it since the late 1990's.
> 
> And nobody has asked for kernel support that I know of.

I asked our desktop people. They want something like inotify because
dontify doesn't cut it. They have zero interest in the multiple streams
and hiding icons in streams type stuff.

Alan

