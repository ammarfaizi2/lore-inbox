Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268933AbUIBUD5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268933AbUIBUD5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 16:03:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268925AbUIBUA7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 16:00:59 -0400
Received: from the-village.bc.nu ([81.2.110.252]:12945 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268657AbUIBT7O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 15:59:14 -0400
Subject: Re: silent semantic changes with reiser4
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Spam <spam@tnonline.net>
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>, Lee Revell <rlrevell@joe-job.com>,
       Jamie Lokier <jamie@shareable.org>, Pavel Machek <pavel@suse.cz>,
       David Masover <ninja@slaphack.com>, Chris Wedgwood <cw@f00f.org>,
       viro@parcelfarce.linux.theplanet.co.uk,
       Linus Torvalds <torvalds@osdl.org>, Christoph Hellwig <hch@lst.de>,
       Hans Reiser <reiser@namesys.com>, linux-fsdevel@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
In-Reply-To: <1535878866.20040902214144@tnonline.net>
References: Message from Lee Revell <rlrevell@joe-job.com>
	 of "Wed, 01 Sep 2004 18:51:12 -0400." <1094079071.1343.25.camel@krustophenia.net>
	 <200409021425.i82EPn9i005192@laptop11.inf.utfsm.cl>
	 <1535878866.20040902214144@tnonline.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1094151338.5645.32.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 02 Sep 2004 19:55:43 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2004-09-02 at 20:41, Spam wrote:
> > It is trivial to implement this by looking inside the files. I.e., the way
> > mc has done this for ages.
> 
>   Difference is that you can't do "locate" or "find" or "Search".. You
>   would have to open the files in an archive-supporting application
>   such as mc.

And would you rather that logic was running swappable in shared library
space or privileged and unswappable in kernel ?

Alan

