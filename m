Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129457AbQKMXl3>; Mon, 13 Nov 2000 18:41:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129478AbQKMXlT>; Mon, 13 Nov 2000 18:41:19 -0500
Received: from vena.lwn.net ([206.168.112.25]:21767 "HELO eklektix.com")
	by vger.kernel.org with SMTP id <S129457AbQKMXlF>;
	Mon, 13 Nov 2000 18:41:05 -0500
Message-ID: <20001113231104.13349.qmail@eklektix.com>
To: linux-kernel@vger.kernel.org
Cc: Steven_Snyder@3com.com
Subject: Re: Current doc for writing device drivers? 
From: corbet-lk@lwn.net (Jonathan Corbet)
In-Reply-To: Your message of "Mon, 13 Nov 2000 10:53:30 EST."
             <3A100E7A.2F00682E@mandrakesoft.com> 
Date: Mon, 13 Nov 2000 16:11:04 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The Rubini book is being updated for 2.2 and 2.4, but I dunno when it
> will go to press.

We're working on it - honest!

The book will go out for technical review before too long; I believe the
current target date to have it on the shelves is April.  We'd hoped for
sooner, but, given how 2.4 development has gone, I think the timing is
about right.  After all, we wouldn't want to present the wrong prototype
for kmap() or miss out on the new inter-module communication API...:)

jon
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
