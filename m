Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263890AbTLEGny (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 01:43:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263891AbTLEGny
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 01:43:54 -0500
Received: from fw.osdl.org ([65.172.181.6]:56478 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263890AbTLEGnw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 01:43:52 -0500
Date: Thu, 4 Dec 2003 22:43:42 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: David Schwartz <davids@webmaster.com>
cc: andersen@codepoet.org, Paul Adams <padamsdev@yahoo.com>,
       linux-kernel@vger.kernel.org
Subject: RE: Linux GPL and binary module exception clause?
In-Reply-To: <MDEHLPKNGKAHNMBLJOLKKEIDIHAA.davids@webmaster.com>
Message-ID: <Pine.LNX.4.58.0312042241210.9125@home.osdl.org>
References: <MDEHLPKNGKAHNMBLJOLKKEIDIHAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 4 Dec 2003, David Schwartz wrote:
>
> Yes, but they will cite the prohibition against *creating* derived
> works.

So?

The same prohibition exists with the GPL. You are not allowed to create
and distribute a derived work unless it is GPL'd.

I don't see what you are arguing against. It is very clear: a kernel
module is a derived work of the kernel by default. End of story.

You can then try to prove (through development history etc) that there
would be major reasons why it's not really derived. But your argument
seems to be that _nothing_ is derived, which is clearly totally false, as
you yourself admit when you replace "kernel" with "Harry Potter".

		Linus
