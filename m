Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268406AbUIFSKs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268406AbUIFSKs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 14:10:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268397AbUIFSKs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 14:10:48 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:53922 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S268396AbUIFSKp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 14:10:45 -0400
Message-Id: <200409061808.i86I8GQZ005051@laptop11.inf.utfsm.cl>
To: Tonnerre <tonnerre@thundrix.ch>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Lee Revell <rlrevell@joe-job.com>,
       Pavel Machek <pavel@ucw.cz>, Spam <spam@tnonline.net>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       Jamie Lokier <jamie@shareable.org>, David Masover <ninja@slaphack.com>,
       Chris Wedgwood <cw@f00f.org>, viro@parcelfarce.linux.theplanet.co.uk,
       Linus Torvalds <torvalds@osdl.org>, Christoph Hellwig <hch@lst.de>,
       Hans Reiser <reiser@namesys.com>, linux-fsdevel@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4 
In-Reply-To: Message from Tonnerre <tonnerre@thundrix.ch> 
   of "Sun, 05 Sep 2004 14:07:58 +0200." <20040905120758.GI26560@thundrix.ch> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 15)
Date: Mon, 06 Sep 2004 14:08:15 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tonnerre <tonnerre@thundrix.ch> said:

[...]

> I can  already see people moving  to FreeBSD if  this gets implemented
> into the kernel...

If it works better for them, great! It is after all a free world. If it
turns out via *BSD/MacOS XIX/Windows 2010/... that it is really useful, we
can add it to Linux. Linux is _not_ in a feeping creaturitis race, thank
you very much.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
