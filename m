Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271938AbTGYG73 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 02:59:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271939AbTGYG73
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 02:59:29 -0400
Received: from webhosting.rdsbv.ro ([213.157.185.164]:44002 "EHLO
	hosting.rdsbv.ro") by vger.kernel.org with ESMTP id S271938AbTGYG7U
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 02:59:20 -0400
Date: Fri, 25 Jul 2003 10:14:28 +0300 (EEST)
From: Catalin BOIE <util@deuroconsult.ro>
X-X-Sender: util@hosting.rdsbv.ro
To: Manjunathan Padua Yellappan <manjunathan_py@yahoo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: kernel 2.6.0-test1 refuses to boot on a PC with AMD Athlon XP
 1800+ (another one)
In-Reply-To: <20030725065507.26549.qmail@web14208.mail.yahoo.com>
Message-ID: <Pine.LNX.4.53.0307251012230.1571@hosting.rdsbv.ro>
References: <20030725065507.26549.qmail@web14208.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi Folks,
Hi!

> I compiled the latest version of the kernel
> 2.6.0-test1.
>
> I was able to successfully build the bzImage , but I
> am not able to boot using this new kernel.
> My Machine just stops after displaying the following
>
>     "Uncompressing Linux... Ok, booting the kernel "
>
> Nothing happens after this message, it just hangs

Exactly same problem here, two machines. So this is making us 3. :)

Athlon XP 1700+, Epox motherboard, cooler just replaced.
2.4.21 works perfectly.

The other one is an Intel 7505vb2, 2 Xeon ht cpus at 2.4, 1 GB ram.

Any ideas?
Thanks!


>
> Please assist me in solving this, I am very keen on to
> testing this kernel.
>
> Configuration of my machine :
> CPU  AMD Athlon 1800+ XP
> Motherboard ASUS KT266
> RAM  256MB
> HDD  20GB
> with ATI Rage128 AGP card
>
> Thanks in advance.
> Manjunathan Padua Y
>
> Note: Please cc your responses to this email id.
>
>
> __________________________________
> Do you Yahoo!?
> Yahoo! SiteBuilder - Free, easy-to-use web site design software
> http://sitebuilder.yahoo.com
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

---
Catalin(ux) BOIE
catab@deuroconsult.ro
