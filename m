Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316916AbSGSSDB>; Fri, 19 Jul 2002 14:03:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316928AbSGSSDB>; Fri, 19 Jul 2002 14:03:01 -0400
Received: from www.transvirtual.com ([206.14.214.140]:29970 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S316916AbSGSSDA>; Fri, 19 Jul 2002 14:03:00 -0400
Date: Fri, 19 Jul 2002 11:05:44 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: Russell King <rmk@arm.linux.org.uk>
cc: Werner Almesberger <wa@almesberger.net>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] CONFIG_MAGIC_SYSRQ without CONFIG_VT broken in 2.5.26
In-Reply-To: <20020719091017.A28569@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0207191104590.8143-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > 2.5.26 fails with missing symbols fg_console and kbd_table if
> > enabling Magic SysRq but disabling virtual terminals. The
> > trivial patch below fixes this.
>
> I posted a fix for this on July 17th.  However, yours looks better.
> James?

Applied. I will push the changes to Linus. I have other updates as well. I
will post soon.


