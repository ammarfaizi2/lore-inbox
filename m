Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262870AbUB0Nbz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 08:31:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262877AbUB0Nbz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 08:31:55 -0500
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:37827 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S262870AbUB0Nbv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 08:31:51 -0500
Date: Fri, 27 Feb 2004 08:31:40 -0500 (EST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Christoph Hellwig <hch@infradead.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH][2.6] linux/README update
In-Reply-To: <20040227132535.A32506@infradead.org>
Message-ID: <Pine.LNX.4.58.0402270827240.17504@montezuma.fsmlabs.com>
References: <Pine.LNX.4.58.0402270815350.17504@montezuma.fsmlabs.com>
 <20040227132535.A32506@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Feb 2004, Christoph Hellwig wrote:

> On Fri, Feb 27, 2004 at 08:18:20AM -0500, Zwane Mwaikambo wrote:
> > + - Do a "make" to create a compressed kernel image. It is also
> > +   possible to do "make install" if you have lilo installed to suit the
> > +   kernel makefiles, but you may want to check your particular lilo setup first.
>
> this is still very x86 centric :)

Drat! I tried inserting the "e.g. arch/i386/boot/bzImage" to fool you
guys =), would it be worth making it more vague so that it was less x86
centric?
