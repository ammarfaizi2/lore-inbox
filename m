Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965130AbWJBVNZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965130AbWJBVNZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 17:13:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965233AbWJBVNZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 17:13:25 -0400
Received: from smtp.osdl.org ([65.172.181.4]:55480 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965130AbWJBVNY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 17:13:24 -0400
Date: Mon, 2 Oct 2006 14:12:53 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: Ingo Molnar <mingo@elte.hu>, David Howells <dhowells@redhat.com>,
       Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org, Dmitry Torokhov <dtor@mail.ru>,
       Greg KH <greg@kroah.com>, David Brownell <david-b@pacbell.net>,
       Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 3/3] IRQ: Maintain regs pointer globally rather than
 passing to IRQ handlers
In-Reply-To: <20061002140121.f588b463.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0610021412200.3952@g5.osdl.org>
References: <20061002162049.17763.39576.stgit@warthog.cambridge.redhat.com>
 <20061002162053.17763.26032.stgit@warthog.cambridge.redhat.com>
 <20061002132116.2663d7a3.akpm@osdl.org> <20061002201836.GB31365@elte.hu>
 <Pine.LNX.4.64.0610021349090.3952@g5.osdl.org> <20061002140121.f588b463.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 2 Oct 2006, Andrew Morton wrote:
> 
> Whimper.   Later in the week, please.

Sure. Somebody send me a (tested) version that works against pure -rc1, 
and we're set to go.

		Linus
