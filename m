Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268919AbTBSOjP>; Wed, 19 Feb 2003 09:39:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268920AbTBSOjP>; Wed, 19 Feb 2003 09:39:15 -0500
Received: from p0005.as-l043.contactel.cz ([194.108.242.5]:29685 "EHLO
	SnowWhite.janik.cz") by vger.kernel.org with ESMTP
	id <S268919AbTBSOjO> convert rfc822-to-8bit; Wed, 19 Feb 2003 09:39:14 -0500
To: David Lang <david.lang@digitalinsight.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: openbkweb-0.0
References: <Pine.LNX.4.44.0302181427440.8963-100000@dlang.diginsite.com>
From: Pavel@Janik.cz (Pavel =?iso-8859-2?q?Jan=EDk?=)
X-Face: $"d&^B_IKlTHX!y2d,3;grhwjOBqOli]LV`6d]58%5'x/kBd7.MO&n3bJ@Zkf&RfBu|^qL+
 ?/Re{MpTqanXS2'~Qp'J2p^M7uM:zp[1Xq#{|C!*'&NvCC[9!|=>#qHqIhroq_S"MH8nSH+d^9*BF:
 iHiAs(t(~b#1.{w.d[=Z
Date: Wed, 19 Feb 2003 09:31:47 +0100
In-Reply-To: <Pine.LNX.4.44.0302181427440.8963-100000@dlang.diginsite.com> (David
 Lang's message of "Tue, 18 Feb 2003 14:34:42 -0800 (PST)")
Message-ID: <m3d6lopt70.fsf@Janik.cz>
User-Agent: Gnus/5.090008 (Oort Gnus v0.08) Emacs/21.3.50
 (i386-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Cc: list shortened.]

   From: David Lang <david.lang@digitalinsight.com>
   Date: Tue, 18 Feb 2003 14:34:42 -0800 (PST)

   > Ok, it sounds like we have the following resources available for getting
   > the kernel source

[...]

   > This isn't enough for people so will adding read-only CVS access to the
   > tree itself be enough?

This will be enough for people who want to have usual access to the Linux
kernel source repository. It won't satisfy people who do not like the
approach of using non-free software for developing the Linux kernel.
-- 
Pavel Janík

/* Host controller interrupts must not be running while calling this
 * function or the penguins will get angry. */
                  -- 2.2.16 drivers/usb/ohci.c
