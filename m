Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270805AbTHSQSk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 12:18:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270984AbTHSQP6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 12:15:58 -0400
Received: from zeus.kernel.org ([204.152.189.113]:53499 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S270754AbTHSQNS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 12:13:18 -0400
Subject: Re: 2.4.22-pre lockups (now decoded oops for pre10)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: Mike Fedyk <mfedyk@matchmail.com>, andrea@suse.de, green@namesys.com,
       Marcelo Tosatti <marcelo@conectiva.com.br>, akpm@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       mason@suse.com
In-Reply-To: <20030819091243.007acac0.skraw@ithnet.com>
References: <20030813125509.360c58fb.skraw@ithnet.com>
	 <Pine.LNX.4.44.0308131143570.4279-100000@localhost.localdomain>
	 <20030813145940.GC26998@namesys.com>
	 <20030813171224.2a13b97f.skraw@ithnet.com>
	 <20030813153009.GA27209@namesys.com> <20030819011208.GK10320@matchmail.com>
	 <20030819091243.007acac0.skraw@ithnet.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1061298621.30565.31.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 (1.4.3-3) 
Date: 19 Aug 2003 14:10:22 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2003-08-19 at 08:12, Stephan von Krawczynski wrote:
> > Are you saying that one CPU can't saturate the memory bus?  Or maybe we're
> > hitting something on the CPU bus, or just that SMP will change the timings
> > and stress things differently?  Or that if memtest doesn't test from the
> > second CPU then it could be a faulty cpu/L2?
> 
> Well, if memtest does not use a second available CPU then probably we should
> ask the author about this...

I'm sure he'd give you a quote for adding SMP support if you asked.

