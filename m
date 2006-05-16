Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932165AbWEPR3t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932165AbWEPR3t (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 13:29:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932167AbWEPR3t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 13:29:49 -0400
Received: from ns.suse.de ([195.135.220.2]:61612 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932165AbWEPR3s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 13:29:48 -0400
Date: Tue, 16 May 2006 10:27:51 -0700
From: Greg KH <greg@kroah.com>
To: jayakumar.video@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] [PATCH/RFC 2.6.16.5 1/1] usb/media/quickcam_messenger driver v3
Message-ID: <20060516172751.GB17042@kroah.com>
References: <200605160348.k4G3mZDa002748@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200605160348.k4G3mZDa002748@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 16, 2006 at 11:48:35AM +0800, jayakumar.video@gmail.com wrote:
> --- linux-2.6.16.5-vanilla/drivers/usb/media/Kconfig	2006-04-15 11:02:25.000000000 +0800
> +++ linux-2.6.16.5/drivers/usb/media/Kconfig	2006-04-15 11:27:25.000000000 +0800

There is no drivers/usb/media/ directory anymore in the 2.6.17-rc kernel
tree.  Please rebase your driver on the latest kernel if you want us to
be able to apply it.

thanks,

greg k-h
