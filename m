Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262336AbVGZXSh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262336AbVGZXSh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 19:18:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262343AbVGZXQc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 19:16:32 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:18879 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262341AbVGZXQQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 19:16:16 -0400
Subject: Re: Obsolete files in 2.6 tree
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Jiri Slaby <lnx4us@gmail.com>, Jiri Slaby <jirislaby@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050726120727.GA2134@ucw.cz>
References: <42DED9F3.4040300@gmail.com> <42DF6F34.4080804@gmail.com>
	 <20050726120727.GA2134@ucw.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 27 Jul 2005 00:40:44 +0100
Message-Id: <1122421245.2542.35.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > drivers/char/drm/gamma_dma.c
> > drivers/char/drm/gamma_drv.c

Gamma is defunct certainly

> > drivers/media/video/zr36120.c
> > drivers/media/video/zr36120_i2c.c
> > drivers/media/video/zr36120_mem.c

Being discussed on the V4L list

> > drivers/scsi/NCR5380.c
> > drivers/scsi/NCR5380.h

These are used - check your scripts handle .c includes

> > fs/binfmt_som.c

pa-risc

> > sound/oss/skeleton.c

Reference for writing drivers

