Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261240AbTIYOG5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 10:06:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261246AbTIYOG5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 10:06:57 -0400
Received: from [170.180.5.203] ([170.180.5.203]:1291 "EHLO
	e151000n0.edmonson.k12.ky.us") by vger.kernel.org with ESMTP
	id S261240AbTIYOG4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 10:06:56 -0400
Message-ID: <9A8F8D67DC8ED311BF3E0008C7B9A0ADBAA871@E151000N0>
From: "Norris, Brent" <bnorris@Edmonson.k12.ky.us>
To: "'Lou Langholtz'" <ldl@aros.net>,
       "Norris, Brent" <bnorris@Edmonson.k12.ky.us>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: 128G Limit in Reiserfs? Or the Kernel? Or something else?
Date: Thu, 25 Sep 2003 09:03:17 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> What version of the linux kernel are you using?
> Ie. provide some more info like what's 'uname -a' 
> say on your system. There's been a few patches go
> by this list to fix this disk size problem. They 
> should also be in the latest kernel releases too.

Ok, well that is a start then.  I am running Redhat's latest kernel
2.4.20-20.9 though I also have 2.4.0test4 on the machine.  I haven't tried
it under 2.4.0test4 though.  I just didn't have enough time this morning
when the error surfaced.  Are they in 2.4.22?  Because looking through the
changelog, I see a bunch of AC's and other fixes for IDE items, but I don't
see anything about this boundrey?  Did it go in before then?

Thanks for the help

Brent 
