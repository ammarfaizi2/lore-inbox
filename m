Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161099AbWALUcE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161099AbWALUcE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 15:32:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161179AbWALUcE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 15:32:04 -0500
Received: from smtp.osdl.org ([65.172.181.4]:7565 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161099AbWALUcD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 15:32:03 -0500
Date: Thu, 12 Jan 2006 12:31:44 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: "M.Gehre" <M.Gehre@gmx.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: [Patch v2] Replacing 0xff.. with correct DMA_xBIT_MASK
In-Reply-To: <43C6BBB2.2060101@gmx.de>
Message-ID: <Pine.LNX.4.64.0601121227550.3535@g5.osdl.org>
References: <43C6BBB2.2060101@gmx.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 12 Jan 2006, M.Gehre wrote:
>
> From: Matthias Gehre

Btw, when doing the "From:" thing, I'd really prefer the email address 
too, so that it ends up in the author field.

In fact, if there is nothing that looks like an email address, my patch 
application scripts will ignore this "From:" in the body of the mail, and 
use the From: from the headers (now, in this case it obviously is the 
right thing to do, but if somebody else passes the email on to me, it 
would result in you not being properly credited as author for the commit, 
although the commit _message_ would then have that "From:" line in it).

Having an email address in the authorship data is just too convenient (ie 
something goes wrong with the change, and we need to contact the author or 
similar).

			Linus
