Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261445AbTHSUzK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 16:55:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261336AbTHSUyh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 16:54:37 -0400
Received: from mail.kroah.org ([65.200.24.183]:15255 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261445AbTHSUyM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 16:54:12 -0400
Date: Tue, 19 Aug 2003 13:53:56 -0700
From: Greg KH <greg@kroah.com>
To: Stian Jordet <liste@jordet.nu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Can't read fan-speeds from i2c
Message-ID: <20030819205356.GA5968@kroah.com>
References: <1061324213.708.6.camel@chevrolet.hybel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1061324213.708.6.camel@chevrolet.hybel>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 19, 2003 at 10:16:53PM +0200, Stian Jordet wrote:
> Hi,
> 
> I have a Asus CUV266-DLS, which uses the as99127f chipset. Everything
> seems to work as it is supposed to, except for fan-speeds. They say 0.
> Is that supposed behaviour since the as99127f doesn't have any
> datasheets, or am I doing something wrong?

What kernel version are you using?

thanks,

greg k-h
