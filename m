Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266485AbUIEL7M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266485AbUIEL7M (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 07:59:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266490AbUIEL7M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 07:59:12 -0400
Received: from c002781a.fit.bostream.se ([217.215.235.8]:55696 "EHLO
	mail.tnonline.net") by vger.kernel.org with ESMTP id S266485AbUIEL6A
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 07:58:00 -0400
Date: Sun, 5 Sep 2004 13:57:49 +0200
From: Spam <spam@tnonline.net>
Reply-To: Spam <spam@tnonline.net>
X-Priority: 3 (Normal)
Message-ID: <1215700165.20040905135749@tnonline.net>
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
In-Reply-To: <20040905111743.GC26560@thundrix.ch>
References: <200408311931.i7VJV8kt028102@laptop11.inf.utfsm.cl>
 <Pine.LNX.4.58.0408311252150.2295@ppc970.osdl.org>
 <m3eklm9ain.fsf@zoo.weinigel.se> <20040905111743.GC26560@thundrix.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  

> Salut,

> On Wed, Sep 01, 2004 at 01:02:24AM +0200, Christer Weinigel wrote:
>> I can see the argument for having the equivalent of Content-type or
>> Content-transfer-encoding as a named stream though.

> Why having them as  named streams if we can get them  as xattrs for no
> additional pain? (Since fileutils would  have to be changed anyway, we
> can even make cp copy and emacs update xattrs.)

  What if I do not use emacs, but vim, mcedit, gedit, or some other
  editor? It doesn't seem logical to have to patch every application
  that uses files.

  ~S

> 			    Tonnerre

