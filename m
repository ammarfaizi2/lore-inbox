Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265784AbUA2LgF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 06:36:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265789AbUA2LgF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 06:36:05 -0500
Received: from webhosting.rdsbv.ro ([213.157.185.164]:34019 "EHLO
	hosting.rdsbv.ro") by vger.kernel.org with ESMTP id S265784AbUA2Lf7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 06:35:59 -0500
Date: Thu, 29 Jan 2004 13:35:52 +0200 (EET)
From: Catalin BOIE <util@deuroconsult.ro>
X-X-Sender: util@hosting.rdsbv.ro
To: Nick Piggin <piggin@cyberone.com.au>
cc: linux-kernel@vger.kernel.org, linux-smp@vger.kernel.org
Subject: Re: 2.6.2-rc2 Interactivity problems with SMP + HT
In-Reply-To: <4018E524.8060200@cyberone.com.au>
Message-ID: <Pine.LNX.4.58.0401291332030.23046@hosting.rdsbv.ro>
References: <Pine.LNX.4.58.0401291239320.23046@hosting.rdsbv.ro>
 <4018E524.8060200@cyberone.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >Do you know why this can happen?
> >
> >
>
> There haven't been many scheduler changes there recently so
> maybe its something else.
>
> But you could try the latest -mm kernels. They have some
> Hyperthreading work in them (you need to enable CONFIG_SCHED_SMT).

It's a production server and now, after the crash I'm a little worried
about side effects. I have to wait some time till I play with it again.

Thank you very much, Nick.

>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

---
Catalin(ux) BOIE
catab@deuroconsult.ro
