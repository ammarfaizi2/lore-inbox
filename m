Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261420AbVBHCYK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261420AbVBHCYK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 21:24:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261442AbVBHCYK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 21:24:10 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:60565 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S261420AbVBHCX7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 21:23:59 -0500
Message-Id: <200502080023.j180NDJI006174@laptop11.inf.utfsm.cl>
To: Clemens Schwaighofer <cs@tequila.co.jp>
cc: Andries Brouwer <aebr@win.tue.nl>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Pozsar Balazs <pozsy@uhulinux.hu>,
       Christoph Hellwig <hch@infradead.org>,
       OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
       John Richard Moser <nigelenki@comcast.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: msdos/vfat defaults are annoying 
In-Reply-To: Message from Clemens Schwaighofer <cs@tequila.co.jp> 
   of "Mon, 07 Feb 2005 23:00:10 +0900." <4207746A.2070401@tequila.co.jp> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 15)
Date: Mon, 07 Feb 2005 21:23:13 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Clemens Schwaighofer <cs@tequila.co.jp> said:

[...]

> but to be honest, most times I need vfat, and I actually haven't
> encountered a time when I need msdos.

But writing MSDOS on a VFAT filesystem is a sure way to screw it up, and
AFAIU vice-versa.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
