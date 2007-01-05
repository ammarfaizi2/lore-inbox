Return-Path: <linux-kernel-owner+w=401wt.eu-S965117AbXAEJgn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965117AbXAEJgn (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 04:36:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965112AbXAEJgn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 04:36:43 -0500
Received: from vervifontaine.sonytel.be ([80.88.33.193]:51172 "EHLO
	vervifontaine.sonycom.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S965117AbXAEJgm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 04:36:42 -0500
Date: Fri, 5 Jan 2007 10:36:40 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Adrian Bunk <bunk@stusta.de>
cc: adaplas@pol.net, Linux/PPC Development <linuxppc-dev@ozlabs.org>,
       Paul Mackerras <paulus@samba.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [RFC: 2.6 patch] remove the broken FB_S3TRIO driver
In-Reply-To: <20070104185403.GK20714@stusta.de>
Message-ID: <Pine.LNX.4.62.0701051036170.17589@pademelon.sonytel.be>
References: <20070104185403.GK20714@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Jan 2007, Adrian Bunk wrote:
> The FB_S3TRIO driver:
> - has been marked as BROKEN for more than two years and
> - is still marked as BROKEN.
> 
> Drivers that had been marked as BROKEN for such a long time seem to be
> unlikely to be revived in the forseeable future.

As there's a new generic S3Trio driver in the works...

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
