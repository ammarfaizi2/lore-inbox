Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265075AbTFCP66 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 11:58:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265076AbTFCP66
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 11:58:58 -0400
Received: from cibs9.sns.it ([192.167.206.29]:17159 "EHLO cibs9.sns.it")
	by vger.kernel.org with ESMTP id S265075AbTFCP6y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 11:58:54 -0400
Date: Tue, 3 Jun 2003 18:12:16 +0200 (CEST)
From: venom@sns.it
To: "Randy.Dunlap" <rddunlap@osdl.org>
cc: andreas@xss.co.at, <alan@lxorguk.ukuu.org.uk>,
       <linux-kernel@vger.kernel.org>
Subject: Re: system clock speed too high?
In-Reply-To: <20030603084737.33a5f817.rddunlap@osdl.org>
Message-ID: <Pine.LNX.4.43.0306031809480.24895-100000@cibs9.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

USB  is disabled in BIOS and ACPI  is disabled too,
but the  problem persists.
It is even difficoult to type the keyb as fast
as it is on alll irqs.








On Tue, 3 Jun 2003, Randy.Dunlap wrote:

> Date: Tue, 3 Jun 2003 08:47:37 -0700
> From: Randy.Dunlap <rddunlap@osdl.org>
> To: venom@sns.it
> Cc: andreas@xss.co.at, alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
> Subject: Re: system clock speed too high?
>
>
> Hi,
>
> Did you check to see if USB is enabled in your BIOS setup?
> Nothing to do with Linux USB kernel support....
>
> ~Randy
>
> On Tue, 3 Jun 2003 17:43:42 +0200 (CEST) venom@sns.it wrote:
>
> |
> | No, I do not have USB enabled at all.
> | anyway I see exactly the same results, also if the problem could be somewhere
> | else.
> |
> | Luigi
> |
> | On Tue, 3 Jun 2003, Andreas Haumer wrote:
> |
> | > Date: Tue, 03 Jun 2003 17:38:09 +0200
> | > From: Andreas Haumer <andreas@xss.co.at>
> | > To: venom@sns.it
> | > Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
> | >      Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
> | > Subject: Re: system clock speed too high?
> | >
> | > -----BEGIN PGP SIGNED MESSAGE-----
> | > Hash: SHA1
> | >
> | > Hi!
> | >
> | > venom@sns.it wrote:
> | > > I reported this same problem for kernel 2.5.69/70 on pentiumIII with chipset
> | > > i810, but it seems the reports has been unnoticed.
> | > >
> | > > I replicated your tests with 2.5.70 without acpi, same results here.
> | > >
> | > Hm, do you have "USB legacy support" enabled on your
> | > system, too? Does the problem go away if you disable it?
> | >
> | > What motherboard and BIOS does your computer have (manufacturer,
> | > version numbers)?
> | >
> | > (This is a totally different chipset, so the problems
> | > might be completely unrelated)
> | >
> | > - - andreas
> | >
> | > - --
> | > Andreas Haumer                     | mailto:andreas@xss.co.at
> | > *x Software + Systeme              | http://www.xss.co.at/
> | > Karmarschgasse 51/2/20             | Tel: +43-1-6060114-0
> | > A-1100 Vienna, Austria             | Fax: +43-1-6060114-71
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

