Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268281AbUIBLJK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268281AbUIBLJK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 07:09:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268269AbUIBLJI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 07:09:08 -0400
Received: from mail1.kontent.de ([81.88.34.36]:32920 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S268213AbUIBLHa convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 07:07:30 -0400
From: Oliver Neukum <oliver@neukum.org>
To: Spam <spam@tnonline.net>
Subject: Re: The argument for fs assistance in handling archives
Date: Thu, 2 Sep 2004 13:09:04 +0200
User-Agent: KMail/1.6.2
Cc: Hans Reiser <reiser@namesys.com>, Linus Torvalds <torvalds@osdl.org>,
       David Masover <ninja@slaphack.com>, Jamie Lokier <jamie@shareable.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, Adrian Bunk <bunk@fs.tum.de>,
       <viro@parcelfarce.linux.theplanet.co.uk>,
       Christoph Hellwig <hch@lst.de>, <linux-fsdevel@vger.kernel.org>,
       <linux-kernel@vger.kernel.org>,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
References: <20040826150202.GE5733@mail.shareable.org> <4136E0B6.4000705@namesys.com> <1117111836.20040902115249@tnonline.net>
In-Reply-To: <1117111836.20040902115249@tnonline.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Message-Id: <200409021309.04780.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 2. September 2004 11:52 schrieb Spam:
>   Btw, version control for ordinary files would be a great feature. I
>   think something like it is available through Windows 2000/3 server.
>   Isn't it called "Shadow Copies". It works over network shares. :)
> 
>   It allows you to restore previous versions of the file even if you
>   delete or overwrite it.

There's no need to do that in kernel, unless you want to be able
to force it unto users.

	Regards
		Oliver
