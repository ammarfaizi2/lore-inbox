Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263547AbTDIQPG (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 12:15:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263448AbTDIQPF (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 12:15:05 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:36236 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263365AbTDIQN3 (for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Apr 2003 12:13:29 -0400
Date: Wed, 9 Apr 2003 09:25:37 -0700
From: Greg KH <greg@kroah.com>
To: Stian Jordet <liste@jordet.nu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: i2c questions in kernel 2.5.67
Message-ID: <20030409162537.GB1518@kroah.com>
References: <1049902006.1362.6.camel@chevrolet.hybel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1049902006.1362.6.camel@chevrolet.hybel>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 09, 2003 at 05:26:46PM +0200, Stian Jordet wrote:
> Hi,
> 
> I have a Asus CUV266-DLS motherboard, with a as99127f hardware monitor
> chip. This is supposed to be supported by the W83781D sensor driver.

Does this motherboard work with this driver on 2.4?  (I'd recommend
getting the lm_sensors package from their web site to check this out.)

thanks,

greg k-h
