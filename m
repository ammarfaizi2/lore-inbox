Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266574AbUIEMag@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266574AbUIEMag (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 08:30:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266582AbUIEMag
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 08:30:36 -0400
Received: from c002781a.fit.bostream.se ([217.215.235.8]:10642 "EHLO
	mail.tnonline.net") by vger.kernel.org with ESMTP id S266574AbUIEMaZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 08:30:25 -0400
Date: Sun, 5 Sep 2004 14:30:12 +0200
From: Spam <spam@tnonline.net>
Reply-To: Spam <spam@tnonline.net>
X-Priority: 3 (Normal)
Message-ID: <1819110960.20040905143012@tnonline.net>
To: Tonnerre <tonnerre@thundrix.ch>
CC: Christer Weinigel <christer@weinigel.se>,
       Linus Torvalds <torvalds@osdl.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, Pavel Machek <pavel@ucw.cz>,
       David Masover <ninja@slaphack.com>, Jamie Lokier <jamie@shareable.org>,
       Chris Wedgwood <cw@f00f.org>, <viro@parcelfarce.linux.theplanet.co.uk>,
       Christoph Hellwig <hch@lst.de>, Hans Reiser <reiser@namesys.com>,
       <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
In-Reply-To: <20040905115854.GH26560@thundrix.ch>
References: <200408311931.i7VJV8kt028102@laptop11.inf.utfsm.cl>
 <Pine.LNX.4.58.0408311252150.2295@ppc970.osdl.org>
 <m3eklm9ain.fsf@zoo.weinigel.se> <20040905111743.GC26560@thundrix.ch>
 <1215700165.20040905135749@tnonline.net> <20040905115854.GH26560@thundrix.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  

> Salut,

> On Sun, Sep 05, 2004 at 01:57:49PM +0200, Spam wrote:
>>   What if I do not use emacs, but vim, mcedit, gedit, or some other
>>   editor? It doesn't seem logical to have to patch every application
>>   that uses files.

> We would have to do that in  either case, so let's patch them to do it
> in a nonintrusive way. And as to reading and writing inside tar files,
> write and/or  use a really nice  userspace library to do  it. (As does
> MacOS/X, as does KDE, etc.)

  The problem with the userspace library is standardization. What
  would be needed is a userspace library that has a extensible plugin
  interface that is standardized. Otherwise we would need lots of
  different libraries, and I seriously doubt that 1) this will happen
  and 2) we get all Linux programs to be patched to use it.

  ~S

> 			    Tonnerre

