Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315758AbSGAQW3>; Mon, 1 Jul 2002 12:22:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315784AbSGAQW2>; Mon, 1 Jul 2002 12:22:28 -0400
Received: from ns.suse.de ([213.95.15.193]:53764 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S315758AbSGAQW1>;
	Mon, 1 Jul 2002 12:22:27 -0400
Date: Mon, 1 Jul 2002 18:24:55 +0200
From: Hubert Mantel <mantel@suse.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Happy Hacking Keyboard Lite Mk 2 USB Problems with 2.4.18.
Message-ID: <20020701162452.GL18550@suse.de>
References: <mailman.1025521441.28343.linux-kernel2news@redhat.com> <200207011516.g61FGnP20648@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200207011516.g61FGnP20648@devserv.devel.redhat.com>
User-Agent: Mutt/1.4i
Organization: SuSE Linux AG, Nuernberg, Germany
X-Operating-System: SuSE Linux - Kernel 2.4.18-4GB
X-GPG-Key: 1024D/B0DFF780
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jul 01, Pete Zaitcev wrote:

> At the very minimum I would like to see all distros, and
> especially SuSE (because of Vojtech) to stop shipping usbkbd.o.

Mandelbrot:~ # zgrep CONFIG_USB_KBD /proc/config.gz 
# CONFIG_USB_KBD is not set

> -- Pete
                                                                  -o)
    Hubert Mantel              Goodbye, dots...                   /\\
                                                                 _\_v

