Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261288AbVCAHbk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261288AbVCAHbk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 02:31:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261289AbVCAHbk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 02:31:40 -0500
Received: from mail.kroah.org ([69.55.234.183]:63403 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261288AbVCAHbj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 02:31:39 -0500
Date: Mon, 28 Feb 2005 21:43:18 -0800
From: Greg KH <greg@kroah.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: mmcclell@bigfoot.com, linux-usb-devel@lists.sourceforge.ne.kroah.org,
       linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] status of the USB ov511.c driver in kernel 2.6?
Message-ID: <20050301054318.GB2164@kroah.com>
References: <20050228224813.GT4021@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050228224813.GT4021@stusta.de>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 28, 2005 at 11:48:13PM +0100, Adrian Bunk wrote:
> I noticed the following regarding the drivers/usb/media/ov511.c driver:
> - it's not updated compared to upstream:
>   - version 1.64 is neither version 2 nor the latest 1.x version 1.65
> - there's no *_decomp.c module in the kernel sources
> 
> Are there any reasons why the upstream driver can't be resynced with the 
> kernel?

No one has sent me patches :(

greg k-h
