Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964936AbWEUU4s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964936AbWEUU4s (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 16:56:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964937AbWEUU4s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 16:56:48 -0400
Received: from smtp110.sbc.mail.mud.yahoo.com ([68.142.198.209]:12205 "HELO
	smtp110.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S964936AbWEUU4r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 16:56:47 -0400
Date: Sun, 21 May 2006 13:56:44 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Dave Jones <davej@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, levon@movementarian.org,
       phil.el@wanadoo.fr, Andrew Morton <akpm@osdl.org>
Subject: Re: Is OPROFILE actively maintained?
Message-ID: <20060521205644.GA3420@taniwha.stupidest.org>
References: <20060520025322.GD9486@taniwha.stupidest.org> <20060521194915.GA2153@taniwha.stupidest.org> <20060521195710.GL8250@redhat.com> <20060521201720.GA2712@taniwha.stupidest.org> <20060521204947.GM8250@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060521204947.GM8250@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 21, 2006 at 04:49:47PM -0400, Dave Jones wrote:

> Part of the problem with EXPERIMENTAL is that it's been taken
> to mean all sorts of things over the years

yes

> from "this isn't quite ready, but works"

ok for -mm perhaps, not mainline

> to "if you enable this, you're a lunatic".

suitable for neither -mm not mainline

> It's meant that pretty much everyone has to enable
> CONFIG_EXPERIMENTAL anyway for a kernel offering the features
> everyone has come to expect.  As means of example, I'll bet there's
> no (or at least very few) distros that ship a kernel with
> CONFIG_EXPERIMENTAL disabled.

i don't see why we can't audit EXPERIMENTAL users and try to clarify
which ones are really needed over time though
