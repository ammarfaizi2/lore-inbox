Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268165AbUIBKhx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268165AbUIBKhx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 06:37:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268134AbUIBKhw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 06:37:52 -0400
Received: from the-village.bc.nu ([81.2.110.252]:47501 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268132AbUIBKhh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 06:37:37 -0400
Subject: Re: The argument for fs assistance in handling archives
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Spam <spam@tnonline.net>
Cc: Hans Reiser <reiser@namesys.com>, Linus Torvalds <torvalds@osdl.org>,
       David Masover <ninja@slaphack.com>, Jamie Lokier <jamie@shareable.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, Adrian Bunk <bunk@fs.tum.de>,
       viro@parcelfarce.linux.theplanet.co.uk, Christoph Hellwig <hch@lst.de>,
       linux-fsdevel@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
In-Reply-To: <1117111836.20040902115249@tnonline.net>
References: <20040826150202.GE5733@mail.shareable.org>
	 <200408282314.i7SNErYv003270@localhost.localdomain>
	 <20040901200806.GC31934@mail.shareable.org>
	 <Pine.LNX.4.58.0409011311150.2295@ppc970.osdl.org>
	 <20040902002431.GN31934@mail.shareable.org> <413694E6.7010606@slaphack.com>
	 <Pine.LNX.4.58.0409012037300.2295@ppc970.osdl.org>
	 <4136A14E.9010303@slaphack.com>
	 <Pine.LNX.4.58.0409012259340.2295@ppc970.osdl.org>
	 <4136C876.5010806@namesys.com>
	 <Pine.LNX.4.58.0409020030220.2295@ppc970.osdl.org>
	 <4136E0B6.4000705@namesys.com>  <1117111836.20040902115249@tnonline.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1094117527.4842.18.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 02 Sep 2004 10:32:10 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2004-09-02 at 10:52, Spam wrote:
>   Btw, version control for ordinary files would be a great feature. I
>   think something like it is available through Windows 2000/3 server.
>   Isn't it called "Shadow Copies". It works over network shares. :)

Netapps have done this for years with NFS, Subversion does it with DAV,
clearcase does it with NFS.


