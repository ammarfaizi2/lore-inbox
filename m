Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262431AbTFBPP5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 11:15:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262451AbTFBPP5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 11:15:57 -0400
Received: from chaos.analogic.com ([204.178.40.224]:15757 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262431AbTFBPPx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 11:15:53 -0400
Date: Mon, 2 Jun 2003 11:31:14 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Mike Dresser <mdresser_l@windsormachine.com>
cc: Linux kernel <linux-kernel@vger.kernel.org>, linux-smp@vger.kernel.org
Subject: Re: Hyper-threading
In-Reply-To: <Pine.LNX.4.33.0306021052450.31561-100000@router.windsormachine.com>
Message-ID: <Pine.LNX.4.53.0306021124570.16188@chaos>
References: <Pine.LNX.4.33.0306021052450.31561-100000@router.windsormachine.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Jun 2003, Mike Dresser wrote:

>
>
> On Sun, 1 Jun 2003, Richard B. Johnson wrote:
>
> > CPU0: Intel(R) Pentium(R) 4 CPU 2.66GHz stepping 07
>
> I wouldn't worry about hyperthreading too much anyways, seeing as how this
> cpu doesn't support it anyways.
>
> Mike
>

Well it is supposed to. It's a pentium 4 Xeon. If it doesn't
support it, ether the CPU or the motherboard are broken.
I'll bet on the motherboard.
Look further up the dmesg output and you'll see XEON(tm) and
2 CPUs total.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.

