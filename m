Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317436AbSG1X3d>; Sun, 28 Jul 2002 19:29:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317440AbSG1X3d>; Sun, 28 Jul 2002 19:29:33 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:7811 "EHLO
	opus.bloom.county") by vger.kernel.org with ESMTP
	id <S317436AbSG1X3c>; Sun, 28 Jul 2002 19:29:32 -0400
Date: Sun, 28 Jul 2002 16:32:42 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Greg Banks <gnb@alphalink.com.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [MOAN] CONFIG_SERIAL_CONSOLE
Message-ID: <20020728233242.GB9873@opus.bloom.county>
References: <3D43D3ED.32D803BB@alphalink.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D43D3ED.32D803BB@alphalink.com.au>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 28, 2002 at 09:22:21PM +1000, Greg Banks wrote:

> Thanks to Russell for pointing out a problem I had not been aware of.
[snip]
>     CONFIG_BUSMOUSE
>     	drivers/char/Config.in:116
>     	arch/ppc/config.in:384
[snip]
>     CONFIG_CD_NO_IDESCSI
>     	arch/ppc/config.in:469
>     	arch/ppc/config.in:506
[snip]
>     CONFIG_FB
>     	drivers/video/Config.in:8
>     	arch/ppc/config.in:382

Fixed (or rather, fixing right now..).

Hopefully Paul will push these to Linus next time he syncs up.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
