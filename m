Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263840AbTLARBQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Dec 2003 12:01:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263855AbTLARBQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Dec 2003 12:01:16 -0500
Received: from dodge.jordet.nu ([217.13.8.142]:42138 "EHLO dodge.hybel")
	by vger.kernel.org with ESMTP id S263840AbTLARBO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Dec 2003 12:01:14 -0500
Subject: Re: ACPI does not power off the machine automatically
From: Stian Jordet <liste@jordet.nu>
To: Boszormenyi Zoltan <zboszor@freemail.hu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3FCAF390.10202@freemail.hu>
References: <3FCAF390.10202@freemail.hu>
Content-Type: text/plain
Message-Id: <1070298069.13093.3.camel@chevrolet.hybel>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 01 Dec 2003 18:01:09 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

man, 01.12.2003 kl. 08.53 skrev Boszormenyi Zoltan:
> Hi,
> 
> I have a n ABit BP6 board with 2 Celeron/400MHz with the latest
> released version RU (beta) BIOS, it was released in 2000.
> 
> I am running 2.6.0-test10-mm1 at present
> and it does not power off the machine. It writes
> 
> acpi_power_off called
> 
> at the end and stops there. But when I press Alt+SysRQ+o,
> it switches off. 1 out of (maybe) 50 occasions, the machine
> can switch itself off automatically.

I have the same problems on two different smp motherboards here. Works
fine when booting with apm=power-off, though.

Best regards,
Stian

