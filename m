Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267389AbUIFWh2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267389AbUIFWh2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 18:37:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267362AbUIFWh2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 18:37:28 -0400
Received: from as8-6-1.ens.s.bonet.se ([217.215.92.25]:27348 "EHLO
	zoo.weinigel.se") by vger.kernel.org with ESMTP id S267386AbUIFWhX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 18:37:23 -0400
To: David Masover <ninja@slaphack.com>
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>, Spam <spam@tnonline.net>,
       Tonnerre <tonnerre@thundrix.ch>,
       Christer Weinigel <christer@weinigel.se>,
       Linus Torvalds <torvalds@osdl.org>, Pavel Machek <pavel@ucw.cz>,
       Jamie Lokier <jamie@shareable.org>, Chris Wedgwood <cw@f00f.org>,
       viro@parcelfarce.linux.theplanet.co.uk, Christoph Hellwig <hch@lst.de>,
       Hans Reiser <reiser@namesys.com>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
References: <200409061814.i86IEcPJ005086@laptop11.inf.utfsm.cl>
	<413CB219.5030800@slaphack.com>
From: Christer Weinigel <christer@weinigel.se>
Organization: Weinigel Ingenjorsbyra AB
Date: 07 Sep 2004 00:37:22 +0200
In-Reply-To: <413CB219.5030800@slaphack.com>
Message-ID: <m3hdqbja71.fsf@zoo.weinigel.se>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Masover <ninja@slaphack.com> writes:

> Second, there are quite a few things which I might want to do, which can
> be done with this interface and without patching programs, but would
> require massive patches to userspace.  There have been numerous
> examples.

Please give one example?  There is a lot of handwaving here on all
sides.

> | I'd go the other way around: Get userspace to agree on a common framework,
> | make it work in userspace; if (extensive, hopefully) experience shows that
> | a pure userspace solution has issues that can't be solved except by kernel
> | assistance, so be it.
> 
> We already have such a framework -- it's called "VFS".

That you'd like to break the semantics of.  Great.

  /Christer

-- 
"Just how much can I get away with and still go to heaven?"

Freelance consultant specializing in device driver programming for Linux 
Christer Weinigel <christer@weinigel.se>  http://www.weinigel.se
