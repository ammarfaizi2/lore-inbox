Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262063AbUB2QRW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Feb 2004 11:17:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262066AbUB2QRW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Feb 2004 11:17:22 -0500
Received: from hell.org.pl ([212.244.218.42]:57865 "HELO hell.org.pl")
	by vger.kernel.org with SMTP id S262063AbUB2QRT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Feb 2004 11:17:19 -0500
Date: Sun, 29 Feb 2004 17:17:21 +0100
From: Karol Kozimor <sziwan@hell.org.pl>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Dropping CONFIG_PM_DISK?
Message-ID: <20040229161721.GA16688@hell.org.pl>
References: <1ulUA-33w-3@gated-at.bofh.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
In-Reply-To: <1ulUA-33w-3@gated-at.bofh.it>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thus wrote Pavel Machek:
> Would there be any major screaming if I tried to drop CONFIG_PM_DISK?
> It seems noone is maintaining it, equivalent functionality is provided
> by swsusp, and it is confusing users...

It may be ugly, it may be unmaintained, but I get the impression that it
works for some people for whom swsusp doesn't. So unless swsusp works for
everyone or Nigel's swsusp2 is merged, I'd suggest leaving that in.
Best regards,

-- 
Karol 'sziwan' Kozimor
sziwan@hell.org.pl
