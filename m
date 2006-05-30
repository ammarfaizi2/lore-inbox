Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751568AbWE3BaN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751568AbWE3BaN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 21:30:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751549AbWE3BaL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 21:30:11 -0400
Received: from smtp.osdl.org ([65.172.181.4]:38336 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751573AbWE3BaC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 21:30:02 -0400
Date: Mon, 29 May 2006 18:34:16 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, arjan@infradead.org
Subject: Re: [patch 18/61] lock validator: irqtrace: core
Message-Id: <20060529183416.d1ab7d82.akpm@osdl.org>
In-Reply-To: <20060529212432.GR3155@elte.hu>
References: <20060529212109.GA2058@elte.hu>
	<20060529212432.GR3155@elte.hu>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 May 2006 23:24:32 +0200
Ingo Molnar <mingo@elte.hu> wrote:

> accurate hard-IRQ-flags state tracing. This allows us to attach
> extra functionality to IRQ flags on/off events (such as trace-on/off).

That's a fairly skimpy description of some fairly substantial new
infrastructure.

