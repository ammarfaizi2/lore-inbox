Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263609AbTLJPOr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 10:14:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263618AbTLJPOq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 10:14:46 -0500
Received: from fw.osdl.org ([65.172.181.6]:42383 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263609AbTLJPOl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 10:14:41 -0500
Date: Wed, 10 Dec 2003 07:14:31 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andre Hedrick <andre@linux-ide.org>
cc: Paul Adams <padamsdev@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux GPL and binary module exception clause?
In-Reply-To: <Pine.LNX.4.10.10312100419220.3805-100000@master.linux-ide.org>
Message-ID: <Pine.LNX.4.58.0312100711460.29676@home.osdl.org>
References: <Pine.LNX.4.10.10312100419220.3805-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 10 Dec 2003, Andre Hedrick wrote:
>
> So basically anyone in the past-present-future who worked on-with-about
> the linux kernel is now tainted forever.

Andre - before you get involved in a flame war, take a deep breath. You
know you get too excited about things.

Go back and read what I said. I said _nothing_ like the above. Quite the
reverse.

Also, I don't see what the "API" discussion is. That's a _total_ red
herring. There is no "module API", and never has been. Modules have always
been about linking against internal kernel functions, and it's always been
very clear that there is no API, and that those internal kernel interfaces
change _all_ the time.

		Linus
