Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261786AbTEMQ37 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 12:29:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261790AbTEMQ37
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 12:29:59 -0400
Received: from dodge.jordet.nu ([217.13.8.142]:59661 "EHLO dodge.hybel")
	by vger.kernel.org with ESMTP id S261786AbTEMQ3W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 12:29:22 -0400
Subject: Re: [Bug 712] New: USB device not accepting new address.
From: Stian Jordet <liste@jordet.nu>
To: Andrei Ivanov <andrei.ivanov@ines.ro>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.50L0.0305131936010.4725-100000@webdev.ines.ro>
References: <24740000.1052833661@[10.10.2.4]>
	 <1052842466.20418.0.camel@chevrolet.hybel>
	 <Pine.LNX.4.50L0.0305131936010.4725-100000@webdev.ines.ro>
Content-Type: text/plain
Message-Id: <1052844145.20418.3.camel@chevrolet.hybel>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.3 (Preview Release)
Date: 13 May 2003 18:42:25 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

tir, 13.05.2003 kl. 18.37 skrev Andrei Ivanov:
> The messages are almost, if not identical to what I get, and my USB mouse
> works only if I replug it. I tried it with or without ACPI, with or
> without local apic, and it didn't work. Last time it worked was in
> 2.5.68-mm3... 
> 
> See: http://marc.theaimsgroup.com/?l=linux-kernel&m=105221493201587&w=2

They are also identical to my messages :) USB was working perfectly with
acpi untill 2.5.69, then it suddenly stopped working, and I have to boot
with acpi=off :(

There seems to be many USB/ACPI problems, but few of them started with
2.5.69. Just yours, Dave's and my problem so far...

Best regards,
Stian

