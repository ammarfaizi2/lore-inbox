Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267746AbUIJR43@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267746AbUIJR43 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 13:56:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267678AbUIJRzv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 13:55:51 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:63711 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S267646AbUIJRwK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 13:52:10 -0400
Message-Id: <200409101750.i8AHo5qx005157@localhost.localdomain>
To: Wayne Scott <wscott@bitmover.com>
cc: miller@techsource.com, reiser@namesys.com, Peter.Foldiak@st-andrews.ac.uk,
       jamie@shareable.org, bunk@fs.tum.de,
       viro@parcelfarce.linux.theplanet.co.uk, torvalds@osdl.org, hch@lst.de,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       flx@namesys.com, reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4 
In-Reply-To: Message from Wayne Scott <wscott@bitmover.com> 
   of "Fri, 10 Sep 2004 10:50:40 EST." <20040910.105040.30177815.wscott@bitmover.com> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 15)
Date: Fri, 10 Sep 2004 13:50:05 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Timothy Miller <miller@techsource.com> said:
> > Everyone likes ':', so we'd have "problem/shoe:size".  (Don't bother to 
> > complain about files which have : in them, because I already know it 
> > sucks, but it's an example.)
> 
> [[ I just joined this discussion, so pardon if this is already known.]]

> One advantage of ':' is that portable programs already have to avoid
> it because of NTFS alternate data streams:

Portable programs working on POSIX don't give a damn that C:, CON:, etc are
reserved in MS-DOS.

Windows warts shouldn't infect Linux.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
