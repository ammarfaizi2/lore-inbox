Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265268AbTLFWcQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Dec 2003 17:32:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265269AbTLFWcQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Dec 2003 17:32:16 -0500
Received: from fw.osdl.org ([65.172.181.6]:62370 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265268AbTLFWcP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Dec 2003 17:32:15 -0500
Date: Sat, 6 Dec 2003 14:32:08 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Larry McVoy <lm@bitmover.com>
cc: Wakko Warner <wakko@animx.eu.org>, linux-kernel@vger.kernel.org
Subject: Re: cdrecord hangs my computer
In-Reply-To: <20031206220227.GA19016@work.bitmover.com>
Message-ID: <Pine.LNX.4.58.0312061429080.2092@home.osdl.org>
References: <Law9-F31u8ohMschTC00001183f@hotmail.com>
 <Pine.LNX.4.58.0312060011130.2092@home.osdl.org> <3FD1994C.10607@stinkfoot.org>
 <20031206084032.A3438@animx.eu.org> <Pine.LNX.4.58.0312061044450.2092@home.osdl.org>
 <20031206220227.GA19016@work.bitmover.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 6 Dec 2003, Larry McVoy wrote:
>
> Hey, that "piece of crap" has burned one heck of a lot of ISO images of
> Linux over the years.

And so does windows. That doesn't make it good.

> How about a nod of thanks to the author before you tell him you don't
> like his interface?

I tried to tell him why numbers are bad. Very politely, explaining that a
lot of devices cannot be enumerated by a traditional "bus/dev/lun" scheme.
He basically cursed at me, and told me that that is how SCSI works. Never
mind that IDE isn't SCSI, and even SCSI doesn't work that way any more
(iSCSI comes to mind).

I can be polite. But when there is no reason to be polite, I can be blunt
too.

				Linus
