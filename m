Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932569AbWEXEhe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932569AbWEXEhe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 00:37:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932570AbWEXEhe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 00:37:34 -0400
Received: from mail.kroah.org ([69.55.234.183]:54965 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932569AbWEXEhd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 00:37:33 -0400
Date: Tue, 23 May 2006 21:30:50 -0700
From: Greg KH <greg@kroah.com>
To: Jeff Garzik <jeff@garzik.org>
Cc: Greg KH <gregkh@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [Fwd: [PATCH] Revive pci_find_ext_capability]
Message-ID: <20060524043050.GA6231@kroah.com>
References: <4473DFFB.1030100@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4473DFFB.1030100@garzik.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 24, 2006 at 12:24:27AM -0400, Jeff Garzik wrote:
> FYI...  I'll be applying this via netdev, since the Myri net driver 
> requires it.

That's fine with me, feel free to add a:

	Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

from me for it when you do.

thanks,

greg k-h
