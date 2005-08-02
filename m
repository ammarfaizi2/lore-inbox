Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261839AbVHBVWn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261839AbVHBVWn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 17:22:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261875AbVHBVWe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 17:22:34 -0400
Received: from mail.kroah.org ([69.55.234.183]:48519 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261863AbVHBVUZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 17:20:25 -0400
Date: Tue, 2 Aug 2005 14:18:56 -0700
From: Greg KH <greg@kroah.com>
To: jamey@crl.dec.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: **SPAM** [PATCH 3/3] usb gadget driver for MQ11xx graphics chip
Message-ID: <20050802211856.GA8590@kroah.com>
References: <20050802192047.0995AB4A11@lspace.crl.dec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050802192047.0995AB4A11@lspace.crl.dec.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


3/3?  I seem to be missing the other two patches...

On Tue, Aug 02, 2005 at 03:20:47PM -0400, jamey@crl.dec.com wrote:
> 
> This patch adds USB gadget support for the USB peripheral controller
> on the MQ11xx graphics chip.
> 
> Signed-off-by: Jamey Hicks <jamey@handhelds.org>
> Signed-off-by: Andrew Zabolotny <anpaza@mail.ru>

This should be sent to the linux-usb-devel mailing list, so the usb
gadget maintainer and other developers can review it.

thanks,

greg k-h
