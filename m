Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261337AbSKEOmE>; Tue, 5 Nov 2002 09:42:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261678AbSKEOmE>; Tue, 5 Nov 2002 09:42:04 -0500
Received: from mailout03.sul.t-online.com ([194.25.134.81]:26546 "EHLO
	mailout03.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S261337AbSKEOmD>; Tue, 5 Nov 2002 09:42:03 -0500
Cc: Dax Kelson <dax@gurulabs.com>, Rusty Russell <rusty@rustcorp.com.au>,
       linux-kernel@vger.kernel.org, torvalds@transmeta.com, davej@suse.de
References: <20021101085148.E105A2C06A@lists.samba.org>
	<1036175565.2260.20.camel@mentor> <200211050514.53709.agruen@suse.de>
From: Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>
To: Andreas Gruenbacher <agruen@suse.de>
Subject: Re: Filesystem Capabilities in 2.6?
Date: Tue, 05 Nov 2002 15:48:22 +0100
Message-ID: <87u1iwcbt5.fsf@goat.bogus.local>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) XEmacs/21.4 (Honest Recruiter,
 i386-debian-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Gruenbacher <agruen@suse.de> writes:

> On Friday 01 November 2002 19:32, Dax Kelson wrote:
>>
>> With FS capabilities we (Linux) can have the same situation.  Security
>> is a hot topic, and anything the kernel can do make security
>> better/easier seems worthy of consideration.
>
> We have little experience with full blown capability enabled systems. Rushing 

And it will stay that way, if we don't start now.

> things doesn't seem like a good idea. IMO we should wait until vendors have 
> integrated FS caps before adding this to the standard kernel.

Fact is, we have a capability enabled system for quite some time. It's
just not making any progress regarding fs caps. But I must admit, that
it may not be the time to include them into the mainstream kernel. On
the other hand, if there were an implementation from someone Linus
trusts, I'm sure he won't hesitate to include it right away.

BTW, it's really amazing how many people argue _against_ and how few
are working _for_ fs capabilities. And it's not that anybody has shown
real arguments against. Mostly uneasy fealings, eventual scenarios and
bashing of stupid vendors and foolish sysadmins. This might score some
points here and there, but it is not really helpful.

Anyway, have a nice time waiting. ;-)

Regards, Olaf.

-- 
Filesystem capabilities implemented, installed and running right now.
