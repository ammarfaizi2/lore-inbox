Return-Path: <linux-kernel-owner+willy=40w.ods.org-S385949AbUKBAoJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S385949AbUKBAoJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 19:44:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S387371AbUKBAoI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 19:44:08 -0500
Received: from mail.kroah.org ([69.55.234.183]:39847 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S387352AbUKBAns (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 19:43:48 -0500
Date: Mon, 1 Nov 2004 16:39:24 -0800
From: Greg KH <greg@kroah.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: kjsisson@bellsouth.net, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] USB stv680.c: remove an unused function
Message-ID: <20041102003924.GF18961@kroah.com>
References: <20041028232817.GM3207@stusta.de> <20041029002950.GF29142@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041029002950.GF29142@stusta.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 29, 2004 at 02:29:50AM +0200, Adrian Bunk wrote:
> [ this time without the problems due to a digital signature... ]
> 
> The patch below removes an unused function from 
> drivers/usb/media/stv680.c
> 
> 
> diffstat output:
>  drivers/usb/media/stv680.c |    6 ------
>  1 files changed, 6 deletions(-)
> 
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Applied, thanks.

greg k-h
