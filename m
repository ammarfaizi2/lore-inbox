Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268212AbUIGPrM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268212AbUIGPrM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 11:47:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268315AbUIGPmx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 11:42:53 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:16785 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S268212AbUIGPjX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 11:39:23 -0400
Message-Id: <200409071537.i87FbNOV004040@laptop11.inf.utfsm.cl>
To: Spam <spam@tnonline.net>
cc: Christer Weinigel <christer@weinigel.se>,
       David Masover <ninja@slaphack.com>, Tonnerre <tonnerre@thundrix.ch>,
       Linus Torvalds <torvalds@osdl.org>, Pavel Machek <pavel@ucw.cz>,
       Jamie Lokier <jamie@shareable.org>, Chris Wedgwood <cw@f00f.org>,
       viro@parcelfarce.linux.theplanet.co.uk, Christoph Hellwig <hch@lst.de>,
       Hans Reiser <reiser@namesys.com>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4 
In-Reply-To: Message from Spam <spam@tnonline.net> 
   of "Tue, 07 Sep 2004 15:52:25 +0200." <16310505631.20040907155225@tnonline.net> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 15)
Date: Tue, 07 Sep 2004 11:37:23 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Spam <spam@tnonline.net> said:
> Christer Weinigel <christer@weinigel.se> said:

[...]

> > But this still solves only part of the problem.  A backup application
> > won't have any use for a copyfile syscall, it will need to be taught
> > about streams.

>   Yes, but backup programs always needed to be taught about new
>   features. Be it new type of files, attributes or meta-data. I think
>   that teaching backup applications is far better than teaching every
>   application.

Strange... tar(1) is quite capable of backing up .mp3 files, which weren't
around when tar was born...
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
