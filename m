Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281318AbRKEUnm>; Mon, 5 Nov 2001 15:43:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281325AbRKEUne>; Mon, 5 Nov 2001 15:43:34 -0500
Received: from mailout05.sul.t-online.com ([194.25.134.82]:62387 "EHLO
	mailout05.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S281318AbRKEUnZ>; Mon, 5 Nov 2001 15:43:25 -0500
Content-Type: text/plain; charset=US-ASCII
From: Tim Jansen <tim@tjansen.de>
To: Jonathan Lundell <jlundell@pobox.com>
Subject: Re: [PATCH] 2.5 PROPOSAL: Replacement for current /proc of shit.
Date: Mon, 5 Nov 2001 21:46:19 +0100
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E15zF9H-0000NL-00@wagner> <20011105111239.3403b162.rusty@rustcorp.com.au> <p05100316b80c6f3df6f3@[207.213.214.37]>
In-Reply-To: <p05100316b80c6f3df6f3@[207.213.214.37]>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <160qaQ-2523rUC@fmrl04.sul.t-online.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 05 November 2001 17:49, Jonathan Lundell wrote:
> I think of the tagged list of n-tuples as a kind of ASCII
> representation of a simple struct. One could of course create a
> general ASCII representation of a C struct, and no doubt it's been
> done innumerable times, but I don't think that helps in this
> application.

But how can you represent references with those lists? Try to model the 
content of /proc/bus/usb/devices with them.

bye...
