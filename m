Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269481AbUICBUN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269481AbUICBUN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 21:20:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269463AbUICBS1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 21:18:27 -0400
Received: from c002781a.fit.bostream.se ([217.215.235.8]:30363 "EHLO
	mail.tnonline.net") by vger.kernel.org with ESMTP id S269481AbUICAsG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 20:48:06 -0400
Date: Fri, 3 Sep 2004 02:47:49 +0200
From: Spam <spam@tnonline.net>
Reply-To: Spam <spam@tnonline.net>
X-Priority: 3 (Normal)
Message-ID: <617051682.20040903024749@tnonline.net>
To: David Masover <ninja@slaphack.com>
CC: Oliver Neukum <oliver@neukum.org>, Hans Reiser <reiser@namesys.com>,
       Linus Torvalds <torvalds@osdl.org>, Jamie Lokier <jamie@shareable.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, Adrian Bunk <bunk@fs.tum.de>,
       <viro@parcelfarce.linux.theplanet.co.uk>,
       Christoph Hellwig <hch@lst.de>, <linux-fsdevel@vger.kernel.org>,
       <linux-kernel@vger.kernel.org>,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: The argument for fs assistance in handling archives
In-Reply-To: <4137BE36.5020504@slaphack.com>
References: <20040826150202.GE5733@mail.shareable.org>
 <4136E0B6.4000705@namesys.com> <1117111836.20040902115249@tnonline.net>
 <200409021309.04780.oliver@neukum.org> <4137BE36.5020504@slaphack.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1

> Oliver Neukum wrote:
> | Am Donnerstag, 2. September 2004 11:52 schrieb Spam:
> |
|>>  Btw, version control for ordinary files would be a great feature. I
|>>  think something like it is available through Windows 2000/3 server.
|>>  Isn't it called "Shadow Copies". It works over network shares. :)
|>>
|>>  It allows you to restore previous versions of the file even if you
|>>  delete or overwrite it.
> |
> |
> | There's no need to do that in kernel, unless you want to be able
> | to force it unto users.

> And on apps.  Should I teach OpenOffice.org to do version control?
> Seems a lot easier to just do it in the kernel, and teach everything to
> do version control in one fell swoop.

  Do you mean in the kernel or as a filesystem/VFS plugin that would
  extend the functionality to include version control?

  ~S


