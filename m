Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268156AbTGIKWe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 06:22:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268160AbTGIKVd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 06:21:33 -0400
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:30427 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id S268149AbTGIKVR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 06:21:17 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>
Subject: Re: [PATCH] O3int interactivity for 2.5.74-mm2
Date: Wed, 9 Jul 2003 20:37:06 +1000
User-Agent: KMail/1.5.2
Cc: linux-kernel@vger.kernel.org, Mike Galbraith <efault@gmx.de>,
       Nick Sanders <sandersn@btinternet.com>, Andrew Morton <akpm@osdl.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
References: <200307070317.11246.kernel@kolivas.org> <200307092022.07723.kernel@kolivas.org> <200307091223.52040.m.c.p@wolk-project.de>
In-Reply-To: <200307091223.52040.m.c.p@wolk-project.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307092037.06362.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Jul 2003 20:23, Marc-Christian Petersen wrote:
> On Wednesday 09 July 2003 12:22, Con Kolivas wrote:
>
> Hi Con,
>
> > > Now I am running 2.5.74-mm3, xterm needs about 5 seconds to open up,
> > > but the whole system is again in a snail mode. XMMS does not skip.
> >
> > Well this is no different to the O3 patch on mm2 so it's no surprise :)
>
> sure, but wait up the next mail. I forgot to mention that I do "-j2" now
> and not -j8 or -j16 ;)
>
> ciao, Marc

You saying this is somehow slower than before?

Ciao Marc,
Con

