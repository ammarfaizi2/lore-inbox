Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262510AbSKEO7o>; Tue, 5 Nov 2002 09:59:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262667AbSKEO7o>; Tue, 5 Nov 2002 09:59:44 -0500
Received: from ns.suse.de ([213.95.15.193]:49417 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S262510AbSKEO7n> convert rfc822-to-8bit;
	Tue, 5 Nov 2002 09:59:43 -0500
Content-Type: text/plain; charset=US-ASCII
From: Andreas Gruenbacher <agruen@suse.de>
Organization: SuSE Linux AG
To: Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>
Subject: Re: Filesystem Capabilities in 2.6?
Date: Tue, 5 Nov 2002 16:05:47 +0100
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org
References: <20021101085148.E105A2C06A@lists.samba.org> <200211050514.53709.agruen@suse.de> <87u1iwcbt5.fsf@goat.bogus.local>
In-Reply-To: <87u1iwcbt5.fsf@goat.bogus.local>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200211051605.47225.agruen@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 05 November 2002 15:48, Olaf Dietsche wrote:
> Andreas Gruenbacher <agruen@suse.de> writes:
> > On Friday 01 November 2002 19:32, Dax Kelson wrote:
> >> With FS capabilities we (Linux) can have the same situation.  Security
> >> is a hot topic, and anything the kernel can do make security
> >> better/easier seems worthy of consideration.
> >
> > We have little experience with full blown capability enabled systems.
> > Rushing
>
> And it will stay that way, if we don't start now.
>
> > things doesn't seem like a good idea. IMO we should wait until vendors
> > have integrated FS caps before adding this to the standard kernel.
>
> Fact is, we have a capability enabled system for quite some time. It's
> just not making any progress regarding fs caps. 

> But I must admit, that it may not be the time to include them into
> the mainstream kernel.

This was my point. After this discussion I am sure the patch won't be merged 
for 2.6 anyway.

[...]

> BTW, it's really amazing how many people argue _against_ and how few
> are working _for_ fs capabilities. And it's not that anybody has shown
> real arguments against. Mostly uneasy fealings, eventual scenarios and
> bashing of stupid vendors and foolish sysadmins. This might score some
> points here and there, but it is not really helpful.

Several pros and cons were brought up. In the end all that counts is whether 
the pros are big enough to warrant the cons.

--Andreas.

