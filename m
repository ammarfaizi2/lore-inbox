Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263357AbRFPMzD>; Sat, 16 Jun 2001 08:55:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264620AbRFPMyo>; Sat, 16 Jun 2001 08:54:44 -0400
Received: from hera.cwi.nl ([192.16.191.8]:20872 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S263357AbRFPMyd>;
	Sat, 16 Jun 2001 08:54:33 -0400
Date: Sat, 16 Jun 2001 14:53:53 +0200 (MET DST)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200106161253.OAA311473.aeb@vlet.cwi.nl>
To: ddstreet@us.ibm.com, jgarzik@mandrakesoft.com
Subject: Re: ps2 keyboard filter hook
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> patch to allow other drivers to register with the PS/2 driver as 'filters'

> Didn't we just conclude a discussion here on linux-kernel, which said
> that patches which simply add hooks allowing proprietary extensions are
> not accepted into the kernel?

There is a certain need for this kind of patches.
I have seen similar stuff for the blind, or for disabled
people who for example can use only one hand.
Also for people who use a combined keyboard/barcode reader.
Hooks for drivers that do something special have other uses
than for proprietary extensions.

It is good to see what people want.
One of these centuries we must replace the present keyboard
and console stuff, probably by something very similar to
Vojtech's input device stuff, and we must make sure that
the new code is powerful enough to last for a few years again.

Andries
