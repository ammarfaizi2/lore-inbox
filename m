Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262381AbTH0W0I (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 18:26:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262443AbTH0W0I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 18:26:08 -0400
Received: from mail.kroah.org ([65.200.24.183]:41430 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262381AbTH0WZ7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 18:25:59 -0400
Date: Wed, 27 Aug 2003 14:57:17 -0700
From: Greg KH <greg@kroah.com>
To: Vinay K Nallamothu <vinay-rc@naturesoft.net>
Cc: Trivial Patch Monkey <trivial@rustcorp.com.au>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6.0-test4][TRIVIAL][USB] digi_acceleport.c: typo fix spin_lock_irqrestore
Message-ID: <20030827215717.GA8422@kroah.com>
References: <1061648960.2787.54.camel@lima.royalchallenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1061648960.2787.54.camel@lima.royalchallenge.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 23, 2003 at 07:59:20PM +0530, Vinay K Nallamothu wrote:
> --- linux-2.6.0-test4/drivers/usb/serial/digi_acceleport.c	2003-08-23 13:14:37.000000000 +0530
> +++ linux-2.6.0-test4-nvk/drivers/usb/serial/digi_acceleport.c	2003-08-23 19:35:29.000000000 +0530

Thanks, I've applied this to my trees.

greg k-h
