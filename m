Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272810AbTHRUTY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 16:19:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274813AbTHRUTX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 16:19:23 -0400
Received: from mail3.ithnet.com ([217.64.64.7]:33438 "HELO
	heather-ng.ithnet.com") by vger.kernel.org with SMTP
	id S272810AbTHRUTX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 16:19:23 -0400
X-Sender-Authentication: SMTPafterPOP by <info@euro-tv.de> from 217.64.64.14
Date: Mon, 18 Aug 2003 22:19:21 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: green@namesys.com, marcelo@conectiva.com.br, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org, mason@suse.com
Subject: Re: 2.4.22-pre lockups (now decoded oops for pre10)
Message-Id: <20030818221921.7b96de86.skraw@ithnet.com>
In-Reply-To: <20030818150625.GW7862@dualathlon.random>
References: <20030813125509.360c58fb.skraw@ithnet.com>
	<Pine.LNX.4.44.0308131143570.4279-100000@localhost.localdomain>
	<20030813145940.GC26998@namesys.com>
	<20030813171224.2a13b97f.skraw@ithnet.com>
	<20030813153009.GA27209@namesys.com>
	<20030818150625.GW7862@dualathlon.random>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Aug 2003 17:06:25 +0200
Andrea Arcangeli <andrea@suse.de> wrote:

> an SMP kernel puts the double of the stress on the mem bus, so it might
> still be ram that went bad around the time you upgraded from 2.4.19. Or
> it maybe simply a buggy smp motherboard, or whatever.
> 
> Of course I can't be sure but we can't exclude it.

It is unlikely for bad ram to survive memtest for several hours.

Regards,
Stephan
