Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316835AbSGBQQX>; Tue, 2 Jul 2002 12:16:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316836AbSGBQQW>; Tue, 2 Jul 2002 12:16:22 -0400
Received: from cibs9.sns.it ([192.167.206.29]:22534 "EHLO cibs9.sns.it")
	by vger.kernel.org with ESMTP id <S316835AbSGBQQT>;
	Tue, 2 Jul 2002 12:16:19 -0400
Date: Tue, 2 Jul 2002 18:05:04 +0200 (CEST)
From: venom@sns.it
To: "J.A. Magallon" <jamagallon@able.es>
cc: Tom Rini <trini@kernel.crashing.org>, Bill Davidsen <davidsen@tmr.com>,
       Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [OKS] O(1) scheduler in 2.4
In-Reply-To: <20020701234432.GC1697@werewolf.able.es>
Message-ID: <Pine.LNX.4.43.0207021802260.29588-100000@cibs9.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Jul 2002, J.A. Magallon wrote:

> Date: Tue, 2 Jul 2002 01:44:32 +0200
> From: J.A. Magallon <jamagallon@able.es>
> To: Tom Rini <trini@kernel.crashing.org>
> Cc: Bill Davidsen <davidsen@tmr.com>,
>      Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
> Subject: Re: [OKS] O(1) scheduler in 2.4
>
>
> On 2002.07.01 Tom Rini wrote:
> >On Mon, Jul 01, 2002 at 01:52:54PM -0400, Bill Davidsen wrote:
> >
> >> What's the issue?
> >
> >a) We're at 2.4.19-rc1 right now.  It would be horribly
> >counterproductive to put O(1) in right now.
>
> .20-pre1 would be a good start, but my hope is that this reserved for
> the vm updates from -aa ;).

If I am not wrong in the AA tree the O(1) scheduler has been merged, so
there is an opportunity do update booth ;).


>
> >c) I also suspect that it hasn't been as widley tested on !x86 as the
> >stuff currently in 2.4.  And again, 2.4 is the stable tree.
> >
>
Well, I think it has been supposed to high quality test, also if the
tester basis was quite reduced...

