Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264500AbUJETfA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264500AbUJETfA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 15:35:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263770AbUJETfA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 15:35:00 -0400
Received: from witte.sonytel.be ([80.88.33.193]:16877 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S264500AbUJETe5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 15:34:57 -0400
Date: Tue, 5 Oct 2004 21:34:27 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Hanna Linder <hannal@us.ibm.com>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       kernel-janitors@lists.osdl.org, Greg Kroah-Hartman <greg@kroah.com>,
       Roman Zippel <zippel@linux-m68k.org>
Subject: Re: [PATCH 2.6] hades-pci.c: replace pci_find_device with pci_get_device
In-Reply-To: <280230000.1096924777@w-hlinder.beaverton.ibm.com>
Message-ID: <Pine.GSO.4.61.0410052134120.9981@waterleaf.sonytel.be>
References: <280230000.1096924777@w-hlinder.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Oct 2004, Hanna Linder wrote:
> As pci_find_device is going away I have replaced this call with pci_get_device.
> If anyone has access to a Hades Atari clone to test this one I would appreciate it..

Applied, thanks!

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
