Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268080AbUIKK0V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268080AbUIKK0V (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 06:26:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268081AbUIKK0V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 06:26:21 -0400
Received: from aun.it.uu.se ([130.238.12.36]:4590 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S268080AbUIKK0M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 06:26:12 -0400
Date: Sat, 11 Sep 2004 12:26:00 +0200 (MEST)
Message-Id: <200409111026.i8BAQ0D6012935@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: linux-kernel@vger.kernel.org, sashak@smlink.com, tytso@mit.edu
Subject: Re: GPL source code for Smart USB 56 modem (includes ALSA AC97 patch)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Sep 2004 19:51:04 +0300, SashaK <sashak@smlink.com> wrote:
>Theodore Ts'o <tytso@mit.edu> wrote:
>
>> The good news is that there a completely GPL'ed, source-complete
>> driver already in the 2.6 kernel, sound/pci/intel8x0m.c, which will
>> work with  the user-mode daemon found in the smlink.com distribution.
>> This driver doesn't have all of the functionality of slamr driver
>> (which requires the propietary, binary-only object file) --- most
>> notably, ATM1 doesn't work when using the completely open-source
>> intl8x0m driver.
>
>Those functionality limitations in open source modem drivers are just
>"unimplemented yet" stuff. The final goal is to replace proprietary
>slamr driver completely.

I hope you succeed with open-sourcing all of slmodem's driver
code. My Targa Athlon64 laptop has the AMR thingy and the
32-bit x86 binary only slmodem driver prevents me from using
the modem while running a 64-bit kernel.

/Mikael
