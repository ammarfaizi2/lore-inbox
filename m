Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262714AbTGTGLT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jul 2003 02:11:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262385AbTGTGLS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jul 2003 02:11:18 -0400
Received: from mail.kroah.org ([65.200.24.183]:40867 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262714AbTGTGLQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jul 2003 02:11:16 -0400
Date: Sat, 19 Jul 2003 23:25:52 -0700
From: Greg KH <greg@kroah.com>
To: Jeff Garzik <jgarzik@pobox.com>, tgraf@suug.ch
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [Fwd: [PATCH] missing __KERNEL__ ifdef in include/linux/device.h]
Message-ID: <20030720062552.GA4678@kroah.com>
References: <3F1A139B.3090708@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F1A139B.3090708@pobox.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 19, 2003 at 11:59:23PM -0400, Jeff Garzik wrote:

> Subject: [PATCH] missing __KERNEL__ ifdef in include/linux/device.h

Ick, I don't want to see the "No kernel headers in userspace programs"
thread again.

So don't do it, device.h doesn't need to be changed.

thanks,

greg k-h
