Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261882AbUL0O50@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261882AbUL0O50 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 09:57:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261886AbUL0O50
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 09:57:26 -0500
Received: from hermes.domdv.de ([193.102.202.1]:42250 "EHLO hermes.domdv.de")
	by vger.kernel.org with ESMTP id S261882AbUL0O5Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 09:57:24 -0500
Message-ID: <41D022D1.8060107@domdv.de>
Date: Mon, 27 Dec 2004 15:57:21 +0100
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Rafael J. Wysocki" <rjw@sisk.pl>
CC: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.10-ac1
References: <1104103881.16545.2.camel@localhost.localdomain> <58cb370e04122616577e1bd33@mail.gmail.com> <41CF649E.20409@domdv.de> <200412271536.29783.rjw@sisk.pl>
In-Reply-To: <200412271536.29783.rjw@sisk.pl>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rafael J. Wysocki wrote:
> AFAIK, you can't disable the io-apic on these boards.

Hmm, boot with noapic and /proc/interrupts only shows XT-PIC entries.

-- 
Andreas Steinmetz                       SPAMmers use robotrap@domdv.de
