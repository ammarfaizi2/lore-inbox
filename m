Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261921AbUL0QDh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261921AbUL0QDh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 11:03:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261920AbUL0QDh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 11:03:37 -0500
Received: from hermes.domdv.de ([193.102.202.1]:4363 "EHLO hermes.domdv.de")
	by vger.kernel.org with ESMTP id S261914AbUL0QCF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 11:02:05 -0500
Message-ID: <41D031FD.9000601@domdv.de>
Date: Mon, 27 Dec 2004 17:02:05 +0100
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.10-ac1
References: <1104103881.16545.2.camel@localhost.localdomain>	 <58cb370e04122616577e1bd33@mail.gmail.com> <41CF649E.20409@domdv.de>	 <58cb370e041226174019e75e23@mail.gmail.com>	 <8783be660412270645717b89d1@mail.gmail.com>	 <58cb370e0412270738fbc045c@mail.gmail.com> <41D02EEC.4090000@domdv.de> <58cb370e04122707544be6d600@mail.gmail.com>
In-Reply-To: <58cb370e04122707544be6d600@mail.gmail.com>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> Ah, so the problem only affects native PCI IRQs.
> Is it possible that it is a buggy IDE host driver not a generic IDE problem?

No, I tried 3 different pci cards requiring three different drivers. The 
problem appeared with all three the same way.
-- 
Andreas Steinmetz                       SPAMmers use robotrap@domdv.de
