Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268269AbRGWPgD>; Mon, 23 Jul 2001 11:36:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268268AbRGWPfx>; Mon, 23 Jul 2001 11:35:53 -0400
Received: from Expansa.sns.it ([192.167.206.189]:18700 "EHLO Expansa.sns.it")
	by vger.kernel.org with ESMTP id <S268269AbRGWPfn>;
	Mon, 23 Jul 2001 11:35:43 -0400
Date: Mon, 23 Jul 2001 17:35:42 +0200 (CEST)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: Sir Woody Hackswell <woody@hackswell.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Athlon and 2.4.x not booting
In-Reply-To: <Pine.LNX.4.33.0107231120001.8449-100000@hackswell.com>
Message-ID: <Pine.LNX.4.33.0107231731010.15002-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


You are not the first with this problem, athlon optimizzations try to get
the best from your FSB, but many chipset are not working properly.
Just loock at some lkml archive for the many threads about this topic.

Luigi



On Mon, 23 Jul 2001, Sir Woody Hackswell wrote:

> Hello, all!
>
> I have RedHat7.1, and an athlon 1.0GHz on an ASUS with ALi chipset (ASUS
> A7A266 DDR), and I've been having problems getting my kernel configured
> properly.  I've tried using the gcc 2.96 that comes with RH7.1 and also some
> rpms of gcc 3.0 to no success.
>
> If I compile 2.4.x as a K6-III, my machine will boot fine, but when I try to
> optimize the kernel and compile it as Athlon, I compile fine with no
> warnings, but when I install the kernel and boot, I decompresses the kernel
> and hangs. No errors, no crash dump - nothing.
>
> Is there a problem with my hardware?  Or is this a known problem?  Any way
> to turn on more debugging?  Thanks!
>
> -Woody!
>
>
> -----
> There is no OS but Linux,
> and Torvalds is its prophet.
> (Peace be upon His soul)
>
> Sir.Woody@Hackswell.com       http://sir.woody.hackswell.com
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

