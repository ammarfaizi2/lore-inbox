Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292574AbSBTXGf>; Wed, 20 Feb 2002 18:06:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292573AbSBTXGZ>; Wed, 20 Feb 2002 18:06:25 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:42254 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S292572AbSBTXGQ>; Wed, 20 Feb 2002 18:06:16 -0500
Subject: Re: question about interrupt
To: aobai@hotmail.com (Bai Ao)
Date: Wed, 20 Feb 2002 23:20:34 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <F16cMzfoV1qdiixjnzi00010353@hotmail.com> from "Bai Ao" at Feb 20, 2002 09:19:37 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16dg2N-00055D-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> But if I compile 2.4.17(18) kernels, I will have such thing in dmesg:
> spurious 8259A interrupt: IRQ7.

Build them without local APIC support - see if that cures it
