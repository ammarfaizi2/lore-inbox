Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262854AbVAFO4L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262854AbVAFO4L (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 09:56:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262851AbVAFOyc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 09:54:32 -0500
Received: from mproxy.gmail.com ([216.239.56.243]:6113 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262849AbVAFOyV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 09:54:21 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=NW3NC7vKpzmQ5wlsGyP8gj4x15+a++EIaCtmw/qTqw6cAYEB+ZY7n8kBgMSFTxoFK9AuXVcyH3ZVPc53NGUblrKNOzunxSFFvw8qIRq0QK+bbXOHOSKrMz7oOyhf73WUibmH+XabGepYZdFE3McueJQg5xbsZvHxfmX0wO7BQXQ=
Message-ID: <21d7e997050106065439d94d1@mail.gmail.com>
Date: Fri, 7 Jan 2005 01:54:20 +1100
From: Dave Airlie <airlied@gmail.com>
Reply-To: Dave Airlie <airlied@gmail.com>
To: Juri Prokofjev <devel@unix.ee>
Subject: Re: 2.6.10-mm2
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0501061203550.12136@jazz.unix.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050106002240.00ac4611.akpm@osdl.org>
	 <Pine.LNX.4.61.0501061203550.12136@jazz.unix.ee>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> drivers/char/drm/gamma_drv.c:39:22: drm_auth.h: No such file or directory
> drivers/char/drm/gamma_drv.c:40:28: drm_agpsupport.h: No such file or
> directory
> drivers/char/drm/gamma_drv.c:41:22: drm_bufs.h: No such file or directory
> In file included from drivers/char/drm/gamma_drv.c:42:
> drivers/char/drm/gamma_context.h: In function
> `gamma_context_switch_complete':
> ...
> drivers/char/drm/gamma_drv.c:43:21: drm_dma.h: No such file or
> directory
> In file included from drivers/char/drm/gamma_drv.c:44:
> drivers/char/drm/gamma_old_dma.h: In function `gamma_clear_next_buffer':
> ..
> drivers/char/drm/gamma_drv.c:45:26: drm_drawable.h: No such file or
> directory
> drivers/char/drm/gamma_drv.c:46:21: drm_drv.h: No such file or directory
> drivers/char/drm/gamma_drv.c:48:22: drm_fops.h: No such file or directory
> drivers/char/drm/gamma_drv.c:49:22: drm_init.h: No such file or directory
> drivers/char/drm/gamma_drv.c:50:23: drm_ioctl.h: No such file or directory
> drivers/char/drm/gamma_drv.c:51:21: drm_irq.h: No such file or directory
> ...
> drivers/char/drm/gamma_drv.c:53:22: drm_lock.h: No such file or directory

gamma drm is marked as broken with good reason..

Dave.
