Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268065AbTGIK0z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 06:26:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268110AbTGIK0y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 06:26:54 -0400
Received: from lindsey.linux-systeme.com ([80.190.48.67]:11014 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S268065AbTGIK0v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 06:26:51 -0400
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: Con Kolivas <kernel@kolivas.org>, Zwane Mwaikambo <zwane@arm.linux.org.uk>
Subject: Re: [PATCH] O3int interactivity for 2.5.74-mm2
Date: Wed, 9 Jul 2003 12:40:20 +0200
User-Agent: KMail/1.5.2
Cc: linux-kernel@vger.kernel.org, Mike Galbraith <efault@gmx.de>,
       Nick Sanders <sandersn@btinternet.com>, Andrew Morton <akpm@osdl.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
References: <200307070317.11246.kernel@kolivas.org> <200307091223.52040.m.c.p@wolk-project.de> <200307092037.06362.kernel@kolivas.org>
In-Reply-To: <200307092037.06362.kernel@kolivas.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200307091239.22893.m.c.p@wolk-project.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 09 July 2003 12:37, Con Kolivas wrote:

Hi Con,

> > > > Now I am running 2.5.74-mm3, xterm needs about 5 seconds to open up,
> > > > but the whole system is again in a snail mode. XMMS does not skip.
> > > Well this is no different to the O3 patch on mm2 so it's no surprise :)
> > sure, but wait up the next mail. I forgot to mention that I do "-j2" now
> > and not -j8 or -j16 ;)

> You saying this is somehow slower than before?
No. Where did I say that? :)

recall: I do "-j2" now and not "-j8/-j16" like before in my previous report.

There is no difference with -j8/-j16 comparing .74-mm2 + O3int and .74-mm3

ciao, Marc

