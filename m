Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264654AbTANPtK>; Tue, 14 Jan 2003 10:49:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264686AbTANPtJ>; Tue, 14 Jan 2003 10:49:09 -0500
Received: from pD9E103E1.dip.t-dialin.net ([217.225.3.225]:65260 "EHLO fefe.de")
	by vger.kernel.org with ESMTP id <S264654AbTANPrz>;
	Tue, 14 Jan 2003 10:47:55 -0500
Date: Tue, 14 Jan 2003 05:09:01 +0100
From: Felix von Leitner <felix-linuxkernel@fefe.de>
To: linux-kernel@vger.kernel.org
Subject: Re: usb broken in 2.5?
Message-ID: <20030114040901.GA11545@fefe.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20030114025245.GA1175@fefe.de> <20030114024435.GA1293@fefe.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030114025245.GA1175@fefe.de> <20030114024435.GA1293@fefe.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thus spake Felix von Leitner (felix-linuxkernel@fefe.de):
> In 2.5.57 USB does not work.

[...]

> Any ideas?  On 2.5 and WOLK the kernel also says that no IRQ is know and
> that it is using ACPI to route the IRQs.

It turned out to be an ACPI issue.

Darn.  Not AGAIN!
ACPI is the biggest pile of crap to poison this earth.
I have yet to see it "just work".

I'll turn it off for good now, sorry for wasting your time with this.
