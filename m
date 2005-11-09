Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751264AbVKIHuU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751264AbVKIHuU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 02:50:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751273AbVKIHuT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 02:50:19 -0500
Received: from smtp.osdl.org ([65.172.181.4]:14014 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751264AbVKIHuR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 02:50:17 -0500
Date: Tue, 8 Nov 2005 23:50:11 -0800
From: Chris Wright <chrisw@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@suse.de>
Subject: Re: userspace block driver?
Message-ID: <20051109075011.GY7991@shell0.pdx.osdl.net>
References: <4371A4ED.9020800@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4371A4ED.9020800@pobox.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Jeff Garzik (jgarzik@pobox.com) wrote:
> Consider a block device implemented via an SSL network connection.  I 
> don't want to put SSL in the kernel, which means the only other 
> alternative is to pass data to/from a userspace daemon.

Sounds a bit like stunnel + nbd.

thanks,
-chris
