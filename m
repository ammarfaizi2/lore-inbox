Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264474AbTK0KyY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Nov 2003 05:54:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264476AbTK0KyY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Nov 2003 05:54:24 -0500
Received: from webhosting.rdsbv.ro ([213.157.185.164]:57566 "EHLO
	hosting.rdsbv.ro") by vger.kernel.org with ESMTP id S264474AbTK0KyX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Nov 2003 05:54:23 -0500
Date: Thu, 27 Nov 2003 12:54:10 +0200 (EET)
From: Catalin BOIE <util@deuroconsult.ro>
X-X-Sender: util@hosting.rdsbv.ro
To: SVR Anand <anand@eis.iisc.ernet.in>
cc: linux-kernel@vger.kernel.org
Subject: Re: kernel development in kernel
In-Reply-To: <200311271045.QAA10220@eis.iisc.ernet.in>
Message-ID: <Pine.LNX.4.58.0311271252550.1341@hosting.rdsbv.ro>
References: <200311271045.QAA10220@eis.iisc.ernet.in>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi,
Hi.

> I am thinking of developing kernel development environment which provides
> a pseudo shell, and runtime environment that resides in the kernel itself.
> The goal of this exercise is to create an environment that simplifies the
> kernel programming effort by creating a virtual user area that sits above
> kernel but within the kernel protected region. The runtime environment should
> provide all that is necesary to build and debug kernel image as if it is a
> C program.
>
> My wish is that kernel development should eventually become somewhat like
> a C development, if not completely, partially, so that the idea takes the
> lead over spending lots of time in getting a code work in kernel.
>
> Sure, too much of hand waving without any substance went in my mail. If you
> can let me know the worthwhileness of the effort itself I will be motivated
> to slog.
>
> Thanks for your time.

I think you describe uml (http://user-mode-linux.sourceforge.net/).

>
> Anand
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

---
Catalin(ux) BOIE
catab@deuroconsult.ro
