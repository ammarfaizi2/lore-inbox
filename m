Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261353AbTILJSs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 05:18:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261357AbTILJSr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 05:18:47 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:64240 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S261353AbTILJSr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 05:18:47 -0400
Date: Fri, 12 Sep 2003 11:18:41 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: khromy <khromy@lnuxlab.ath.cx>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: linux-2.6.0-test3 broken tdfxfb resolution
In-Reply-To: <20030912031152.GA4089@lnuxlab.ath.cx>
Message-ID: <Pine.GSO.4.21.0309121118120.2312-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Sep 2003, khromy wrote:
> Booting 2.6.0-test5 with video=tdfx:1024x768-8@85 doesn't set the 
> resolution to 1024x768..

This is not a new problem with 2.6.0-test5, is it?

s/tdfx/tdfxfb/

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

