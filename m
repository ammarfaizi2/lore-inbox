Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261873AbTJ2WmV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Oct 2003 17:42:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261923AbTJ2WmV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Oct 2003 17:42:21 -0500
Received: from mail.webmaster.com ([216.152.64.131]:59851 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP id S261873AbTJ2WmT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Oct 2003 17:42:19 -0500
From: "David Schwartz" <davids@webmaster.com>
To: "Timothy Miller" <miller@techsource.com>
Cc: "Pascal Schmidt" <der.eremit@email.de>, <linux-kernel@vger.kernel.org>
Subject: RE: People, not GPL  [was: Re: Driver Model]
Date: Wed, 29 Oct 2003 14:42:13 -0800
Message-ID: <MDEHLPKNGKAHNMBLJOLKIEOCHIAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <3F62335B.9050202@techsource.com>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> David Schwartz wrote:

> But beyond this, there are some social issues.  If someone finds a way
> to work around this mechanism, they are breaking things to everyone
> else's detriment.  For a commercial entity to violate the GPL_ONLY
> barrier is an insult to kernel developers AND to their customers who
> will have trouble getting problems solved.

	While I understand this point of view, I do not share it. People
contributed to the Linux kernel project largely because it *was* an open
process. Nobody has the right to take offense when it's used for a different
reason than they had intended. If you want control over how your code is
used and modified, *don't* GPL it. If you're going to take offense when
people remove restrictions you impose, regardless of how much you like the
restrictions, *don't*' GPL it. It's that simple.

> So, if a company works around GPL_ONLY, are they violating the GPL
> license?  Probably not.  Does that make it OKAY?  Probably not.

	What's not okay is trying to inject your own rules on how GPL'd software
can be used. That's perhaps tolerable if you're the sole author. It's
condemnable when you're one among many.

> This is like finding a way to give a user space program access to kernel
> resources.  There are barriers put in place for a REASON because people
> make mistakes when they write software.  If no one did, we wouldn't have
> any need for memory protection, would we.

	Yet there is a project that removes all of these boundaries in the name of
improved performance for trusted applications. These are engineering
trade-offs and one of the good things about the GPL is that I'm not stuck,
by law or custom, when your engineering trade-offs if I don't think they
apply to me.

	DS


