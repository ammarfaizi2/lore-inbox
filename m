Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261151AbUJYRtG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261151AbUJYRtG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 13:49:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261166AbUJYRqH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 13:46:07 -0400
Received: from mail-relay-4.tiscali.it ([213.205.33.44]:61065 "EHLO
	mail-relay-4.tiscali.it") by vger.kernel.org with ESMTP
	id S261202AbUJYRgL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 13:36:11 -0400
Date: Mon, 25 Oct 2004 19:34:38 +0200
From: Andrea Arcangeli <andrea@novell.com>
To: Larry McVoy <lm@work.bitmover.com>, Joe Perches <joe@perches.com>,
       Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
       Linus Torvalds <torvalds@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Larry McVoy <lm@bitmover.com>, akpm@osdl.org
Subject: Re: BK kernel workflow
Message-ID: <20041025173438.GH14325@dualathlon.random>
References: <4d8e3fd304102403241e5a69a5@mail.gmail.com> <20041024144448.GA575@work.bitmover.com> <4d8e3fd304102409443c01c5da@mail.gmail.com> <20041024233214.GA9772@work.bitmover.com> <20041025114641.GU14325@dualathlon.random> <1098707342.7355.44.camel@localhost.localdomain> <20041025133951.GW14325@dualathlon.random> <20041025162022.GA27979@work.bitmover.com> <20041025164732.GE14325@dualathlon.random> <20041025171223.GA4503@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041025171223.GA4503@work.bitmover.com>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 25, 2004 at 10:12:23AM -0700, Larry McVoy wrote:
> We think that that is not true and you yourself prove our point.  Kernel
> guys like working on the kernel. [..]

This is sure fine with Linus and Andrew (peraphs even with myself), but
not everybody is Andrew and Linus. The reason I don't use it myself is
to avoid tainting _other_ people that might be beginners that might one
day write their own GPL'd SCM.
