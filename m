Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263299AbTLXCEa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 21:04:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263298AbTLXCEa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 21:04:30 -0500
Received: from [141.154.95.10] ([141.154.95.10]:26856 "EHLO peabody.ximian.com")
	by vger.kernel.org with ESMTP id S263299AbTLXCEZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 21:04:25 -0500
Subject: Re: DevFS vs. udev
From: Rob Love <rml@ximian.com>
To: Ian Kent <raven@themaw.net>
Cc: Greg KH <greg@kroah.com>, akpm@osdl.org, "Bradley W. Allen" <ULMO@Q.NET>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0312240938450.890-100000@wombat.indigo.net.au>
References: <Pine.LNX.4.33.0312240938450.890-100000@wombat.indigo.net.au>
Content-Type: text/plain
Message-Id: <1072231437.3826.3.camel@fur>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8) 
Date: Tue, 23 Dec 2003 21:03:57 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-12-23 at 20:52, Ian Kent wrote:

> It certainly seems like a good project for a someone, such as myself, that
> is new to kernel development.

Please take no offense to this, but it is an awful project for someone
new to kernel development.  Plenty of knowledgeable/semi-knowledgeable
kernel hackers looked at devfs and given up on it.  Despite what some
people say about Richard, he is a good guy, and he did not succeed
either.

devfs is hard to get right and, worse, you will be starting with a bad
base of code that I would not want to touch with an 18.72 foot pole.

Greg, via udev, has made it so easy to just back up, slowly, and walk
away from devfs.  devfs is not going anywhere in 2.6, I do not think,
but let sleeping piles of crap sleep and let's just jettison this thing
as soon as we can.

Just my two cents - I am warning you ;)

	Rob Love


