Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261223AbUKEVxS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261223AbUKEVxS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 16:53:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261221AbUKEVxS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 16:53:18 -0500
Received: from mail.kroah.org ([69.55.234.183]:1434 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261213AbUKEVwO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 16:52:14 -0500
Date: Fri, 5 Nov 2004 13:47:39 -0800
From: Greg KH <greg@kroah.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Chris Gauthron <chrisg@0-in.com>, phil@netroedge.com,
       sensors@stimpy.netroedge.com, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] i2c it87.c: remove an unused function
Message-ID: <20041105214739.GF1750@kroah.com>
References: <20041028222039.GO3207@stusta.de> <20041029001745.GI29142@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041029001745.GI29142@stusta.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 29, 2004 at 02:17:45AM +0200, Adrian Bunk wrote:
> [ this time without the problems due to a digital signature... ]
> 
> The patch below removes an unused function from drivers/i2c/chips/it87.c
> 
> 
> diffstat output:
>  drivers/i2c/chips/it87.c |    7 -------
>  1 files changed, 7 deletions(-)
> 
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Applied, thanks.

greg k-h

