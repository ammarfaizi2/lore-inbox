Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132561AbRDEQWB>; Thu, 5 Apr 2001 12:22:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131830AbRDEQVl>; Thu, 5 Apr 2001 12:21:41 -0400
Received: from virtualro.ic.ro ([194.102.78.138]:7945 "EHLO virtualro.ic.ro")
	by vger.kernel.org with ESMTP id <S132561AbRDEQVh>;
	Thu, 5 Apr 2001 12:21:37 -0400
Date: Thu, 5 Apr 2001 19:21:11 +0300 (EEST)
From: Jani Monoses <jani@virtualro.ic.ro>
To: linux-kernel@vger.kernel.org
Subject: PCI address space collision
Message-ID: <Pine.LNX.4.10.10104051917130.29169-100000@virtualro.ic.ro>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,
is this something to worry about ?

in dmesg:

PCI: Address space collision on region 9 of device VIA Technologies, Inc.
VT82C686 [Apollo Super ACPI] [8080:808f]

I know it might be unrelated with  ACPI being experimental but if the
kernel is compiled with ACPI instead of APM the machine (Presario 12XL300)
"cannot enter S5" when halting.
kernels 2.4.1 - 2.4.3
Thanks.

