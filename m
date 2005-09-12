Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750832AbVILNnW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750832AbVILNnW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 09:43:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750834AbVILNnW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 09:43:22 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:27089 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750832AbVILNnV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 09:43:21 -0400
Date: Mon, 12 Sep 2005 15:43:58 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Tom Rini <trini@kernel.crashing.org>
Cc: dwalker@mvista.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RT: Invert some TRACE_BUG_ON_LOCKED tests
Message-ID: <20050912134358.GA5033@elte.hu>
References: <1125691250.2709.2.camel@c-67-188-6-232.hsd1.ca.comcast.net> <20050902200856.GY3966@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050902200856.GY3966@smtp.west.cox.net>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Tom Rini <trini@kernel.crashing.org> wrote:

> With 2.6.13-rt4 I had to do the following in order to get my paired 
> down config booting on my x86 whitebox (defconfig works fine, after I 
> enable enet/8250_console/nfsroot).  Daniel Walker helped me trace this 
> down.
> 
> Signed-off-by: Tom Rini <trini@kernel.crashing.org>

thanks, applied.

	Ingo
