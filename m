Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278927AbRK1RqR>; Wed, 28 Nov 2001 12:46:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278911AbRK1RqH>; Wed, 28 Nov 2001 12:46:07 -0500
Received: from www.transvirtual.com ([206.14.214.140]:4102 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S278701AbRK1RqB>; Wed, 28 Nov 2001 12:46:01 -0500
Date: Wed, 28 Nov 2001 09:45:35 -0800 (PST)
From: James Simmons <jsimmons@transvirtual.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] [PATCH] earlier printk output
In-Reply-To: <3C044816.D6DCD2D3@mandrakesoft.com>
Message-ID: <Pine.LNX.4.10.10111280945060.11130-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > This patch creates console devices specifically for use during early
> > boot, and registers them so that printk() output may be seen prior
> > to console_init().
> 
> > Included are i386 config options, early VGA text output, and early i386
> > serial output.
> 
> nice.  these patches work on some non-x86 platforms too...

Where is this patch? Sine I have rewritten the console/tty layer I'm quite
interested in this.


