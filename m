Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261530AbUFQS12@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261530AbUFQS12 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 14:27:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261426AbUFQS12
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 14:27:28 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:62468 "EHLO
	kerberos.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S261530AbUFQS1C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 14:27:02 -0400
Subject: Re: ACPI vs. APM - Which is better for desktop and why?
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Justin Piszcz <jpiszcz@lucidpixels.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.60.0406171308080.17891@p500>
References: <Pine.LNX.4.60.0406171308080.17891@p500>
Content-Type: text/plain
Date: Thu, 17 Jun 2004 20:26:55 +0200
Message-Id: <1087496815.1690.2.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.9.1 (1.5.9.1-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-06-17 at 13:10 -0400, Justin Piszcz wrote:
> I have enabled ACPI on my Dell GX1 (Pentium 3/500MHZ) machine and disabled 
> APM, however, what are the benefits of using ACPI over APM?

Well, I can't tell for sure... ACPI is supposed to offer better power
management and battery usage for laptops, while being more flexible than
APM.

The truth is that on my laptop, both work equally well but since ACPI is
still less mature than APM, I chose to use ACPI in order to test it and
helping in its future development.

> 
> I am using Kernel 2.6.7
> 
> I see ACPI eats up an IRQ and does not share it:

I wouldn't mind about IRQ's...

