Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316822AbSGBQc5>; Tue, 2 Jul 2002 12:32:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316823AbSGBQc4>; Tue, 2 Jul 2002 12:32:56 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:18704 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S316822AbSGBQc4>; Tue, 2 Jul 2002 12:32:56 -0400
Date: Tue, 2 Jul 2002 12:29:36 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: "David S. Miller" <davem@redhat.com>
cc: alex@PolesApart.wox.org, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: 2.4.19-pre10-ac2 bug in page_alloc.c:131
In-Reply-To: <20020624.080409.79615643.davem@redhat.com>
Message-ID: <Pine.LNX.3.96.1020702120824.28259A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Jun 2002, David S. Miller wrote:

> This has to do with facts, not opinions.  Since we lack the source to
> their drivers, we have no idea if some bug in their driver is
> scribbling over (ie. corrupting) memory.  It is therefore an unknown
> which makes it a waste of time for us to pursue the bug report.

By that logic if source is freely available the kernel should not be
marked tainted, even if the source license is not GPL, as in you can get
it and use it to debug, but the license is something like BSD, or the
Kermit limited redistribution, etc.

I'm asking in general, not about just one particular binary-only driver.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

