Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269617AbUICKHN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269617AbUICKHN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 06:07:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269614AbUICKEe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 06:04:34 -0400
Received: from mail.kroah.org ([69.55.234.183]:13747 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S269589AbUICKCX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 06:02:23 -0400
Date: Fri, 3 Sep 2004 11:41:13 +0200
From: Greg KH <greg@kroah.com>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: Fixes for ub in 2.4.9-rc1 from Oliver and Pat
Message-ID: <20040903094113.GD29103@kroah.com>
References: <20040830084455.54cfcc87@lembas.zaitcev.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040830084455.54cfcc87@lembas.zaitcev.lan>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 30, 2004 at 08:44:55AM -0700, Pete Zaitcev wrote:
> - Set the allocation size in REQUEST SENSE (Pat LaVarre)
> - Move add_timer invocations to safer places (Oliver Neukum)

Applied, thanks.

greg k-h

p.s. next time please add a "Signed-off-by:" line...
