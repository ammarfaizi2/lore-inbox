Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932379AbWFLVgM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932379AbWFLVgM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 17:36:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932380AbWFLVgM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 17:36:12 -0400
Received: from outbound-red.frontbridge.com ([216.148.222.49]:42567 "EHLO
	outbound2-red-R.bigfish.com") by vger.kernel.org with ESMTP
	id S932379AbWFLVgK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 17:36:10 -0400
X-BigFish: V
Message-ID: <448DDE46.2020602@am.sony.com>
Date: Mon, 12 Jun 2006 14:36:06 -0700
From: Tim Bird <tim.bird@am.sony.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: tglx@linutronix.de
CC: Matt Mackall <mpm@selenic.com>, "H. Peter Anvin" <hpa@zytor.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86 built-in command line
References: <20060611215530.GH24227@waste.org>	 <200606121712.k5CHClUE017185@terminus.zytor.com>	 <20060612204925.GT24227@waste.org> <1150147153.5257.277.camel@localhost.localdomain>
In-Reply-To: <1150147153.5257.277.camel@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Gleixner wrote:
> Well most of the bootloaders I'm working with let me change the
> commandline. 

Just FYI for this thread, most of the bootloaders I work with
don't let me change the kernel command line.  Many have no
knowledge of Linux whatsoever.  Many boards, especially internal
boards, have hobbled-together custom bootloaders.

Hence, I've gotten out of the habit of figuring out how to set
the command line args from the bootloader even for those
platforms where the bootloader *is* capable of it.
 -- Tim

=============================
Tim Bird
Architecture Group Chair, CE Linux Forum
Senior Staff Engineer, Sony Electronics
=============================

