Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264901AbTLKMiJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 07:38:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264916AbTLKMiJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 07:38:09 -0500
Received: from pentafluge.infradead.org ([213.86.99.235]:23500 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S264901AbTLKMiG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 07:38:06 -0500
Subject: Re: Linux GPL and binary module exception clause?
From: David Woodhouse <dwmw2@infradead.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Larry McVoy <lm@bitmover.com>, Erik Andersen <andersen@codepoet.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Paul Adams <padamsdev@yahoo.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0312041750270.6638@home.osdl.org>
References: <20031204235055.62846.qmail@web21503.mail.yahoo.com>
	 <20031205004653.GA7385@codepoet.org>
	 <Pine.LNX.4.58.0312041956530.27578@montezuma.fsmlabs.com>
	 <20031205010349.GA9745@codepoet.org>
	 <20031205012124.GB15799@work.bitmover.com>
	 <Pine.LNX.4.58.0312041750270.6638@home.osdl.org>
Content-Type: text/plain
Message-Id: <1071146277.5712.589.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8.dwmw2.1) 
Date: Thu, 11 Dec 2003 12:37:58 +0000
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-12-04 at 17:58 -0800, Linus Torvalds wrote:
> But a license only covers what it _can_ cover - derived works. The fact
> that Linux is under the GPL simply _cannot_matter_ to a user program, if
> the author can show that the user program is not a derived work.

Not so. You, as author of the GPL'd work, are granting permission for
someone else to make use of it (other than 'fair use' which they were
already permitted).

Your conditions for granting that permission do _not_ have to be
restricted to licensing of derived works. You can even ask for _money_
in return, if you like. Or you could require that the lucky recipient
bathe in creosote daily, in order to receive your licence.

I could write a piece of software and tell you that you're only allowed
to use it if you release _all_ future software you write under the GPL.
Even stuff which isn't at all related, let alone non-derived.

It wouldn't be illegal for you to create your own non-GPL software per
se; it would just mean you don't have permission to use what _I_ had
written and released under this hypothetical licence.

You'd probably have to be mad to accept this licence, and of course I
don't argue that the GPL actually goes _that_ far, but a copyright
licence certainly _can_ do so.

The GPL explicitly does make reference to required licensing terms for
non-derived works in certain circumstances, even those which can
reasonably be considered separate and independent works in themselves. 

There is no question that, as a copyright licence, the GPL _can_ extend
to a non-derived work; and in some circumstances it clearly _does_. 

-- 
dwmw2

