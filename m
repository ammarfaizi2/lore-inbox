Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268260AbUIBLOC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268260AbUIBLOC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 07:14:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268254AbUIBLOC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 07:14:02 -0400
Received: from c002781a.fit.bostream.se ([217.215.235.8]:19163 "EHLO
	mail.tnonline.net") by vger.kernel.org with ESMTP id S268191AbUIBLLo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 07:11:44 -0400
Date: Thu, 2 Sep 2004 13:11:22 +0200
From: Spam <spam@tnonline.net>
Reply-To: Spam <spam@tnonline.net>
X-Priority: 3 (Normal)
Message-ID: <123393726.20040902131122@tnonline.net>
To: Oliver Neukum <oliver@neukum.org>
CC: Hans Reiser <reiser@namesys.com>, Linus Torvalds <torvalds@osdl.org>,
       David Masover <ninja@slaphack.com>, Jamie Lokier <jamie@shareable.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, Adrian Bunk <bunk@fs.tum.de>,
       <viro@parcelfarce.linux.theplanet.co.uk>,
       Christoph Hellwig <hch@lst.de>, <linux-fsdevel@vger.kernel.org>,
       <linux-kernel@vger.kernel.org>,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: The argument for fs assistance in handling archives
In-Reply-To: <200409021309.04780.oliver@neukum.org>
References: <20040826150202.GE5733@mail.shareable.org>
 <4136E0B6.4000705@namesys.com> <1117111836.20040902115249@tnonline.net>
 <200409021309.04780.oliver@neukum.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  

> Am Donnerstag, 2. September 2004 11:52 schrieb Spam:
>>   Btw, version control for ordinary files would be a great feature. I
>>   think something like it is available through Windows 2000/3 server.
>>   Isn't it called "Shadow Copies". It works over network shares. :)
>> 
>>   It allows you to restore previous versions of the file even if you
>>   delete or overwrite it.

> There's no need to do that in kernel, unless you want to be able
> to force it unto users.

  Exactly ;)

  Difference with having it in just certain applications like Gnome-VFS
  etc is that it would work with all applications, over SMB shares
  etc. This is a great advantage and benefit for many desktop users
  but also in a corporate environment. Even though there are backups
  of users documents it is a pain to restore them every time they
  loose the original file. Besides, the backup is never as fresh
  either.
  

> 	Regards
> 		Oliver

