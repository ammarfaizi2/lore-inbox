Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267951AbUH2Oca@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267951AbUH2Oca (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 10:32:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267946AbUH2O2q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 10:28:46 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:39851 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S267928AbUH2O2T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 10:28:19 -0400
Message-Id: <200408280028.i7S0STl1024054@localhost.localdomain>
To: Spam <spam@tnonline.net>
cc: Jamie Lokier <jamie@shareable.org>, Chris Wedgwood <cw@f00f.org>,
       viro@parcelfarce.linux.theplanet.co.uk,
       Linus Torvalds <torvalds@osdl.org>, Christoph Hellwig <hch@lst.de>,
       Hans Reiser <reiser@namesys.com>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4 
In-Reply-To: Message from Spam <spam@tnonline.net> 
   of "Thu, 26 Aug 2004 13:19:43 +0200." <14210549944.20040826131943@tnonline.net> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 15)
Date: Fri, 27 Aug 2004 20:28:29 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Spam <spam@tnonline.net> said:
> > Chris Wedgwood wrote:

[...]

> >   Gnome, KDE, Emacs and Bash all see different virtual filesystems.
> >   (All but Bash implement their own virtual filesystem extensions).
> >   That makes them much less useful than they could be.

>   Exactly,  and  I  doubt  they  have the ability to join together and
>   create  a  common  uniform standard out of it either. They have just
>   far to different views on Linux and how they want things to be done.

And the solution is... inventing yet another, incompatible way of doing
things that nobody outside its followers will ever use. Inside the kernel.
Should have thought of that before.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
