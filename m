Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261179AbVFMSQO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261179AbVFMSQO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 14:16:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261154AbVFMSQN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 14:16:13 -0400
Received: from mail.kroah.org ([69.55.234.183]:19605 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261179AbVFMSQC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 14:16:02 -0400
Date: Mon, 13 Jun 2005 11:13:23 -0700
From: Greg KH <gregkh@suse.de>
To: Armin Schindler <armin@melware.de>
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Remove devfs_mk_cdev() function from the kernel tree
Message-ID: <20050613181323.GA13025@kroah.com>
References: <11184761113499@kroah.com> <Pine.LNX.4.61.0506121042420.30907@phoenix.one.melware.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0506121042420.30907@phoenix.one.melware.de>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 12, 2005 at 10:44:04AM +0200, Armin Schindler wrote:
> It didn't follow the development, is devfs now obsolete in kernel?
> If not, these funktions still makes sense.

I'm guessing you missed the [00/22] announcement of this patch?  Please
see that one for links to the issues surrounding this topic.

thanks,

greg k-h
