Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266624AbUBLVxZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 16:53:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266613AbUBLVwq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 16:52:46 -0500
Received: from fw.osdl.org ([65.172.181.6]:47305 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266605AbUBLVwn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 16:52:43 -0500
Date: Thu, 12 Feb 2004 13:54:21 -0800
From: Andrew Morton <akpm@osdl.org>
To: Pat Gefre <pfg@sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6] small Altix mod [1/2]
Message-Id: <20040212135421.2dbabe5c.akpm@osdl.org>
In-Reply-To: <Pine.SGI.3.96.1040212104225.6390A-100000@fsgi900.americas.sgi.com>
References: <Pine.SGI.3.96.1040212104225.6390A-100000@fsgi900.americas.sgi.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pat Gefre <pfg@sgi.com> wrote:
>
> Here's a small mod to the Altix code. Andrew can you take this ??

Both of these patches are in 2.6.3-rc2-mm1.

I (almost) never silently drop patches.  If you sent something and didn't
hear back, assume it went in.

I usually don't ack patches either, sorry.  Probably I should - davem does.
Generally it's just noise.  I will ack if I made changes to the patch, or
need more details, etc.   I shall try to be ackier.

If you didn't hear, and the next -mm does not contain your patch, and you
care about it even a little bit, please remind me.

It helps me if the reminder contains a fresh copy of the patch, with your
description.

If the patch is urgent then please flag it as such.  We're at -rc now, and
these patches don't look urgent to me, so I shall sit on them until after
2.6.3.

