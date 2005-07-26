Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261732AbVGZMID@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261732AbVGZMID (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 08:08:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261747AbVGZMIC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 08:08:02 -0400
Received: from styx.suse.cz ([82.119.242.94]:60821 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S261732AbVGZMH2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 08:07:28 -0400
Date: Tue, 26 Jul 2005 14:07:27 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Jiri Slaby <lnx4us@gmail.com>
Cc: Jiri Slaby <jirislaby@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Obsolete files in 2.6 tree
Message-ID: <20050726120727.GA2134@ucw.cz>
References: <42DED9F3.4040300@gmail.com> <42DF6F34.4080804@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42DF6F34.4080804@gmail.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 21, 2005 at 11:47:32AM +0200, Jiri Slaby wrote:

> Jiri Slaby napsal(a):
> 
> >Are these files obsolete and could be deleted from tree.
> >Does anybody use them? Could anybody compile them?
> 
> New list should be:
> drivers/char/drm/gamma_dma.c
> drivers/char/drm/gamma_drv.c
> drivers/char/scan_keyb.c
> drivers/char/scan_keyb.h

> drivers/input/power.c

This one is partly obsolete and partly a work in progress. It's not
referenced from Kconfig at the moment, but will later in time.

> drivers/isdn/hisax/elsa_ser.c
> drivers/media/video/zr36120.c
> drivers/media/video/zr36120_i2c.c
> drivers/media/video/zr36120_mem.c
> drivers/net/wan/sdladrv.c
> drivers/scsi/NCR5380.c
> drivers/scsi/NCR5380.h
> drivers/scsi/scsi_module.c
> drivers/video/pm3fb.c
> fs/befs/attribute.c
> fs/binfmt_som.c
> sound/oss/skeleton.c

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
