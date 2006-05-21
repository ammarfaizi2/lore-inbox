Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964926AbWEUURY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964926AbWEUURY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 16:17:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964931AbWEUURY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 16:17:24 -0400
Received: from smtp114.sbc.mail.mud.yahoo.com ([68.142.198.213]:14522 "HELO
	smtp114.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S964926AbWEUURX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 16:17:23 -0400
Date: Sun, 21 May 2006 13:17:20 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Dave Jones <davej@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, levon@movementarian.org,
       phil.el@wanadoo.fr, Andrew Morton <akpm@osdl.org>
Subject: Re: Is OPROFILE actively maintained?
Message-ID: <20060521201720.GA2712@taniwha.stupidest.org>
References: <20060520025322.GD9486@taniwha.stupidest.org> <20060521194915.GA2153@taniwha.stupidest.org> <20060521195710.GL8250@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060521195710.GL8250@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 21, 2006 at 03:57:10PM -0400, Dave Jones wrote:

> Why on earth would we want to remove a working feature ?

We don't.  I personally don't want to see it go, I use it myself.

> Just because it isn't getting patched every release doesn't mean
> it's rotting, Oprofile is actually one of the few kernel features
> which I don't recall a single regression in since 2.6.0

It works for me, still others have claimed it's unmaintained and has
issues that have not been address.

> BROKEN is for stuff that doesn't compile, or is fundamentally flawed
> beyond repair at the current time (For example, needs infrastructure
> work to happen before it can work correctly).

Sure, based on my personal experience oprofile works fine, I'm just
putting an idea out there given comments from others.

> Oprofile fits neither of those categories.

So it should remain EXPERIMENTAL then in your view?
