Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263176AbTHVPrt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 11:47:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263174AbTHVPrt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 11:47:49 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:27024
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S263185AbTHVPrp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 11:47:45 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Wiktor Wodecki <wodecki@gmx.de>
Subject: Re: [PATCH]O18int
Date: Sat, 23 Aug 2003 01:54:36 +1000
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org
References: <200308222231.25059.kernel@kolivas.org> <200308230103.19724.kernel@kolivas.org> <20030822154639.GA711@gmx.de>
In-Reply-To: <20030822154639.GA711@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308230154.36357.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 23 August 2003 01:46, Wiktor Wodecki wrote:
> On Sat, Aug 23, 2003 at 01:03:19AM +1000, Con Kolivas wrote:
> > > > There it is again; the reference to darn O10. Hrm. One question
> > > > before your holiday; your O10 kernel is it the same kernel tree or a
> > > > different/newere one? I'm looking to blame something else here I know
> > > > but I need to know; this just doesn't hold with any testing here.
> > >
> > > well, I run O10 on top of test2, since I didn't need any patches from
> > > test3 I didn't rediff it.
> >
> > So O18 is also on test2?
>
> Okay, I applied O18 on top of test2 now. Xmms works as a charm,
> programm start is still slow while doing an tar xf linuxtest2.tar.
> Already open xterm's (one with mutt) react a bit in-interactive (I spawn
> vi to write this email and a :w takes 5 seconds). It is nonetheless
> worse than O10, sorry to say that.

Ok, but none of that weird starvation and massive load and skipping audio. 
Interesting. At least it's clear now that all is _not_ just my patches. 
Thanks for testing.

Con

