Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270040AbUJSWsq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270040AbUJSWsq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 18:48:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270048AbUJSWmy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 18:42:54 -0400
Received: from mail.kroah.org ([69.55.234.183]:8327 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S270040AbUJSWis (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 18:38:48 -0400
Date: Tue, 19 Oct 2004 15:28:23 -0700
From: Greg KH <greg@kroah.com>
To: Ben Dooks <ben-linux@fluff.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] S3C2410 I2C Bus driver
Message-ID: <20041019222823.GF9521@kroah.com>
References: <20041017191011.GA17551@home.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041017191011.GA17551@home.fluff.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 17, 2004 at 08:10:11PM +0100, Ben Dooks wrote:
> Bus driver for the Samsung S3C2410 SoC onboard I2C controller
> 
> 	Signed-off-by: Ben Dooks <ben-linux@fluff.org>
> 
>  Files affected:
>    drivers/i2c/busses/Kconfig       |    7 	7 +	0 -	0 !
>    drivers/i2c/busses/Makefile      |    1 	1 +	0 -	0 !
>    drivers/i2c/busses/i2c-s3c2410.c |  877 	877 +	0 -	0 !
>    3 files changed, 885 insertions(+)

Applied, thanks.

greg k-h

