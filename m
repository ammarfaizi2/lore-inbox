Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269008AbUICDuK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269008AbUICDuK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 23:50:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268857AbUICDtE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 23:49:04 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:53409 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S268989AbUICDsq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 23:48:46 -0400
Date: Fri, 3 Sep 2004 04:44:48 +0100
From: Chris Dukes <pakrat@www.uk.linux.org>
To: David Masover <ninja@slaphack.com>
Cc: Spam <spam@tnonline.net>, viro@parcelfarce.linux.theplanet.co.uk,
       Frank van Maarseveen <frankvm@xs4all.nl>,
       Dave Kleikamp <shaggy@austin.ibm.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Linus Torvalds <torvalds@osdl.org>,
       Jamie Lokier <jamie@shareable.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, Adrian Bunk <bunk@fs.tum.de>,
       Hans Reiser <reiser@namesys.com>, Christoph Hellwig <hch@lst.de>,
       fsdevel <linux-fsdevel@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: The argument for fs assistance in handling archives
Message-ID: <20040903034448.GJ32697@ZenIV.linux.org.uk>
Mail-Followup-To: David Masover <ninja@slaphack.com>,
	Spam <spam@tnonline.net>, viro@parcelfarce.linux.theplanet.co.uk,
	Frank van Maarseveen <frankvm@xs4all.nl>,
	Dave Kleikamp <shaggy@austin.ibm.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linus Torvalds <torvalds@osdl.org>,
	Jamie Lokier <jamie@shareable.org>,
	Horst von Brand <vonbrand@inf.utfsm.cl>,
	Adrian Bunk <bunk@fs.tum.de>, Hans Reiser <reiser@namesys.com>,
	Christoph Hellwig <hch@lst.de>,
	fsdevel <linux-fsdevel@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Alexander Lyamin aka FLX <flx@namesys.com>,
	ReiserFS List <reiserfs-list@namesys.com>
References: <20040901200806.GC31934@mail.shareable.org> <Pine.LNX.4.58.0409011311150.2295@ppc970.osdl.org> <1094118362.4847.23.camel@localhost.localdomain> <20040902203854.GA4801@janus> <1094160994.31499.19.camel@shaggy.austin.ibm.com> <20040902214806.GA5272@janus> <20040902220027.GD23987@parcelfarce.linux.theplanet.co.uk> <4137B5F5.8000402@slaphack.com> <1862674154.20040903024407@tnonline.net> <4137C8B4.2030009@slaphack.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4137C8B4.2030009@slaphack.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 02, 2004 at 08:28:20PM -0500, David Masover wrote:
> 
> So implement a plugin which knows how to talk to a userland program
> which knows about metadata.  The plugin controls access to file-type.
> 
> Maybe there ought to be a general-purpose userland plugin interface?  So
> that the only things left in the kernel are things that have to be there
> for speed and/or sanity reasons?  (Things like cryptocompress and
> standard file/directory plugins.)

Ahem,
Wasn't this the goal of GNU HURD?

I really think you should ask them why they haven't delivered
something useful, then come back to this thread.

Thanks.
-- 
Chris Dukes
Warning: Do not use the reflow toaster oven to prepare foods after
it has been used for solder paste reflow. 
http://www.stencilsunlimited.com/stencil_article_page5.htm
