Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268163AbUIAFC7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268163AbUIAFC7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 01:02:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268381AbUIAFC7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 01:02:59 -0400
Received: from gprs212-176.eurotel.cz ([160.218.212.176]:8832 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S268001AbUIAFCz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 01:02:55 -0400
Date: Wed, 1 Sep 2004 07:02:01 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Christer Weinigel <christer@weinigel.se>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       David Masover <ninja@slaphack.com>, Jamie Lokier <jamie@shareable.org>,
       Chris Wedgwood <cw@f00f.org>, viro@parcelfarce.linux.theplanet.co.uk,
       Christoph Hellwig <hch@lst.de>, Hans Reiser <reiser@namesys.com>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040901050201.GB512@elf.ucw.cz>
References: <200408311931.i7VJV8kt028102@laptop11.inf.utfsm.cl> <Pine.LNX.4.58.0408311252150.2295@ppc970.osdl.org> <20040831203226.GB16110@elf.ucw.cz> <Pine.LNX.4.58.0408311336580.2295@ppc970.osdl.org> <20040831205422.GD16110@elf.ucw.cz> <Pine.LNX.4.58.0408311357550.2295@ppc970.osdl.org> <20040831220726.GB16428@elf.ucw.cz> <m3acwa99qz.fsf@zoo.weinigel.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3acwa99qz.fsf@zoo.weinigel.se>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I belive the kernel could give some assistance to make it easier to
> see if a file has been modified, I remember that a few suggestions
> were thrown around the last time Samba and dcache aliases were
> discussed on l-k.  I definitely belive that kind of infrastructure
> belongs in the kernel.  But the cache manager itself, no.

Well, callback "filesystem full" would be nice, too; but I guess that
is "support user cache", too...
								Pavel
-- 
When do you have heart between your knees?
