Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261551AbUDSRFP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 13:05:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261582AbUDSRFP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 13:05:15 -0400
Received: from mail.cs.tu-berlin.de ([130.149.17.13]:17352 "EHLO
	mail.cs.tu-berlin.de") by vger.kernel.org with ESMTP
	id S261551AbUDSRFC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 13:05:02 -0400
Message-Id: <200404191659.i3JGxv03006802@phobos.cs.tu-berlin.de>
To: linux-kernel@vger.kernel.org
From: Peter Daum <gator@cs.tu-berlin.de>
Subject: Re: Total freeze switching X->fb (matrox)
Date: Mon, 19 Apr 2004 15:57:06 +0200
References: <1JtQg-3hH-7@gated-at.bofh.it> <1JtQj-3hH-19@gated-at.bofh.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii;
Content-Transfer-Encoding: 7bit
In-Reply-To: <1JtQj-3hH-19@gated-at.bofh.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tomasz Torcz wrote:

> On Sat, Apr 10, 2004 at 06:37:58PM +0200, legion wrote:
>
>> The problem is: framebuffer (matroxfb) works fine, X (xfree 4.3 or Xorg
>> 6.7) works fine, but sometimes when i hit "ctrl alt F1" for switching
>> on the console, the system freeze.
>
>
>
>> video card: Matrox G400 DH on nvidia nforce2 motherboard
>> kernel: vanilla 2.6.3+ (nforce2 agp/matrox drm/matroxfb support)
>> X server: Xfree 4.3.0 or Xorg r6.7 using "mga" driver
>
>
>
>  It also happens with Matrox G550 on VIA board.
> All 2.6.x kernels. XFree86 4.3 and 4.4.


Same thing here with Asus P4-PE board.
No matroxfb here, so this doesn't seem to be the problem.
I guess it's more an issue with agpart/drm.

