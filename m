Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262137AbVDVVQh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262137AbVDVVQh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Apr 2005 17:16:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262139AbVDVVQh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Apr 2005 17:16:37 -0400
Received: from mail.kroah.org ([69.55.234.183]:13023 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262137AbVDVVQV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Apr 2005 17:16:21 -0400
Date: Fri, 22 Apr 2005 14:14:21 -0700
From: Greg KH <greg@kroah.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: luc@saillard.org, linux-kernel@vger.kernel.org, gregkh@suse.de,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [2.6 patch] drivers/usb/media/pwc/: make code static
Message-ID: <20050422211421.GB1983@kroah.com>
References: <20050418020455.GB3625@stusta.de> <20050418214738.GE5489@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050418214738.GE5489@stusta.de>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 18, 2005 at 11:47:38PM +0200, Adrian Bunk wrote:
> This patch lacked a small bit.
> 
> Updated patch below.
> 
> cu
> Adrian
> 
> 
> <--  snip  -->
> 
> 
> This patch makes needlessly global code static.


Applied, thanks.

greg k-h

